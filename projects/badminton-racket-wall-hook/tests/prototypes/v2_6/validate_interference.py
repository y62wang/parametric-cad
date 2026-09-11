#!/usr/bin/env python3
"""Validate assembled v2.6 clearances using generated OpenSCAD Booleans."""

from __future__ import annotations

import math
import shutil
import struct
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[3]
HARNESS = Path(__file__).with_name("test_interference.scad")
LEAD_IN_SAMPLES = (52.48, 53.0, 53.5, 53.98, 54.02)
CONTACT_Z = 18.0
SPAN_TOLERANCE = 1e-6
VOLUME_TOLERANCE = 1e-7


@dataclass(frozen=True)
class MeshEvidence:
    empty: bool
    triangles: int
    minimum: tuple[float, float, float] | None
    maximum: tuple[float, float, float] | None
    size: tuple[float, float, float] | None
    signed_volume: float

    @property
    def has_positive_volume(self) -> bool:
        if self.empty or self.size is None:
            return False
        spans_volume = all(
            dimension > SPAN_TOLERANCE
            for dimension in self.size
        )
        return (
            spans_volume
            and abs(self.signed_volume) > VOLUME_TOLERANCE
        )


def triangle_signed_volume(
    first: tuple[float, float, float],
    second: tuple[float, float, float],
    third: tuple[float, float, float],
) -> float:
    cross = (
        second[1] * third[2] - second[2] * third[1],
        second[2] * third[0] - second[0] * third[2],
        second[0] * third[1] - second[1] * third[0],
    )
    return (
        first[0] * cross[0]
        + first[1] * cross[1]
        + first[2] * cross[2]
    ) / 6.0


def parse_ascii_stl(
    data: bytes,
) -> list[
    tuple[
        tuple[float, float, float],
        tuple[float, float, float],
        tuple[float, float, float],
    ]
]:
    vertices = []
    for raw_line in data.decode("utf-8").splitlines():
        parts = raw_line.strip().split()
        if len(parts) == 4 and parts[0] == "vertex":
            vertices.append(tuple(float(value) for value in parts[1:]))
    if len(vertices) % 3:
        raise ValueError(
            f"ASCII STL contains {len(vertices)} ungrouped vertices"
        )
    return [
        (
            vertices[index],
            vertices[index + 1],
            vertices[index + 2],
        )
        for index in range(0, len(vertices), 3)
    ]


def parse_binary_stl(
    data: bytes,
) -> list[
    tuple[
        tuple[float, float, float],
        tuple[float, float, float],
        tuple[float, float, float],
    ]
]:
    if len(data) < 84:
        raise ValueError("binary STL is shorter than its header")
    triangle_count = struct.unpack_from("<I", data, 80)[0]
    expected_size = 84 + triangle_count * 50
    if len(data) != expected_size:
        raise ValueError(
            f"binary STL size is {len(data)}, expected {expected_size}"
        )

    triangles = []
    offset = 84
    for _ in range(triangle_count):
        values = struct.unpack_from("<12fH", data, offset)
        triangles.append(
            (
                (values[3], values[4], values[5]),
                (values[6], values[7], values[8]),
                (values[9], values[10], values[11]),
            )
        )
        offset += 50
    return triangles


def read_stl(path: Path) -> MeshEvidence:
    data = path.read_bytes()
    if data.lstrip().startswith(b"solid"):
        triangles = parse_ascii_stl(data)
    else:
        triangles = parse_binary_stl(data)

    if not triangles:
        return MeshEvidence(True, 0, None, None, None, 0.0)

    vertices = [
        vertex
        for triangle in triangles
        for vertex in triangle
    ]
    minimum = tuple(
        min(vertex[axis] for vertex in vertices)
        for axis in range(3)
    )
    maximum = tuple(
        max(vertex[axis] for vertex in vertices)
        for axis in range(3)
    )
    size = tuple(
        maximum[axis] - minimum[axis]
        for axis in range(3)
    )
    signed_volume = sum(
        triangle_signed_volume(*triangle)
        for triangle in triangles
    )
    return MeshEvidence(
        False,
        len(triangles),
        minimum,
        maximum,
        size,
        signed_volume,
    )


