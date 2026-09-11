#!/usr/bin/env python3
"""Validate v2.5 3MF meshes and protected v2.2-v2.4 assets with the stdlib."""

from __future__ import annotations

import argparse
import collections
import hashlib
import math
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree


EXPECTED_COMPONENTS = {
    "v2_5_connected_body_start_left.3mf": 1,
    "v2_5_connected_body_start_right.3mf": 1,
    "v2_5_skadis_back_two_hook.3mf": 1,
    "v2_5_multiboard_back_two_point.3mf": 1,
    "v2_5_skadis_fit_coupon_two_hook.3mf": 1,
    "v2_5_multiboard_fit_coupon_two_point_50mm.3mf": 1,
    "v2_5_three_slot_alternating_coupon.3mf": 1,
}
PRINT_BED_XY = (256.0, 256.0)
PROJECT_ROOT = Path(__file__).resolve().parents[3]
PROTECTED_MANIFEST = Path(__file__).with_name(
    "protected_v2_2_v2_3_v2_4.sha256"
)
EXPECTED_PROTECTED_ASSET_COUNT = 66


class UnionFind:
    def __init__(self, size: int) -> None:
        self.parent = list(range(size))
        self.rank = [0] * size

    def find(self, item: int) -> int:
        while self.parent[item] != item:
            self.parent[item] = self.parent[self.parent[item]]
            item = self.parent[item]
        return item

    def union(self, left: int, right: int) -> None:
        left_root = self.find(left)
        right_root = self.find(right)
        if left_root == right_root:
            return
        if self.rank[left_root] < self.rank[right_root]:
            left_root, right_root = right_root, left_root
        self.parent[right_root] = left_root
        if self.rank[left_root] == self.rank[right_root]:
            self.rank[left_root] += 1


def local_name(tag: str) -> str:
    return tag.rsplit("}", 1)[-1]


def load_mesh(
    path: Path,
) -> tuple[
    list[tuple[float, float, float]],
    list[tuple[int, int, int]],
]:
    with zipfile.ZipFile(path) as archive:
        model_names = [
            name
            for name in archive.namelist()
            if name.lower().endswith(".model")
        ]
        if len(model_names) != 1:
            raise ValueError(
                f"expected one .model file, found {model_names}"
            )
        root = ElementTree.fromstring(archive.read(model_names[0]))

    vertices: list[tuple[float, float, float]] = []
    triangles: list[tuple[int, int, int]] = []

    meshes = (
        element
        for element in root.iter()
        if local_name(element.tag) == "mesh"
    )
    for mesh in meshes:
        mesh_vertices = next(
            child
            for child in mesh
            if local_name(child.tag) == "vertices"
        )
        mesh_triangles = next(
            child
            for child in mesh
            if local_name(child.tag) == "triangles"
        )
        offset = len(vertices)
        for vertex in mesh_vertices:
            vertices.append(
                (
                    float(vertex.attrib["x"]),
                    float(vertex.attrib["y"]),
                    float(vertex.attrib["z"]),
                )
            )
        for triangle in mesh_triangles:
            triangles.append(
                (
                    offset + int(triangle.attrib["v1"]),
                    offset + int(triangle.attrib["v2"]),
                    offset + int(triangle.attrib["v3"]),
                )
            )

    if not vertices or not triangles:
        raise ValueError("3MF contains no mesh triangles")
    return vertices, triangles


def analyse(path: Path) -> dict[str, object]:
    vertices, triangles = load_mesh(path)
    union_find = UnionFind(len(vertices))
    used_vertices: set[int] = set()
    edge_counts: collections.Counter[tuple[int, int]] = (
        collections.Counter()
    )

    for triangle in triangles:
        a, b, c = triangle
        if a == b or b == c or c == a:
            raise ValueError(f"degenerate indexed triangle {triangle}")
        used_vertices.update(triangle)
        union_find.union(a, b)
        union_find.union(b, c)
        for first, second in ((a, b), (b, c), (c, a)):
            edge_counts[tuple(sorted((first, second)))] += 1

    component_roots = {
        union_find.find(vertex)
        for vertex in used_vertices
    }
    boundary_edges = sum(
        count == 1 for count in edge_counts.values()
    )
    nonmanifold_edges = sum(
        count > 2 for count in edge_counts.values()
    )
    xs = [vertex[0] for vertex in vertices]
    ys = [vertex[1] for vertex in vertices]
    zs = [vertex[2] for vertex in vertices]
    minimum = (min(xs), min(ys), min(zs))
    maximum = (max(xs), max(ys), max(zs))
    size = tuple(
        maximum[index] - minimum[index]
        for index in range(3)
    )

    return {
        "vertices": len(vertices),
        "triangles": len(triangles),
        "components": len(component_roots),
        "boundary_edges": boundary_edges,
        "nonmanifold_edges": nonmanifold_edges,
        "closed_manifold":
            boundary_edges == 0 and nonmanifold_edges == 0,
        "minimum": minimum,
        "maximum": maximum,
        "size": size,
        "min_z_zero": math.isclose(
            minimum[2],
            0.0,
            abs_tol=1e-6,
        ),
    }


