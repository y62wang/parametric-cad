#!/usr/bin/env python3
"""Validate, regenerate and compare the complete v2.7 printable package."""

from __future__ import annotations

import argparse
import collections
import hashlib
import json
import math
import os
import shutil
import struct
import subprocess
import sys
import tempfile
import zipfile
from dataclasses import dataclass
from pathlib import Path
from xml.etree import ElementTree


@dataclass(frozen=True)
class ExportRecipe:
    filename: str
    mode: str
    components: int = 1
    defines: tuple[tuple[str, float], ...] = ()


def decimal_token(value: float, places: int) -> str:
    return f"{value:.{places}f}".replace(".", "p")


SHARED_EXPORT_RECIPES = (
    ExportRecipe(
        "v2_7_connected_body_start_left.3mf",
        "body_start_left",
    ),
    ExportRecipe(
        "v2_7_connected_body_start_right.3mf",
        "body_start_right",
    ),
    ExportRecipe(
        "v2_7_anti_lift_clip.3mf",
        "anti_lift_clip",
    ),
    ExportRecipe(
        "v2_7_dovetail_tolerance_coupon_020_030_040.3mf",
        "dovetail_tolerance_coupon",
        4,
    ),
    ExportRecipe(
        "v2_7_skadis_hook_width_coupon_40_42_44.3mf",
        "skadis_hook_width_coupon",
        3,
    ),
    ExportRecipe(
        "v2_7_skadis_board_capture_coupon_26_30_40_50.3mf",
        "skadis_board_capture_coupon",
        4,
    ),
    ExportRecipe(
        "v2_7_skadis_two_hook_pattern_coupon_40mm.3mf",
        "skadis_two_hook_pattern_coupon",
    ),
    ExportRecipe(
        "v2_7_multiboard_catch_tolerance_coupon_735_760_785.3mf",
        "multiboard_catch_tolerance_coupon",
        6,
    ),
    ExportRecipe(
        "v2_7_multiboard_retention_depth_coupon_5_6_7mm.3mf",
        "multiboard_retention_depth_coupon",
        6,
    ),
    ExportRecipe(
        "v2_7_multiboard_two_catch_pattern_coupon_50mm.3mf",
        "multiboard_two_catch_pattern_coupon",
    ),
    ExportRecipe(
        "v2_7_three_pocket_racket_coupon_21mm.3mf",
        "three_pocket_racket_coupon",
    ),
)

SKADIS_EXPORT_RECIPES = tuple(
    ExportRecipe(
        "v2_7_skadis_back_"
        f"hook{decimal_token(hook_width, 1)}_"
        f"board{decimal_token(board_thickness, 1)}_"
        "clear0p4.3mf",
        "skadis_back",
        defines=(
            ("selected_skadis_hook_w", hook_width),
            ("selected_skadis_board_t", board_thickness),
            ("selected_skadis_board_clearance", 0.4),
        ),
    )
    for hook_width in (4.0, 4.2, 4.4)
    for board_thickness in (2.6, 3.0, 4.0, 5.0)
)

MULTIBOARD_EXPORT_RECIPES = tuple(
    ExportRecipe(
        "v2_7_multiboard_back_"
        f"catch{decimal_token(catch_span, 2)}_"
        f"board{decimal_token(board_thickness, 1)}_"
        f"shoulder{decimal_token(board_thickness + 0.35, 2)}.3mf",
        "multiboard_back",
        defines=(
            ("selected_multiboard_catch_span", catch_span),
            ("selected_multiboard_board_t", board_thickness),
            (
                "selected_multiboard_shoulder_depth",
                board_thickness + 0.35,
            ),
            (
                "selected_multiboard_rear_clearance",
                9.0 - board_thickness,
            ),
        ),
    )
    for catch_span in (7.35, 7.60, 7.85)
    for board_thickness in (5.0, 6.0, 7.0)
)

