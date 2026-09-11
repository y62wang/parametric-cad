#!/usr/bin/env python3
"""Validate the printable v2.3 prototype 3MF meshes with the Python stdlib."""

from __future__ import annotations

import argparse
import collections
import math
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree


EXPECTED_COMPONENTS = {
    "v2_3_tolerance_matrix_fixture.3mf": 18,
    "v2_3_tolerance_matrix_collars.3mf": 9,
    "v2_3_tolerance_matrix_cradle.3mf": 1,
    "v2_3_structural_coupon_body.3mf": 4,
    "v2_3_structural_coupon_collars.3mf": 3,
    "v2_3_structural_coupon_cradle.3mf": 1,
    "v2_3_skadis_back_two_hook.3mf": 1,
    "v2_3_multiboard_back_centred.3mf": 1,
    "v2_3_skadis_fit_coupon_two_hook.3mf": 1,
    "v2_3_multiboard_fit_coupon_50x50.3mf": 1,
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


def load_mesh(path: Path) -> tuple[list[tuple[float, float, float]], list[tuple[int, int, int]]]:
    with zipfile.ZipFile(path) as archive:
        model_names = [
            name for name in archive.namelist() if name.lower().endswith(".model")
        ]
        if len(model_names) != 1:
            raise ValueError(f"expected one .model file, found {model_names}")
        root = ElementTree.fromstring(archive.read(model_names[0]))

    vertices: list[tuple[float, float, float]] = []
    triangles: list[tuple[int, int, int]] = []

    for mesh in (element for element in root.iter() if local_name(element.tag) == "mesh"):
        mesh_vertices = next(
            child for child in mesh if local_name(child.tag) == "vertices"
        )
        mesh_triangles = next(
            child for child in mesh if local_name(child.tag) == "triangles"
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
    edge_counts: collections.Counter[tuple[int, int]] = collections.Counter()

    for triangle in triangles:
        a, b, c = triangle
        if a == b or b == c or c == a:
            raise ValueError(f"degenerate indexed triangle {triangle}")
        used_vertices.update(triangle)
        union_find.union(a, b)
        union_find.union(b, c)
        for first, second in ((a, b), (b, c), (c, a)):
            edge_counts[tuple(sorted((first, second)))] += 1

    component_roots = {union_find.find(vertex) for vertex in used_vertices}
    boundary_edges = sum(count == 1 for count in edge_counts.values())
    nonmanifold_edges = sum(count > 2 for count in edge_counts.values())
    xs = [vertex[0] for vertex in vertices]
    ys = [vertex[1] for vertex in vertices]
    zs = [vertex[2] for vertex in vertices]
    minimum = (min(xs), min(ys), min(zs))
    maximum = (max(xs), max(ys), max(zs))
    size = tuple(maximum[index] - minimum[index] for index in range(3))

    return {
        "vertices": len(vertices),
        "triangles": len(triangles),
        "components": len(component_roots),
        "boundary_edges": boundary_edges,
        "nonmanifold_edges": nonmanifold_edges,
        "closed_manifold": boundary_edges == 0 and nonmanifold_edges == 0,
        "minimum": minimum,
        "maximum": maximum,
        "size": size,
        "min_z_zero": math.isclose(minimum[2], 0.0, abs_tol=1e-6),
    }


def format_vector(values: tuple[float, float, float]) -> str:
    return " x ".join(f"{value:.3f}" for value in values)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "directory",
        nargs="?",
        type=Path,
        default=Path("files/prototypes/v2.3"),
    )
    arguments = parser.parse_args()

    failures: list[str] = []
    print(
        "file | bounds XYZ mm | components | triangles | closed/manifold | minZ=0"
    )
    print("-" * 112)

    for filename, expected_components in EXPECTED_COMPONENTS.items():
        path = arguments.directory / filename
        if not path.is_file():
            failures.append(f"missing {path}")
            continue
        try:
            result = analyse(path)
        except Exception as error:  # noqa: BLE001 - validator must report every file
            failures.append(f"{filename}: {error}")
            continue

        component_ok = result["components"] == expected_components
        closed_ok = bool(result["closed_manifold"])
        min_z_ok = bool(result["min_z_zero"])
        min_z_result = (
            "yes"
            if min_z_ok
            else f"NO ({result['minimum'][2]:.6f})"
        )
        print(
            f"{filename} | {format_vector(result['size'])} | "
            f"{result['components']} ({'OK' if component_ok else f'expected {expected_components}'}) | "
            f"{result['triangles']} | "
            f"{'yes' if closed_ok else 'NO'} | "
            f"{min_z_result}"
        )

        if not component_ok:
            failures.append(
                f"{filename}: expected {expected_components} components, "
                f"found {result['components']}"
            )
        if not closed_ok:
            failures.append(
                f"{filename}: boundary edges={result['boundary_edges']}, "
                f"non-manifold edges={result['nonmanifold_edges']}"
            )
        if not min_z_ok:
            failures.append(
                f"{filename}: minimum Z is {result['minimum'][2]:.6f}, not 0"
            )

    if failures:
        print("\nVALIDATION FAILED", file=sys.stderr)
        for failure in failures:
            print(f"- {failure}", file=sys.stderr)
        return 1

    print("\nV2_3_PROTOTYPE_MESH_VALIDATION_PASSED")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
