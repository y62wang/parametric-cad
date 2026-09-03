# Parametric OpenSCAD Screw Library

Files:

- `screw_engine.scad` — reusable geometry generator.
- `screw_database.scad` — data-only screw specifications.
- `example_two_screws.scad` — renders two different screws.

## Usage

```scad
include <screw_engine.scad>
include <screw_database.scad>

screw(deck_8x1_25);

translate([18, 0, 0])
    screw(construction_10x3);
```

## Add another screw

Only add another config array to `screw_database.scad`:

```scad
my_new_screw = [
    ["id", "my_new_screw"],
    ["total_length", 50],
    ["shank_d", 4.5],
    ["shank_len", 10],

    ["thread_major_d", 5.0],
    ["thread_root_d", 3.5],
    ["thread_pitch", 2.0],
    ["thread_profile", "wood"],
    ["threading", "full"],

    ["head_type", "flat"],
    ["head_d", 9],
    ["head_h", 3],
    ["head_angle", 82],

    ["drive_type", "torx"],
    ["drive_size", "T25"],
    ["drive_radius", 1.8],
    ["drive_depth", 1.7],

    ["tip_type", "gimlet"],
    ["tip_len", 4]
];
```

Then:

```scad
screw(my_new_screw);
```

No geometry code needs to change.
