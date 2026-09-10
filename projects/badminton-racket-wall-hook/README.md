# Compact v2.1 badminton racket rack

The recommended v2.1 design stores ten badminton rackets on one centred line
and uses a compact interchangeable back for IKEA SKÅDIS or Multiboard. Its
default entry sequence is:

`left, right, left, right, left, right, left, right, left, right`

This gives rack-level access from both sides. Each individual pocket still has
one assigned insertion side. Cutting both sides of every pocket would sever the
one-piece arm into separate sections; true per-pocket bilateral access needs
moving or removable gates. The robust one-piece choices supplied here are
all-left, all-right or alternating entry.

All v2 geometry is independently modelled from the dimensions in this source.

## Recommended v2 files

- `files/badminton_universal_body_10_alternating.3mf` — default alternating
  body, beginning on the left.
- `files/badminton_universal_body_10_alternating_reverse.3mf` — mirrored
  alternating sequence, beginning on the right.
- `files/badminton_universal_body_10_all_left_v2_1.3mf` — all-left v2.1
  body.
- `files/badminton_universal_body_10_all_right_v2_1.3mf` — all-right v2.1
  body.
- `files/badminton_skadis_back_v2.3mf` — compact four-hook SKÅDIS back.
- `files/badminton_multiboard_back_v2.3mf` — compact six-position Multiboard
  back for official locking hardware.
- `files/skadis_fit_coupon_v2.3mf` — full-width four-hook SKÅDIS fit coupon.
- `files/multiboard_spacing_coupon_v2.3mf` — full 50 × 50 mm Multiboard
  spacing coupon.
- `src/badminton_hook.scad` — editable source for all v2 parts and comparison
  variants.
- `tests/test_dimensions.scad` — dimensional, spacing and keep-out checks.

The clean v2.1 previews are in `previews/`. Earlier previews are retained in
`previews/legacy-v1/` and `previews/legacy-v2.0/`. The superseded v2.0 3MF
exports are retained in `files/archive/v2.0/`.

The v2.1 previews include both sides of the alternating body, the body in its
support-free print orientation, rear views of both mounting backs and a
preview-only SKÅDIS board engagement view.

## Legacy files

The earlier files are preserved and deprecated:

- `files/badminton_hook.3mf` — original eight-slot direct-to-wall rack.
- `files/badminton_universal_body_10.3mf`
- `files/badminton_universal_body_10_left.3mf`
- `files/badminton_universal_body_10_right.3mf`
- `files/badminton_skadis_back.3mf`
- `files/badminton_multiboard_back.3mf`
- `files/skadis_fit_coupon.3mf`
- `files/multiboard_spacing_coupon.3mf`

Do not mix a v1 body and v2 back. Their heel, key, fastener and connector
dimensions differ.

## Main v2 dimensions

| Feature | Nominal dimension |
|---|---:|
| Racket capacity | 10 |
| Pocket centres | X = 0; Y = 17.5 + i × 24.5 mm |
| Racket pitch | 24.5 mm |
| Nominal shaft diameter | 7.2 mm |
| Pocket diameter | 8.8 mm |
| Snap opening | 6.6 mm |
| Arm section | 25.8 × 28 mm |
| Arm position when mounted | Z = 36..64 mm |
| Body heel | 120 × 64 × 8 mm |
| Projection | 246.4 mm |
| Longest body print axis | 249.4 mm |
| Actual Z=0 contact area | approximately 4,804 mm² |
| Positive interface key | 72 × 34 × 3 mm |
| SKÅDIS back | 140 × 72 × 8 mm |
| Multiboard back | 130 × 72 × 8 mm |

The body narrowly fits a nominal 256 mm bed. Check purge lines, brim width and
machine exclusion zones. Do not scale the model because that changes the
pockets, key and fastener positions.

## Alternating entry options

The source parameter `entry_pattern` accepts:

- `"alternating"` — five left and five right openings.
- `"left"` — all ten openings on the left for comparison.
- `"right"` — all ten openings on the right for comparison.

Set `reverse_alternating = true` to begin the alternating sequence on the
right. `"both"` is deliberately rejected because a full-width opening at every
pocket would disconnect the arm. Per-pocket insertion from either side needs a
moving or removable gate architecture.

Every variant uses the same ten pocket coordinates, so all seated shafts remain
centred and aligned.

## Body-to-back interface

The 72 × 34 × 3 mm positive key carries interface shear. Four M4 screws at
X = ±42 mm and Z = 18/49 mm retain the body. Each back has four tapered blind
pockets for nominal 5.7 × 6 mm M4 heat-set inserts.

Starting hardware:

- Four M4 × 10 socket-head screws.
- Four nominal 5.7 × 6 mm M4 heat-set inserts.

Hardware dimensions vary. Measure the purchased inserts and screw heads, then
adjust `insert_entry_d`, `insert_tip_d`, `insert_depth`,
`body_counterbore_d` or screw length before printing the full parts.

