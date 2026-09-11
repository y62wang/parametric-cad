# Compact v2.2 badminton racket rack

The v2.2 rack stores ten badminton rackets on one centred line and attaches to
either IKEA SKÅDIS or Multiboard through an interchangeable mounting back. It
is shorter and narrower than v2.1 while retaining the reviewed 28 mm arm
height, 8 mm heel and 8 mm mounting-back thickness.

The default body alternates its insertion sides:

`left, right, left, right, left, right, left, right, left, right`

All ten pocket centres remain at X = 0, so the seated shafts are centred and
aligned. Each pocket has one assigned entry side. Opening both sides of every
pocket would disconnect the one-piece arm; true two-sided access to each
individual pocket requires moving or removable gates.

## What changed from v2.1

| Feature | v2.1 | v2.2 | Change |
|---|---:|---:|---:|
| Racket pitch | 24.5 mm | 20 mm | −18.4% |
| Projection | 246.4 mm | 205.4 mm | −41 mm |
| Longest body print axis | 249.4 mm | 208.4 mm | −41 mm |
| Arm width | 25.8 mm | 22 mm | −14.7% |
| Body heel width | 120 mm | 92 mm | −23.3% |
| SKÅDIS back width | 140 mm | 100 mm | −28.6% |
| Multiboard back width | 130 mm | 100 mm | −23.1% |

The 20 mm pitch is intentionally compact and must be checked with real
rackets. Print the three-slot spacing coupon before committing to the full
body. Grip shape, cone size, overgrip thickness and frame geometry vary between
rackets even when the shaft itself fits the 8.8 mm pocket.

## Recommended v2.2 files

- `files/badminton_universal_body_10_alternating.3mf` — alternating body,
  beginning on the left.
- `files/badminton_universal_body_10_alternating_reverse.3mf` — alternating
  body, beginning on the right.
- `files/badminton_universal_body_10_all_left_v2_2.3mf` — all-left body.
- `files/badminton_universal_body_10_all_right_v2_2.3mf` — all-right body.
- `files/badminton_skadis_back_v2.3mf` — 100 mm SKÅDIS back with three
  gravity-latching hooks.
- `files/badminton_multiboard_back_v2.3mf` — 100 mm Multiboard back with four
  mounting positions.
- `files/skadis_fit_coupon_v2.3mf` — full-pattern SKÅDIS connector coupon.
- `files/multiboard_spacing_coupon_v2.3mf` — full-pattern Multiboard spacing
  coupon.
- `files/badminton_racket_spacing_coupon_20mm_v2_2.3mf` — three-slot racket
  spacing coupon using the final body geometry.
- `src/badminton_hook.scad` — editable parametric source.
- `tests/test_dimensions.scad` — dimensional, pattern and clearance checks.

The top-level `files/` directory contains only these nine recommended v2.2
exports.

## Archived files and incompatibility warning

**Do not mix any archived body, mounting back or fit coupon with current v2.2
parts.** The heel, positive key, M4 positions, mounting-back dimensions and
connector patterns changed between revisions. Archived files are retained only
for reprinting a complete matching historical assembly or for reference.

`files/archive/v1/` contains the eight incompatible early exports:

- `badminton_hook.3mf`
- `badminton_universal_body_10.3mf`
- `badminton_universal_body_10_left.3mf`
- `badminton_universal_body_10_right.3mf`
- `badminton_skadis_back.3mf`
- `badminton_multiboard_back.3mf`
- `skadis_fit_coupon.3mf`
- `multiboard_spacing_coupon.3mf`

`files/archive/v2.0/` remains unchanged and contains:

- `badminton_universal_body_10_alternating.3mf`
- `badminton_universal_body_10_alternating_reverse.3mf`
- `badminton_skadis_back_v2.3mf`
- `badminton_multiboard_back_v2.3mf`
- `skadis_fit_coupon_v2.3mf`
- `multiboard_spacing_coupon_v2.3mf`

Superseded v2.1 previews and explicitly v2.1-named all-left/all-right exports
remain in Git history rather than another archive.

## Preview files

Current v2.2 previews are stored directly in `previews/`:

