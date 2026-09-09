# Parametric desk and drawer organizer system

A configurable OpenSCAD toolkit for building matching organizer boxes, trays,
holders, and layouts. Dimensions, corner radii, wall thicknesses, inserts, and
spacing are controlled through compact specification lists, making it easy to
create a coordinated set instead of remodeling every container from scratch.

## Highlights

- Plain boxes plus circular, rectangular, card-slot, and cradle inserts.
- Automatic bottom-left packing within a print bed or drawer region.
- Collision and connectivity checks for multi-container layouts.
- Optional finger notches, labels, drain holes, and per-corner radii.
- Configurable global defaults for wall, floor, spacing, and printer size.
- Included 15-slot pen, marker, or toothbrush holder.

## Included printable

The supplied `pen_holder_3x5.3mf` has:

| Feature | Dimension |
|---|---:|
| Overall size | 60 × 96 × 50 mm |
| Openings | 15 |
| Opening diameter | 15 mm |
| Grid | 3 × 5 |
| Border and spacing | 3 mm |

## Files

- `src/organizer_config.scad` — global defaults and printer dimensions.
- `src/organizer_box.scad` — box and insert geometry.
- `src/organizer_layout.scad` — placement, collision, and layout tools.
- `src/example_desk_tray.scad` — multi-container example.
- `src/pen_holder_3x5.scad` — printable 15-slot holder.
- `files/pen_holder_3x5.3mf` — ready-to-slice holder export.
- `tests/` — dimension and insert examples used for OpenSCAD validation.

## Recommended print settings

- Material: PLA for general indoor use; PETG for bathrooms or humid spaces.
- Layer height: 0.20 mm.
- Walls: 3.
- Infill: 10–20%.
- Supports: none for the included pen holder.
- Brim: normally unnecessary.

## Customization

Start with `src/example_desk_tray.scad` for a multi-container layout or
`src/pen_holder_3x5.scad` for a focused example. Change the outer dimensions,
insert type, item size, spacing, row/column count, and corner radius, then
render and export from OpenSCAD.

Run the project tests from the repository root:

```bash
./projects/parametric-desk-organizer/tests/run_tests.sh
```

## Validation status

The included 3MF is a one-part manifold mesh. The OpenSCAD test files validate
representative dimensions and render each supported insert family.