def format_vector(
    values: tuple[float, float, float],
) -> str:
    return " x ".join(f"{value:.3f}" for value in values)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(
            lambda: handle.read(1024 * 1024),
            b"",
        ):
            digest.update(block)
    return digest.hexdigest()


def verify_protected_assets() -> list[str]:
    failures: list[str] = []
    if not PROTECTED_MANIFEST.is_file():
        return [
            f"missing protected-asset manifest "
            f"{PROTECTED_MANIFEST}"
        ]

    checked = 0
    for line_number, raw_line in enumerate(
        PROTECTED_MANIFEST.read_text(
            encoding="utf-8"
        ).splitlines(),
        start=1,
    ):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        try:
            expected_digest, relative_path = line.split(
                maxsplit=1
            )
        except ValueError:
            failures.append(
                f"{PROTECTED_MANIFEST.name}:{line_number}: "
                "malformed entry"
            )
            continue

        path = PROJECT_ROOT / relative_path.strip()
        if not path.is_file():
            failures.append(
                f"protected asset is missing: {relative_path}"
            )
            continue

        actual_digest = sha256(path)
        if actual_digest != expected_digest:
            failures.append(
                f"protected asset changed: {relative_path} "
                f"(expected {expected_digest}, "
                f"got {actual_digest})"
            )
        checked += 1

    if checked != EXPECTED_PROTECTED_ASSET_COUNT:
        failures.append(
            "protected manifest checked "
            f"{checked} assets; expected "
            f"{EXPECTED_PROTECTED_ASSET_COUNT}"
        )
    else:
        print(
            "Protected v2.2-v2.4 assets: "
            f"{checked} checked"
        )
    return failures


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "directory",
        nargs="?",
        type=Path,
        default=Path("files/prototypes/v2.5"),
    )
    arguments = parser.parse_args()

    failures = verify_protected_assets()
    print(
        "file | bounds XYZ mm | components | triangles | "
        "closed/manifold | minZ=0 | bed"
    )
    print("-" * 128)

    for filename, expected_components in EXPECTED_COMPONENTS.items():
        path = arguments.directory / filename
        if not path.is_file():
            failures.append(f"missing {path}")
            continue
        try:
            result = analyse(path)
        except Exception as error:  # noqa: BLE001
            failures.append(f"{filename}: {error}")
            continue

        component_ok = (
            result["components"] == expected_components
        )
        closed_ok = bool(result["closed_manifold"])
        min_z_ok = bool(result["min_z_zero"])
        bed_ok = (
            result["size"][0] <= PRINT_BED_XY[0] + 1e-6
            and result["size"][1] <= PRINT_BED_XY[1] + 1e-6
        )
        min_z_result = (
            "yes"
            if min_z_ok
            else f"NO ({result['minimum'][2]:.6f})"
        )
        print(
            f"{filename} | "
            f"{format_vector(result['size'])} | "
            f"{result['components']} "
            f"({'OK' if component_ok else f'expected {expected_components}'}) | "
            f"{result['triangles']} | "
            f"{'yes' if closed_ok else 'NO'} | "
            f"{min_z_result} | "
            f"{'yes' if bed_ok else 'NO'}"
        )

        if not component_ok:
            failures.append(
                f"{filename}: expected "
                f"{expected_components} components, found "
                f"{result['components']}"
            )
        if not closed_ok:
            failures.append(
                f"{filename}: boundary edges="
                f"{result['boundary_edges']}, "
                f"non-manifold edges="
                f"{result['nonmanifold_edges']}"
            )
        if not min_z_ok:
            failures.append(
                f"{filename}: minimum Z is "
                f"{result['minimum'][2]:.6f}, not 0"
            )
        if not bed_ok:
            failures.append(
                f"{filename}: XY bounds "
                f"{result['size'][0]:.3f} x "
                f"{result['size'][1]:.3f} exceed "
                f"{PRINT_BED_XY[0]:.0f} x "
                f"{PRINT_BED_XY[1]:.0f} mm"
            )

    if failures:
        print("\nVALIDATION FAILED", file=sys.stderr)
        for failure in failures:
            print(f"- {failure}", file=sys.stderr)
        return 1

    print(
        "\nV2_5_CONNECTED_ZIGZAG_MESH_VALIDATION_PASSED"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