Install the inserts from the front face of the back. Fully seat the positive
key before tightening the four screws evenly.

## Compact SKÅDIS v2 back

The SKÅDIS back has:

- Four independent gravity-latching hooks at X = −60, −20, 20 and 60 mm.
- 40 mm aligned pitch and a full 120 mm hook span.
- One hook row at approximately Z = 58 mm.
- 4.2 mm hook width for nominal 5 mm slots.
- A 12 mm downward tongue, 4 mm neck and chamfered insertion edge.
- Four upper bearing pads and three lower compression pads near Z = 10 mm.
- No rigid lower connector row.

The default source models a nominal 3.0 mm board with 0.4 mm running clearance.
Measure the actual board and adjust `skadis_board_t` or
`skadis_board_clearance` if required.

Print `skadis_fit_coupon_v2.3mf` first. It reproduces all four hooks, the full
120 mm accumulated span, standoff and lower pads. Push all four chamfered
tongues through one aligned slot row, bring the coupon against the board, then
lower it so the necks seat and the downward tongues remain behind the board.
Do not force it. Cycle the coupon at least 20 times and inspect the slots and
hooks before printing the complete back.

## Compact Multiboard v2 back

Multiboard uses a 25 mm base grid. The v2 back uses every second position in
both directions:

- X = −50, 0 and 50 mm.
- Z = 11 and 61 mm.
- Six M4 clearance and counterbored positions in a 50 × 50 mm pattern.

The model does not include copied or improvised friction pegs. Use official
locking or Small Thread Multipoint hardware suited to the installed tile and
load. Fit all Multiboard hardware before attaching the racket body because the
body covers the mounting area.

Use `multiboard_spacing_coupon_v2.3mf` to verify all six positions against the
actual board and selected hardware.

## Print orientation and settings

Suggested starting settings for load-bearing parts:

- PETG or ASA.
- 0.20 mm layer height.
- At least six perimeters and six top/bottom layers.
- 35–45% cubic or gyroid infill.
- Dry filament and calibrated extrusion.

The body export is inverted relative to its mounted orientation. The broad top
of the 64 mm heel and the broad top of the long arm are coplanar at Z=0. This
provides approximately 4,804 mm² of first-layer contact over the heel and
nearly the full 246 mm arm length, with no 4 mm suspended plane. The supplied
body prints support-free. Verify the 249.4 mm footprint and consider a brim if
your machine has weak bed adhesion.

Print the SKÅDIS back and coupon on their long edge so each hook profile lies
in the layer plane. Use a brim and inspect the hook starts in the slicer.
Print the Multiboard back and coupon flat.

## Fit and load workflow

1. Print the relevant fit coupon.
2. Test every coupon connector together on the actual board.
3. Confirm the coupon inserts, lowers, locks and removes without forcing.
4. Print the selected back and install all board hardware.
5. Install the four body-interface inserts and dry-fit the key and screws.
6. Mount the empty assembly and check for rocking, lift-off, board flex,
   insert movement or cracking.
7. Test two adjacent real rackets inserted from opposite sides.
8. Increase a final-slot proof load through 1 kg, 2 kg and 3 kg while
   supervising the assembly. A 3 kg end load produces roughly 7.2 N·m.
9. Remove the load immediately if anything moves or creaks. Inspect again
   after a 24-hour intended-load test.

The printed rack is not structurally certified. Connector fit, board
condition, wall anchoring, material strength and creep still require physical
validation. Do not load ten rackets until the coupon and proof tests pass.

## OpenSCAD render modes

Recommended modes:

| Mode | Output |
|---|---|
| `body_alternating` | Default alternating v2 body |
| `body_alternating_reverse` | Reversed alternating v2 body |
| `body_left` | All-left v2 comparison body |
| `body_right` | All-right v2 comparison body |
| `skadis_back_v2` | Compact SKÅDIS back |
| `multiboard_back_v2` | Compact Multiboard back |
| `assembled_skadis_v2` | Alternating body on SKÅDIS back |
| `assembled_multiboard_v2` | Alternating body on Multiboard back |
| `skadis_coupon_v2` | Full-pattern SKÅDIS coupon |
| `multiboard_coupon_v2` | Full-pattern Multiboard coupon |
| `body_print_preview` | Preview-only support-free build-plate view |
| `skadis_back_rear_preview` | Preview-only SKÅDIS rear hook view |
| `multiboard_back_preview` | Preview-only Multiboard rear view |
| `skadis_engagement_preview` | Preview-only board and lowered hook view |
| `none` | No source geometry; used by tests |

Compatibility aliases for the earlier mode names remain in the source. The old
`alignment_preview` alias now shows only the printable alternating body.

Run the dimensional suite from this directory:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings \
  -D 'render_mode="none"' \
  -o /tmp/badminton_dimensions.stl \
  tests/test_dimensions.scad
```

A successful run echoes `V2_1_DIMENSION_TESTS_PASSED`.