EXPORT_RECIPES = (
    SHARED_EXPORT_RECIPES
    + SKADIS_EXPORT_RECIPES
    + MULTIBOARD_EXPORT_RECIPES
)
EXPECTED_COMPONENTS = {
    recipe.filename: recipe.components
    for recipe in EXPORT_RECIPES
}
EXPECTED_PREVIEWS = {
    "v2_7_assembled_skadis_clean.png",
    "v2_7_rear_skadis_exactly_two_hooks.png",
    "v2_7_skadis_engagement_transparent.png",
    "v2_7_assembled_multiboard_clean.png",
    "v2_7_rear_multiboard_exactly_two_catches.png",
    "v2_7_multiboard_section_proxy_hole.png",
    "v2_7_exploded_slide_lock.png",
    "v2_7_centred_ten_position_sawtooth.png",
    "v2_7_print_orientations.png",
}
EXPECTED_PREVIEW_SIZE = (1600, 1000)
PRINT_BED_XY = (256.0, 256.0)
PROJECT_ROOT = Path(__file__).resolve().parents[3]
PREVIEW_DIRECTORY = (
    PROJECT_ROOT / "previews/prototype-v2.7"
)
SOURCE = (
    PROJECT_ROOT
    / "src/prototypes/v2_7_dual_board_screwless.scad"
)
README = PROJECT_ROOT / "README.md"
PROJECT_GITIGNORE = PROJECT_ROOT / ".gitignore"
PROTECTED_MANIFEST = Path(__file__).with_name(
    "protected_v2_2_v2_3_v2_4_v2_5_v2_6.sha256"
)
EXPECTED_PROTECTED_ASSET_COUNT = 101
REQUIRED_CACHE_IGNORE_PATTERNS = {
    "__pycache__/",
    "*.py[cod]",
    ".pytest_cache/",
    ".mypy_cache/",
    ".ruff_cache/",
}
FORBIDDEN_SOURCE_MARKERS = (
    "m4_",
    "body_fastener_void",
    "heat_insert_void",
    "interface_recess_void",
    "shear_key",
    "counterbore_void",
    "official_snap_mesh",
)
REQUIRED_SOURCE_MARKERS = (
    'multiboard_support_required = true',
    'multiboard_support_strategy =',
    '"painted_organic_axial_undersides_only"',
    'multiboard_support_type = "organic_tree"',
    "multiboard_support_build_plate_only = true",
    "selected_skadis_hook_w",
    "selected_multiboard_catch_span",
    "skadis_neck_seating_chamfer_height",
    '"width_aware_chamfer_to_rounded_slot"',
)
CANONICAL_V2_6_GEOMETRY = {
    "v2_7_connected_body_start_left.3mf":
        "files/prototypes/v2.6/"
        "v2_6_connected_body_start_left_screwless.3mf",
    "v2_7_connected_body_start_right.3mf":
        "files/prototypes/v2.6/"
        "v2_6_connected_body_start_right_screwless.3mf",
    "v2_7_anti_lift_clip.3mf":
        "files/prototypes/v2.6/v2_6_anti_lift_clip.3mf",
}


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
    int,
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
    mesh_count = 0

    for mesh in (
        element
        for element in root.iter()
        if local_name(element.tag) == "mesh"
    ):
        mesh_count += 1
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
    return vertices, triangles, mesh_count


def analyse(path: Path) -> dict[str, object]:
    vertices, triangles, mesh_count = load_mesh(path)
    union_find = UnionFind(len(vertices))
    used_vertices: set[int] = set()
    edge_counts: collections.Counter[tuple[int, int]] = (
        collections.Counter()
    )

    for triangle in triangles:
        first, second, third = triangle
        if first == second or second == third or third == first:
            raise ValueError(f"degenerate indexed triangle {triangle}")
        used_vertices.update(triangle)
        union_find.union(first, second)
        union_find.union(second, third)
        for edge_start, edge_end in (
            (first, second),
            (second, third),
            (third, first),
        ):
            edge_counts[tuple(sorted((edge_start, edge_end)))] += 1

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
        "mesh_count": mesh_count,
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


