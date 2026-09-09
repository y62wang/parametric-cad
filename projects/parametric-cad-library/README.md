# Parametric fastener and build-plate library

A reusable OpenSCAD toolkit for generating screw geometry from compact
configuration records and arranging repeated parts on a printer bed. It keeps
dimensions and standards data separate from geometry, so adding a screw size
does not require remodeling it from scratch.

## Highlights

- Config-driven screw length, shank, thread, head, drive, and tip geometry.
- Included ANSI B18.6.1 wood-screw dimension table.
- Ready-made deck, construction, and standard wood-screw configurations.
- Grid, strip, and zone packing helpers for repeated parts.
- Centralized printer-bed size, edge margin, and item spacing.
- Extensible roadmap for holes, inserts, joints, enclosures, and hardware.

## Files

- `src/screw_engine.scad` — reusable screw geometry generator.
- `src/screw_database.scad` — data-only screw configurations.
- `src/pack_utils.scad` — grid, strip, and zone packing modules.
- `src/plate_config.scad` — printer-bed dimensions and packing defaults.
- `src/example_two_screws.scad` — renders two configurations with one engine.
- `src/example_bed_fill.scad` — demonstrates repeated-part bed packing.
- `data/wood_screws_ANSI_B18.6.1.csv` — source dimensions by screw gauge.
- `BACKLOG.md` — roadmap for the broader parametric component library.

## Usage

Open a file from the `src/` directory or include the engine and database in
another OpenSCAD model:

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

For repeated parts, edit `src/plate_config.scad`, then use `grid_pack`,
`strip_pack`, or `zone_pack` from `src/pack_utils.scad`.

## Recommended print settings

- Use printed screws as fit prototypes or light-duty custom parts unless the
  material and load case have been physically qualified.
- Start at 0.16–0.20 mm layers with at least four walls.
- Print screws upright for the cleanest circular profile, then inspect layer
  adhesion and tip stability in the slicer.
- Use a brim for tall, narrow screws.

## Customization

Add or copy a configuration in `src/screw_database.scad`. The key parameters
control total length, shank diameter, thread diameters and pitch, head style,
drive recess, and tip geometry. Printer-bed dimensions and packing clearances
are independent in `src/plate_config.scad`.

## Validation and limitations

Both included examples render successfully as manifold solids with OpenSCAD's
Manifold backend. Thread engagement, dimensional fit, torque capacity, creep,
and suitability for structural fastening still require physical testing.