def run_boolean(
    openscad: str,
    output_directory: Path,
    case: str,
    sample_z: float | None = None,
) -> MeshEvidence:
    suffix = (
        f"_{sample_z:.2f}".replace(".", "_")
        if sample_z is not None
        else ""
    )
    output = output_directory / f"{case}{suffix}.stl"
    command = [
        openscad,
        "--backend",
        "Manifold",
        "-D",
        'render_mode="none"',
        "-D",
        f'interference_case="{case}"',
    ]
    if sample_z is not None:
        command.extend(["-D", f"sample_z={sample_z:.5f}"])
    command.extend(["-o", str(output), str(HARNESS)])

    completed = subprocess.run(
        command,
        cwd=PROJECT_ROOT,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    if output.is_file() and output.stat().st_size > 0:
        return read_stl(output)
    if "Current top level object is empty." in completed.stdout:
        return MeshEvidence(True, 0, None, None, None, 0.0)
    raise RuntimeError(
        f"OpenSCAD did not produce interpretable output for {case}:\n"
        f"{completed.stdout}"
    )


def format_evidence(evidence: MeshEvidence) -> str:
    if evidence.empty:
        return "empty"
    assert evidence.minimum is not None
    assert evidence.maximum is not None
    assert evidence.size is not None
    bounds = " x ".join(
        f"{dimension:.9f}"
        for dimension in evidence.size
    )
    return (
        f"{evidence.triangles} triangles; spans {bounds} mm; "
        f"signed volume {evidence.signed_volume:.12g} mm^3"
    )


def require_zero_positive_volume(
    label: str,
    evidence: MeshEvidence,
    failures: list[str],
) -> None:
    print(f"{label}: {format_evidence(evidence)}")
    if evidence.has_positive_volume:
        failures.append(
            f"{label} has positive intersection volume: "
            f"{format_evidence(evidence)}"
        )


def main() -> int:
    openscad = shutil.which("openscad")
    if openscad is None:
        print("OpenSCAD is not available", file=sys.stderr)
        return 1
    if not HARNESS.is_file():
        print(f"missing harness: {HARNESS}", file=sys.stderr)
        return 1

    failures: list[str] = []
    with tempfile.TemporaryDirectory(
        prefix="badminton_v2_6_interference_"
    ) as temporary_directory:
        output_directory = Path(temporary_directory)

        rails_heel = run_boolean(
            openscad,
            output_directory,
            "rails_vs_channelled_heel",
        )
        require_zero_positive_volume(
            "rails vs channelled heel",
            rails_heel,
            failures,
        )

        clip_body = run_boolean(
            openscad,
            output_directory,
            "clip_vs_body",
        )
        require_zero_positive_volume(
            "clip vs body",
            clip_body,
            failures,
        )

        clip_rails = run_boolean(
            openscad,
            output_directory,
            "clip_vs_rails",
        )
        require_zero_positive_volume(
            "clip vs rails",
            clip_rails,
            failures,
        )
        if clip_rails.empty:
            failures.append(
                "clip vs rails did not preserve the intended Z=18 "
                "contact surface"
            )
        else:
            assert clip_rails.minimum is not None
            assert clip_rails.maximum is not None
            if not (
                math.isclose(
                    clip_rails.minimum[2],
                    CONTACT_Z,
                    abs_tol=SPAN_TOLERANCE,
                )
                and math.isclose(
                    clip_rails.maximum[2],
                    CONTACT_Z,
                    abs_tol=SPAN_TOLERANCE,
                )
            ):
                failures.append(
                    "clip vs rails contact is not confined to Z=18: "
                    f"{clip_rails.minimum[2]:.9f}.."
                    f"{clip_rails.maximum[2]:.9f}"
                )

        for sample_z in LEAD_IN_SAMPLES:
            containment = run_boolean(
                openscad,
                output_directory,
                "lead_in_containment",
                sample_z,
            )
            require_zero_positive_volume(
                f"lead-in outside channel at Z={sample_z:.2f}",
                containment,
                failures,
            )

    if failures:
        print("\nINTERFERENCE VALIDATION FAILED", file=sys.stderr)
        for failure in failures:
            print(f"- {failure}", file=sys.stderr)
        return 1

    print(
        "\nV2_6_ASSEMBLED_INTERFERENCE_VALIDATION_PASSED"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
