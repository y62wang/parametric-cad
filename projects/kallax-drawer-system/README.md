# Modular Kallax four-drawer system

A parametric component kit for building four shallow drawers inside one IKEA
Kallax cube. Oversized panels are split into printable lap-jointed halves, while
separate corner connectors and dovetail rail modules provide the structural and
sliding hardware.

## Current status

This project is a work in progress. The source modules and sample 3MF exports
are printable, but the complete four-drawer installation has not yet been
assembled or physically validated. Review [`SPEC.md`](SPEC.md) before printing
the full set.

## Highlights

- Designed around a 335 × 335 × 390 mm Kallax opening.
- Four nominal 330 × 380 × 80 mm drawers.
- Long panels split into halves that fit a 256 mm bed.
- Overlapping lap joints with optional alignment pins.
- Flat-splice and 90° corner connectors for 5–6 mm boards.
- Modular printed dovetail rail channel and tongue.
- Most components print flat without supports.

## Files

- `SPEC.md` — target dimensions, quantities, hardware, and open decisions.
- `src/drawer_board.scad` — printable panel halves with lap joints.
- `src/drawer_connectors.scad` — flat-splice and corner connectors.
- `src/drawer_rail.scad` — dovetail rail channel and tongue.
- `files/board_half_a.3mf` and `files/board_half_b.3mf` — sample panel halves.
- `files/flat_splice.3mf` — sample flat connectors.
- `files/corner_joint.3mf` — sample 90° connector.

The current 3MF files are component demonstrations, not the complete quantity
needed for four drawers.

## Recommended print settings

- Material: PETG preferred for connectors and rails.
- Layer height: 0.20–0.28 mm.
- Walls: 4–5.
- Infill: 30–40% gyroid for connectors; 15–25% for panel sections.
- Supports: none for the documented flat orientations.
- Rail surfaces: use a fine layer height and lubricate with candle wax, PTFE,
  or dry soap after assembly.

## Assembly concept

1. Print matching A and B halves for every panel.
2. Slide the lap joints together, engaging the alignment pins.
3. Glue the lap joints if a permanent drawer is desired.
4. Join front, back, and side panels with corner connectors and M3 hardware.
5. Attach rail tongues to the drawer bottoms and rail channels to the Kallax
   floor or divider shelves.
6. Check slide clearance and add a pull-out stop before loading a drawer.

## Remaining design decisions

- Final drawer-front style and handle.
- Flush versus projecting front face.
- Rail stop mechanism.
- Divider-shelf mounting and complete load test.