def canonical_geometry_digest(path: Path) -> tuple[str, int]:
    vertices, triangles, _ = load_mesh(path)
    canonical_faces = []
    for triangle in triangles:
        points = [
            tuple(round(value, 6) for value in vertices[index])
            for index in triangle
        ]
        canonical_faces.append(tuple(sorted(points)))
    payload = json.dumps(
        sorted(canonical_faces),
        separators=(",", ":"),
    ).encode("utf-8")
    return hashlib.sha256(payload).hexdigest(), len(triangles)


def verify_source_contract() -> list[str]:
    if not SOURCE.is_file():
        return [f"missing v2.7 source: {SOURCE}"]

    source_text = SOURCE.read_text(encoding="utf-8").lower()
    failures = []
    for marker in FORBIDDEN_SOURCE_MARKERS:
        if marker in source_text:
            failures.append(
                f"forbidden fastener/official-mesh marker "
                f"in v2.7 source: {marker}"
            )
    for marker in REQUIRED_SOURCE_MARKERS:
        if marker.lower() not in source_text:
            failures.append(
                f"required parameter/export marker is missing "
                f"from v2.7 source: {marker}"
            )
    for contradiction in (
        "recommended_back_supports = false",
        "multiboard_support_required = false",
    ):
        if contradiction in source_text:
            failures.append(
                "contradictory Multiboard support flag remains "
                f"in v2.7 source: {contradiction}"
            )
    if not failures:
        print(
            "v2.7 source: dual-board, screwless, independently "
            "modelled and explicit about targeted Multiboard support"
        )
    return failures


def verify_documentation_contract() -> list[str]:
    if not README.is_file():
        return [f"missing project README: {README}"]

    v2_7_section = README.read_text(
        encoding="utf-8"
    ).split("\n## v2.6", maxsplit=1)[0]
    lowered = v2_7_section.lower()
    failures: list[str] = []

    for required_text in (
        "painted organic/tree support",
        "build plate only",
        "0.20 mm",
        "0.35 mm",
        "12%",
        "selected_skadis_hook_w",
        "selected_multiboard_catch_span",
        "width-aware chamfer",
        "all 12 SKÅDIS",
    ):
        if required_text.lower() not in lowered:
            failures.append(
                "v2.7 README omits required support/parameter "
                f"documentation: {required_text}"
            )

    for contradiction in (
        "support-free",
        "generated supports remain disabled",
        "recommended_back_supports=false",
    ):
        if contradiction in lowered:
            failures.append(
                "v2.7 README retains contradictory support text: "
                f"{contradiction}"
            )

    for recipe in EXPORT_RECIPES:
        if recipe.filename not in v2_7_section:
            failures.append(
                "v2.7 README inventory omits "
                f"{recipe.filename}"
            )

    if not failures:
        print(
            "v2.7 README: targeted support and all "
            f"{len(EXPORT_RECIPES)} export recipes documented"
        )
    return failures


def verify_cache_hygiene() -> list[str]:
    failures: list[str] = []
    if not PROJECT_GITIGNORE.is_file():
        return [f"missing project .gitignore: {PROJECT_GITIGNORE}"]

    ignore_patterns = {
        line.strip()
        for line in PROJECT_GITIGNORE.read_text(
            encoding="utf-8"
        ).splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    }
    missing_patterns = (
        REQUIRED_CACHE_IGNORE_PATTERNS - ignore_patterns
    )
    for pattern in sorted(missing_patterns):
        failures.append(
            f"project .gitignore does not ignore cache: {pattern}"
        )

    cache_directories = {
        "__pycache__",
        ".pytest_cache",
        ".mypy_cache",
        ".ruff_cache",
    }
    for path in PROJECT_ROOT.rglob("*"):
        if path.is_dir() and path.name in cache_directories:
            failures.append(f"cache directory remains: {path}")
        elif (
            path.is_file()
            and path.suffix.lower() in {".pyc", ".pyo"}
        ):
            failures.append(f"Python cache file remains: {path}")

    if not failures:
        print(
            "Project cache hygiene: ignore rules present; "
            "no cache artefacts found"
        )
    return failures