- `v2_2_alternating_left_side.png`
- `v2_2_alternating_right_side.png`
- `v2_2_assembled_skadis.png`
- `v2_2_assembled_multiboard.png`
- `v2_2_body_print_orientation.png`
- `v2_2_skadis_back_rear.png`
- `v2_2_skadis_engagement.png`
- `v2_2_multiboard_board_side.png`
- `v2_2_multiboard_interface_side.png`
- `v2_2_racket_spacing_coupon.png`

The Multiboard board-side preview shows exactly the four actual board mounting
positions. The separately labelled body-facing interface preview also shows
the four blind heat-set insert openings and positive-key recess; those features
are not additional Multiboard mounting positions.

The SKÅDIS engagement preview uses a transparent board, outlined slot edges and
a rear oblique view. All three orange tongues extend below their slot edges
after lowering, while the highlighted neck sections remain inside the slots.

The `previews/legacy-v1/` and `previews/legacy-v2.0/` directories remain
unchanged.

## Main dimensions

| Feature | Nominal dimension |
|---|---:|
| Racket capacity | 10 |
| Pocket centres | X = 0; Y = 17 + i × 20 mm |
| First/last pocket centre | Y = 17/197 mm |
| Nominal shaft diameter | 7.2 mm |
| Pocket diameter | 8.8 mm |
| Snap opening | 6.6 mm |
| Opposite-side ligament | 6.6 mm |
| Arm section | 22 × 28 mm |
| Arm position when mounted | Z = 32..60 mm |
| Body heel | 92 × 60 × 8 mm |
| Root flare | 60 mm |
| Projection | 205.4 mm |
| Longest body print axis | 208.4 mm |
| Nominal coplanar print contact | approximately 3,814 mm² |
| Positive interface key | 48 × 30 × 3 mm |
| SKÅDIS back | 100 × 72 × 8 mm |
| Multiboard back | 100 × 72 × 8 mm |

The root transition and gussets end at Y = 12 mm, leaving 0.6 mm before the
first pocket. Do not reduce the arm, heel, root flare or back thickness without
reassessing the load path.

## Entry options

The source parameter `entry_pattern` accepts:

- `"alternating"` — five left and five right openings.
- `"left"` — all ten openings on the left.
- `"right"` — all ten openings on the right.

Set `reverse_alternating = true` to begin the alternating sequence on the
right. Every option uses the same ten pocket coordinates.

## Body-to-back interface

The 48 × 30 × 3 mm positive key carries interface shear. Four M4 screws at
X = ±30 mm and Z = 18/45 mm retain the body. Each mounting back has tapered
blind pockets for nominal 5.7 × 6 mm M4 heat-set inserts.

Starting hardware:

- Four M4 × 10 socket-head screws.
- Four nominal 5.7 × 6 mm M4 heat-set inserts.

The reviewed geometry leaves:

- 11.9 mm from each outer body counterbore to the heel side.
- 13.9 mm and 10.9 mm below and above the body counterbores.
- 2.8 mm between the insert cavities and the key recess.
- At least approximately 3.15 mm between a Multiboard counterbore and the
  nearest insert cavity.
- 3.55 mm between the lower Multiboard counterbores and key recess.

Hardware dimensions vary. Measure the purchased inserts and screw heads before
printing the complete assembly. Install inserts from the front face of the
mounting back and fully seat the key before tightening the screws evenly.

## SKÅDIS mounting back

The 100 × 72 × 8 mm SKÅDIS back has:

- Three unchanged gravity-latching hook profiles at X = −40, 0 and 40 mm.
- 40 mm hook pitch over an 80 mm span.
- One hook row at Z = 58 mm.
- A 4.2 mm hook width for nominal 5 mm slots.
- A 12 mm downward tongue, 4 mm neck and chamfered insertion edge.
- Three aligned upper bearing pads.
- Three lower compression pads at X = −30, 0 and 30 mm near Z = 10 mm.

The outer hooks retain 7.9 mm of plate edge material. The outer upper pads
retain 4 mm. Do not narrow the back or hook profile.

The source models a nominal 3.0 mm board with 0.4 mm running clearance. Print
`skadis_fit_coupon_v2.3mf` first. Insert all three tongues through one aligned
slot row, bring the coupon against the board and lower it until all three necks
seat. Do not force the coupon. Actual SKÅDIS board thickness and slot
tolerances must be checked physically.

## Multiboard mounting back

The 100 × 72 × 8 mm Multiboard back uses four positions:

- X = −25 and 25 mm.
- Z = 11 and 61 mm.
- 50 × 50 mm centre spacing.

Use official locking or Small Thread Multipoint hardware suited to the
installed tile and load. The model does not include copied friction pegs.
Print `multiboard_spacing_coupon_v2.3mf` to confirm the hole spacing and
selected hardware before printing the full back.

## Three-slot racket spacing coupon

`badminton_racket_spacing_coupon_20mm_v2_2.3mf` is a support-free,
56.8 mm-long section with three centred pockets. It uses:

- The exact 20 mm body pitch.
- The exact 8.8 mm pocket diameter.
- The exact 6.6 mm entry opening.
- The exact 22 × 28 mm arm section.
- Left/right/left insertion.

Fit three representative rackets at the same time. Check that the shafts seat
without excessive force and that grips, cones and frames do not touch in the
intended hanging orientation. Test the largest or most heavily overgripped
rackets in the collection.

## Print orientation and settings

Suggested starting settings for load-bearing parts:

- PETG or ASA.
- 0.20 mm layer height.
- At least six perimeters and six top/bottom layers.
- 35–45% cubic or gyroid infill.
- Dry filament and calibrated extrusion.

The body export is inverted relative to its mounted orientation. The heel and
arm tops are both at Z = 60 mm in the assembled model, so inversion places
both broad surfaces on the build plate. The supplied body is support-free and
has a 208.4 mm longest print axis.

Print the SKÅDIS back and connector coupon on their long edge so the hook
profiles lie in the layer plane. Use a brim if needed and inspect the hook
starts in the slicer. Print the Multiboard back, Multiboard coupon and racket
spacing coupon flat.

## Physical test workflow

1. Print and test the three-slot racket spacing coupon with real rackets.
2. Print the connector coupon for the chosen board.
3. Confirm every connector engages together without forcing or rocking.
4. Print the selected back and install all board hardware.
5. Install the body-interface inserts and dry-fit the key and screws.
6. Mount the empty assembly and inspect for board flex, lift-off, insert
   movement or cracking.
7. Add rackets gradually, beginning near the mounting back.
8. Supervise proof loads of 1 kg, 2 kg and 3 kg at the final slot. A 3 kg tip
   load produces approximately 6.0 N·m at the mounting interface.
9. Remove the load immediately if anything moves or creaks. Inspect the board,
   hooks, inserts and printed layers again after a 24-hour intended-load test.

The printed rack is not structurally certified. Filament, layer adhesion,
creep, heat-set insert pull-out, actual pegboard strength, wall anchoring and
the full ten-racket load still require physical validation.

## OpenSCAD render modes

| Mode | Output |
|---|---|
| `body_alternating` | Alternating body beginning on the left |
| `body_alternating_reverse` | Alternating body beginning on the right |
| `body_left` | All-left body |
| `body_right` | All-right body |
| `skadis_back_v2` | SKÅDIS mounting back |
| `multiboard_back_v2` | Multiboard mounting back |
| `assembled_skadis_v2` | Alternating body on the SKÅDIS back |
| `assembled_multiboard_v2` | Alternating body on the Multiboard back |
| `skadis_coupon_v2` | Full-pattern SKÅDIS connector coupon |
| `multiboard_coupon_v2` | Full-pattern Multiboard spacing coupon |
| `racket_spacing_coupon_v2_2` | Three-slot 20 mm racket spacing coupon |
| `body_print_preview` | Support-free body build-plate view |
| `skadis_back_rear_preview` | Rear SKÅDIS connector view |
| `multiboard_board_side_preview` | Board side with four actual Multiboard mounts |
| `multiboard_interface_side_preview` | Body-facing key, inserts and through-holes |
| `skadis_engagement_preview` | Rear transparent view of all three lowered SKÅDIS hooks |
| `racket_spacing_coupon_preview` | Clean spacing coupon view |
| `none` | No source geometry; used by tests |

Compatibility aliases for earlier mode names remain in the source.
`multiboard_back_preview` now maps to the four-hole board-side view.
`alignment_preview` shows only the printable alternating body and contains no
shaft guides.

Run the dimensional suite from this directory:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings \
  -D 'render_mode="none"' \
  -o /tmp/badminton_dimensions.stl \
  tests/test_dimensions.scad
```

A successful run echoes `V2_2_DIMENSION_TESTS_PASSED`.