def verify_canonical_v2_6_geometry(
    directory: Path,
) -> list[str]:
    failures: list[str] = []
    for v2_7_name, relative_v2_6_path in (
        CANONICAL_V2_6_GEOMETRY.items()
    ):
        current_path = directory / v2_7_name
        protected_path = PROJECT_ROOT / relative_v2_6_path
        if not current_path.is_file():
            failures.append(
                f"missing v2.7 canonical comparison mesh: "
                f"{current_path}"
            )
            continue
        if not protected_path.is_file():
            failures.append(
                f"missing protected v2.6 canonical mesh: "
                f"{protected_path}"
            )
            continue
        current_digest = canonical_geometry_digest(
            current_path
        )
        protected_digest = canonical_geometry_digest(
            protected_path
        )
        if current_digest != protected_digest:
            failures.append(
                f"{v2_7_name}: canonical geometry differs from "
                f"{relative_v2_6_path}"
            )
        else:
            print(
                f"Canonical v2.6 geometry preserved: "
                f"{v2_7_name} "
                f"({current_digest[1]} triangles)"
            )
    return failures


def scad_literal(value: float) -> str:
    return f"{value:.6f}".rstrip("0").rstrip(".")


def verify_source_parity(directory: Path) -> list[str]:
    openscad = shutil.which("openscad")
    if openscad is None:
        return ["OpenSCAD is unavailable for source-parity exports"]

    failures: list[str] = []
    environment = os.environ.copy()
    environment["TERM"] = "dumb"
    environment["NO_COLOR"] = "1"

    with tempfile.TemporaryDirectory(
        prefix="badminton_v2_7_source_parity_"
    ) as temporary_directory:
        temporary_path = Path(temporary_directory)

        for recipe in EXPORT_RECIPES:
            committed_path = directory / recipe.filename
            generated_path = temporary_path / recipe.filename
            if not committed_path.is_file():
                failures.append(
                    "source parity cannot compare missing package file: "
                    f"{committed_path}"
                )
                continue

            command = [
                openscad,
                "--hardwarnings",
                "--backend",
                "Manifold",
                "-D",
                f'render_mode="{recipe.mode}"',
            ]
            for name, value in recipe.defines:
                command.extend(
                    ["-D", f"{name}={scad_literal(value)}"]
                )
            command.extend(
                ["-o", str(generated_path), str(SOURCE)]
            )
            completed = subprocess.run(
                command,
                cwd=PROJECT_ROOT,
                env=environment,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                check=False,
            )
            if (
                completed.returncode != 0
                or "ERROR:" in completed.stdout
                or not generated_path.is_file()
                or generated_path.stat().st_size == 0
            ):
                failures.append(
                    f"{recipe.filename}: OpenSCAD regeneration failed\n"
                    f"{completed.stdout.strip()}"
                )
                continue

            generated_digest = canonical_geometry_digest(
                generated_path
            )
            committed_digest = canonical_geometry_digest(
                committed_path
            )
            if generated_digest != committed_digest:
                failures.append(
                    f"{recipe.filename}: committed geometry does not "
                    "match current source and recipe "
                    f"(generated {generated_digest}, "
                    f"committed {committed_digest})"
                )
            else:
                print(
                    "Source parity: "
                    f"{recipe.filename} "
                    f"({generated_digest[1]} triangles)"
                )

    if not failures:
        print(
            "Current-source parity: "
            f"{len(EXPORT_RECIPES)} regenerated 3MFs match"
        )
    return failures


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
            "Protected v2.2-v2.6 assets: "
            f"{checked} checked"
        )
    return failures


def verify_inventory(directory: Path) -> list[str]:
    actual = {
        path.name
        for path in directory.glob("*.3mf")
        if path.is_file()
    }
    expected = set(EXPECTED_COMPONENTS)
    failures = []
    for missing in sorted(expected - actual):
        failures.append(f"missing {directory / missing}")
    for unexpected in sorted(actual - expected):
        failures.append(
            f"unexpected v2.7 3MF in package: {unexpected}"
        )
    return failures


def png_size(path: Path) -> tuple[int, int]:
    data = path.read_bytes()[:24]
    if (
        len(data) != 24
        or data[:8] != b"\x89PNG\r\n\x1a\n"
        or data[12:16] != b"IHDR"
    ):
        raise ValueError("not a valid PNG header")
    return struct.unpack(">II", data[16:24])


def verify_previews() -> list[str]:
    failures: list[str] = []
    actual = {
        path.name
        for path in PREVIEW_DIRECTORY.glob("*.png")
        if path.is_file()
    }
    for missing in sorted(EXPECTED_PREVIEWS - actual):
        failures.append(
            f"missing preview: {PREVIEW_DIRECTORY / missing}"
        )
    for unexpected in sorted(actual - EXPECTED_PREVIEWS):
        failures.append(
            f"unexpected v2.7 preview: {unexpected}"
        )

    checked = 0
    for filename in sorted(EXPECTED_PREVIEWS):
        path = PREVIEW_DIRECTORY / filename
        if not path.is_file():
            continue
        try:
            size = png_size(path)
        except Exception as error:  # noqa: BLE001
            failures.append(f"{filename}: {error}")
            continue
        if size != EXPECTED_PREVIEW_SIZE:
            failures.append(
                f"{filename}: image size is {size}, expected "
                f"{EXPECTED_PREVIEW_SIZE}"
            )
        if path.stat().st_size < 10_000:
            failures.append(
                f"{filename}: preview is unexpectedly small "
                f"({path.stat().st_size} bytes)"
            )
        checked += 1

    if checked == len(EXPECTED_PREVIEWS):
        print(
            f"v2.7 previews: {checked} checked at "
            f"{EXPECTED_PREVIEW_SIZE[0]} x "
            f"{EXPECTED_PREVIEW_SIZE[1]}"
        )
    return failures


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "directory",
        nargs="?",
        type=Path,
        default=Path("files/prototypes/v2.7"),
    )
    arguments = parser.parse_args()

    failures = []
    failures.extend(verify_source_contract())
    failures.extend(verify_documentation_contract())
    failures.extend(verify_cache_hygiene())
    failures.extend(verify_protected_assets())
    failures.extend(verify_inventory(arguments.directory))
    failures.extend(verify_previews())
    failures.extend(
        verify_canonical_v2_6_geometry(
            arguments.directory
        )
    )
    failures.extend(
        verify_source_parity(arguments.directory)
    )

    print(
        "file | bounds XYZ mm | mesh objects | components | "
        "triangles | closed/manifold | minZ=0 | bed"
    )
    print("-" * 150)

    for filename, expected_components in EXPECTED_COMPONENTS.items():
        path = arguments.directory / filename
        if not path.is_file():
            continue
        try:
            result = analyse(path)
        except Exception as error:  # noqa: BLE001
            failures.append(f"{filename}: {error}")
            continue

        mesh_count_ok = result["mesh_count"] == 1
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
            f"{result['mesh_count']} "
            f"({'OK' if mesh_count_ok else 'expected 1'}) | "
            f"{result['components']} "
            f"({'OK' if component_ok else f'expected {expected_components}'}) | "
            f"{result['triangles']} | "
            f"{'yes' if closed_ok else 'NO'} | "
            f"{min_z_result} | "
            f"{'yes' if bed_ok else 'NO'}"
        )

        if not mesh_count_ok:
            failures.append(
                f"{filename}: expected one mesh object, found "
                f"{result['mesh_count']}"
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
        "\nV2_7_DUAL_BOARD_SCREWLESS_MESH_VALIDATION_PASSED"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
