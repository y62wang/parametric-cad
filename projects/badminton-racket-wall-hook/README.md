# Badminton racket wall hook

## v2.5 connected alternating-sawtooth prototype — physical validation required

v2.5 replaces the disconnected v2.4 collar-chain architecture with one
continuous printable body. The heel, 40 mm root flare and complete arm are one
closed manifold component with no collars, loose sections, gates, cradle or
assembly joints.

Ten centred racket pockets form an alternating sawtooth:

`left, right, left, right, left, right, left, right, left, right`

Each pocket has one side entry. The next pocket opens from the opposite side,
while the solid load path switches sides and remains connected from the heel
to the tip. A reverse body begins on the right. Both bodies keep every shaft
axis on X = 0.

The geometry provides ten positions but has not been physically verified to
carry ten rackets. The machine-readable status remains
`ten_racket_load_verified=false` and
`load_rating_status="physical_validation_required"`.

The released v2.2 package and the complete v2.3 and v2.4 prototype packages
remain checksum-protected and unchanged. The isolated v2.5 package is stored
under:

- Editable source:
  `src/prototypes/v2_5_connected_zigzag.scad`
- Dimensional tests:
  `tests/prototypes/v2_5/test_dimensions.scad`
- Standard-library mesh and protected-asset validator:
  `tests/prototypes/v2_5/validate_meshes.py`
- Protected v2.2-v2.4 checksums:
  `tests/prototypes/v2_5/protected_v2_2_v2_3_v2_4.sha256`
- Printable meshes:
  `files/prototypes/v2.5/`
- Clean previews:
  `previews/prototype-v2.5/`

### v2.5 geometry

| Feature | v2.5 connected prototype |
|---|---:|
| Body components | exactly one |
| Racket positions | 10 |
| Racket centres | X = 0; Y = 23, 44, 65, 86, 107, 128, 149, 170, 191, 212 mm |
| Opening sequence | left/right alternating; five of each |
| Reverse export | right/left alternating; five of each |
| Racket pitch | 21 mm |
| Nominal shaft | Ø7.2 mm |
| Pocket | Ø8.8 mm |
| One-sided entry | 6.6 mm |
| Opposite-side continuous ligament | 9.6 mm |
| Web between adjacent pocket edges | 12.2 mm |
| Arm section | 28 × 36 mm |
| Root flare | 40 mm |
| Heel/root overlap | 1 mm |
| Root/arm overlap | 1 mm |
| Projection | 221 mm |
| Tip margin after final pocket | 4.6 mm |
| Body print footprint | 72 × 224 mm |
| Mounting back | 72 × 72 × 8 mm |
| Positive interface key | centred 40 × 20 × 3 mm |
| Body fasteners | four M4 at X = −27/+27 mm and Z = 26/46 mm |
| SKÅDIS board connection | exactly two printed hooks at X = −20/+20 mm, Z = 58 mm |
| SKÅDIS lower features | two board-bearing supports; not connectors |
| Multiboard board connection | two centred attachment holes at X = 0, Z = 11/61 mm |
| Multiboard pitch | 50 mm vertically |
| Multiboard board hardware | two external M4-compatible fasteners required |
| Declared print bed | 256 × 256 mm |

### Printable v2.5 files

- `v2_5_connected_body_start_left.3mf` — one-piece ten-position body beginning
  with a left opening.
- `v2_5_connected_body_start_right.3mf` — one-piece reverse body beginning
  with a right opening.
- `v2_5_skadis_back_two_hook.3mf` — compact back with exactly two printed
  SKÅDIS hooks and two lower bearing supports.
- `v2_5_multiboard_back_two_point.3mf` — compact back with two centred
  counterbored attachment points for external Multiboard hardware.
- `v2_5_skadis_fit_coupon_two_hook.3mf` — lower-material two-hook fit coupon.
- `v2_5_multiboard_fit_coupon_two_point_50mm.3mf` — lower-material two-hole
  50 mm-pitch fit coupon.
- `v2_5_three_slot_alternating_coupon.3mf` — short left/right/left spacing and
  shaft-fit coupon using the final 21 mm pitch and pocket geometry.

Every supplied v2.5 body, back and coupon validates as one closed manifold
component with minimum Z = 0 and fits the declared 256 × 256 mm print bed.

### v2.5 hardware

Both mounting variants require:

- Four body-to-back M4 screws. Their heads must fit the modelled
  Ø8.2 × 4.2 mm body counterbores. Select a length that reaches the inserts
  with the insert manufacturer's recommended thread engagement without
  bottoming or protruding through the rear.
- Four M4 heat-set inserts compatible with the modelled tapered pockets:
  Ø5.9 mm entry, Ø5.4 mm tip and 6.2 mm depth. Confirm the actual insert
  dimensions and printer compensation before installing all four.

The Multiboard variant additionally requires:

- Two external Multiboard-compatible M4 board fasteners. Their heads must fit
  the Ø8.4 × 4.2 mm counterbores. Select hardware suited to the actual tile,
  wall installation and load. These board fasteners are not printed or
  supplied by the model.

### Required v2.5 physical validation

Do not treat the prototype as load-rated or install valuable rackets until all
of these checks pass:

1. Print the three-slot coupon and test the smallest and largest real racket
   shafts. Confirm the 6.6 mm entries flex without cracking, the Ø8.8 mm
   pockets retain the shafts and three representative rackets fit together at
   21 mm pitch.
2. Print the appropriate board-fit coupon. On a real board, confirm both
   SKÅDIS hooks engage together or both Multiboard fasteners seat correctly.
   Reject forcing, rocking, partial engagement or visible board deformation.
3. Print the selected one-piece body and inspect every alternating tooth,
   especially the 9.6 mm opposite ligament, for layer gaps, under-extrusion or
   cracks. Use at least six perimeters so the critical ligaments contain
   continuous extrusion paths.
4. Install the four inserts, seat the centred key fully and tighten the four
   body screws evenly. Mount the empty assembly and check the root, hooks,
   fasteners, board and wall attachment.
5. Add ten real rackets gradually from the root towards the tip. Leave the
   intended ten-racket load in place for 24 hours. Reject cracking, board
   rocking, insert movement, hook or fastener movement, or permanent tip set
   greater than 1 mm.
6. Only after the sustained test passes, perform a supervised gradual 3 kg
   tip proof load. Stop at the first visible, audible or measured change. The
   test must include the real board and its wall attachment.

### v2.5 rendering and validation

Run the dimensional contract from this project directory:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings \
  -D 'render_mode="none"' \
  -o /tmp/badminton_v2_5_dimensions.echo \
  tests/prototypes/v2_5/test_dimensions.scad
```

Printable modes:

- `body_start_left`
- `body_start_right`
- `skadis_back`
- `multiboard_back`
- `skadis_fit_coupon`
- `multiboard_fit_coupon`
- `spacing_coupon`

Render a mode with:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings --backend Manifold \
  -D 'render_mode="body_start_left"' \
  -o files/prototypes/v2.5/v2_5_connected_body_start_left.3mf \
  src/prototypes/v2_5_connected_zigzag.scad
```

Validate all seven 3MF files, one-component topology, closed/manifold edges,
minimum Z, print-bed fit and all 66 protected v2.2-v2.4 assets:

```sh
python3 tests/prototypes/v2_5/validate_meshes.py \
  files/prototypes/v2.5
```

Preview-only modes:

- `preview_assembled_skadis`
- `preview_assembled_multiboard`
- `preview_zigzag_spine`
- `preview_skadis_rear`
- `preview_multiboard_rear`
- `preview_print_orientation`

## v2.4 printable ten-position prototype — physical validation required

v2.4 is the first printable full-length rotating-collar package. It provides
exactly two printed SKÅDIS hooks or two centred Multiboard attachment points
for external M4-compatible board hardware, a centred body with ten racket
positions, ten replaceable left/right collars and a one-piece assembly cradle.
It is a printable prototype rather than a released load-bearing product.

The geometry is designed around ten centred racket positions. It cannot be
claimed to carry ten actual rackets until the documented cycle test, 24-hour
ten-racket test and supervised proof-load test all pass. The machine-readable
model status is `ten_racket_load_verified=false` and
`load_rating_status="physical_validation_required"`.

The released v2.2 files and all v2.3 mechanism-test files remain unchanged.
The isolated v2.4 package is stored under:

- Editable source:
  `src/prototypes/v2_4_printable_full_rack.scad`
- Dimensional tests:
  `tests/prototypes/v2_4/test_dimensions.scad`
- Standard-library mesh and protected-asset validator:
  `tests/prototypes/v2_4/validate_meshes.py`
- Protected v2.2/v2.3 checksums:
  `tests/prototypes/v2_4/protected_v2_2_v2_3.sha256`
- Printable meshes:
  `files/prototypes/v2.4/`
- Clean previews:
  `previews/prototype-v2.4/`

### v2.4 geometry

| Feature | v2.4 printable prototype |
|---|---:|
| Mounting back | 72 × 72 × 8 mm |
| SKÅDIS printed hooks | exactly two at X = −20/+20 mm, Z = 58 mm |
| SKÅDIS lower features | two board-bearing pads; they are not connectors |
| Multiboard attachment points | exactly two centred holes at X = 0, Z = 11/61 mm |
| Multiboard board hardware | two external M4-compatible fasteners required |
| Multiboard pitch | 50 mm vertically |
| Body and shaft alignment | X = 0 |
| Designed racket positions | 10 |
| Verified ten-racket load | no; physical validation required |
| Racket centres | Y = 23, 44, 65, 86, 107, 128, 149, 170, 191, 212 mm |
| Racket pitch | 21 mm |
| Arm section | 28 × 36 mm |
| Body projection | 226 mm |
| Final stop-track tip margin | 4.4 mm |
| Body print footprint | 72 × 229 mm |
| Body components | 11: `ROOT`, `S2`…`S10`, `TIP` |
| Nominal collars | 10: `R1`…`R10` |
| One-piece cradle | 82 × 238 × 3.2 mm |
| Cradle access holes | ten, Ø22 mm |
| Declared print bed | 256 × 256 mm |

Each 9 mm collar bore rotates through 180 degrees. At one hard stop its C
opening faces right; at the other it faces left. Every shaft axis remains at
X = 0 regardless of the selected insertion side.

The ten full-width bilateral corridors divide the printed body into eleven
closed sections. Place all sections in their matching cradle pockets, align
`ROOT`, `S2` through `S10` and `TIP`, then install collars `R1` through `R10`
through the matching Ø22 mm access holes. The collars locate the sections and
bridge each corridor. Lift the connected assembly from the cradle only after
all ten collars are fully seated.

### Printable v2.4 files

- `v2_4_full_body_sections.3mf` — all eleven centred body sections in their
  assembled print layout.
- `v2_4_full_rack_collars.3mf` — ten nominal rotating collars with snap-off
  `R1`–`R10` labels.
- `v2_4_full_rack_cradle.3mf` — one indexed cradle locating all eleven body
  sections, with ten lower-lip access holes.
- `v2_4_skadis_back_two_hook.3mf` — full SKÅDIS back with exactly two load
  hooks and two separate lower bearing pads.
- `v2_4_multiboard_back_two_mount.3mf` — full Multiboard back with exactly two
  centred counterbored attachment points at 50 mm vertical pitch; external
  M4-compatible Multiboard board hardware is required.
- `v2_4_skadis_fit_coupon_two_hook.3mf` — lower-material two-hook fit coupon.
- `v2_4_multiboard_fit_coupon_two_mount_50mm.3mf` — lower-material two-hole
  Multiboard attachment-point fit coupon for external hardware.

The required preview set shows:

- Complete ten-position SKÅDIS and Multiboard layouts.
- A rear SKÅDIS view showing two printed hooks.
- A rear Multiboard view showing two actual holes labelled as external M4
  attachment points at 50 mm pitch.
- Actual right-side and left-side collar insertion positions.
- All eleven sections and ten collars seated in the full assembly cradle.

### v2.4 hardware list

Both mounting variants require:

- Four body-to-back M4 screws. The screw heads must fit the modelled
  Ø8.2 × 4.2 mm body counterbores. Select a length that passes through the
  remaining body heel thickness and reaches the heat-set inserts to the insert
  manufacturer's recommended thread engagement without bottoming in the pocket
  or protruding through the rear of the back.
- Four matching M4 heat-set inserts sized for the modelled tapered pockets:
  Ø5.9 mm entry, Ø5.4 mm tip and 6.2 mm depth. Confirm the chosen insert and
  printer compensation with a fit sample before installing all four.

The Multiboard variant additionally requires:

- Two external Multiboard-compatible M4 board fasteners. Their heads must fit
  the modelled Ø8.4 × 4.2 mm counterbores. Select the board-side hardware and
  fastener engagement for the actual Multiboard tile and wall installation.
  These fasteners are not printed or supplied by this model.

### Required physical validation before release

This design provides ten positions but is not physically verified to carry ten
actual rackets. Do not install valuable rackets or treat it as load-rated until
all of the following tests pass and are recorded:

1. Print the v2.3 tolerance coupons first and select the collar fit that rotates
   freely, retains both detents and accepts the smallest and largest real racket
   shafts without damage.
2. Test the v2.4 SKÅDIS and Multiboard fit coupons on the real boards. Confirm
   both printed SKÅDIS hooks engage together or both external Multiboard M4
   fasteners seat correctly, the back does not rock and the SKÅDIS lower pads
   remain bearing surfaces only.
3. Cycle the root, middle and tip collars from left to right at least 100 times.
   Reject cracking, binding, snap-lip damage, section separation or loss of
   detent feel.
4. Assemble all eleven sections in the cradle and verify all ten collars are
   fully captured before removing the rack.
5. Mount ten real rackets for 24 hours. Reject SKÅDIS hook or Multiboard
   fastener movement, board rocking, collar rotation, section separation,
   cracking or permanent tip set greater than 1 mm.
6. Only after the sustained test passes, perform a supervised gradual 3 kg tip
   proof load. Stop immediately at the first visible, audible or measured
   change. This load creates an approximate 6.6 N·m mounting moment and must
   include the real board and its wall attachment.

### Rendering and validation

Run the dimensional contract from this project directory:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings \
  -D 'render_mode="none"' \
  -o /tmp/badminton_v2_4_dimensions.echo \
  tests/prototypes/v2_4/test_dimensions.scad
```

Printable modes:

- `full_body_sections`
- `full_rack_collars`
- `full_rack_cradle`
- `skadis_back`
- `multiboard_back`
- `skadis_fit_coupon`
- `multiboard_fit_coupon`

Render a mode with:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings --backend Manifold \
  -D 'render_mode="full_body_sections"' \
  -o files/prototypes/v2.4/v2_4_full_body_sections.3mf \
  src/prototypes/v2_4_printable_full_rack.scad
```

Validate every generated 3MF, its component count, closed/manifold topology,
Z = 0 placement, 256 × 256 mm bed fit and all protected v2.2/v2.3 checksums:

```sh
python3 tests/prototypes/v2_4/validate_meshes.py \
  files/prototypes/v2.4
```

Preview-only modes:

- `preview_complete_skadis`
- `preview_complete_multiboard`
- `preview_skadis_rear`
- `preview_multiboard_rear`
- `preview_bilateral_operation`
- `preview_full_cradle_assembly`

## v2.3 rotating-collar prototype — not yet released

**This is an experimental fit and mechanism package. Do not print or load a
ten-collar body. No printable ten-collar 3MF or export mode is provided.**

The v2.3 prototype tests true left-or-right access at every racket position.
Each separate collar rotates 180 degrees inside a fixed bilateral body
corridor. The collar's C opening faces the selected insertion side while its
solid opposite arc bridges the body gap.

The released v2.2 files remain unchanged. All v2.3 source, tests, meshes and
previews are isolated under prototype paths:

- Editable source:
  `src/prototypes/v2_3_rotating_collar.scad`
- Dimensional tests:
  `tests/prototypes/v2_3/test_dimensions.scad`
- Mesh validator:
  `tests/prototypes/v2_3/validate_meshes.py`
- Protected v2.2 checksums:
  `tests/prototypes/v2_3/v2_2_release.sha256`
- Printable prototype meshes:
  `files/prototypes/v2.3/`
- Prototype previews:
  `previews/prototype-v2.3/`

### Prototype geometry

| Feature | v2.3 prototype |
|---|---:|
| SKÅDIS back | 72 × 72 × 8 mm |
| SKÅDIS hooks | exactly two, X = −20/+20 mm, Z = 58 mm |
| Multiboard back | 72 × 72 × 8 mm |
| Multiboard positions | X = −25/+25 mm; Z = 11/61 mm |
| Multiboard pitch | 50 × 50 mm |
| Centred heel | 72 × 36 × 8 mm |
| Arm section | 28 × 36 mm |
| Mounted arm position | X = 0; global Z = 18..54 mm |
| Positive key | 40 × 20 × 3 mm, centred at global Z = 36 mm |
| Body fasteners | four M4 at X = ±27; global Z = 26/46 mm |
| Root flare | 40 mm, tapering to 28 mm by Y = 10.5 mm |
| Collar pitch | 21 mm |
| Preview-only centres | Y = 23 + 21i mm, ten positions |
| Preview-only projection | 223 mm |
| Nominal shaft | 7.2 mm |
| Collar bore | 9.0 mm |
| Fixed bilateral corridor | 8.0 mm |
| Collar barrel | 16.0 mm |
| Top flange | 17.2 × 2.0 mm |
| Body top recess | 17.6 × 2.2 mm |
| Nominal axial movement | 0.2 mm |

The body has rigid corridors on both sides. Those corridors intentionally
separate the body into sections; the installed collars join and locate those
sections. The structural coupon body therefore contains four closed components
and the tolerance fixture contains eighteen closed components. The separate
assembly cradles hold those loose components at their designed spacing while
the collars are pressed through them.

### Rotating collar operation

Each collar has:

- A 9.0 mm bore and a C throat.
- A solid opposite arc that carries load across the body corridor.
- A 17.2 mm top flange captured in the body recess.
- A C-shaped lower snap lip with a 45-degree insertion chamfer and nominal
  0.3 mm radial retaining shoulder.
- One replaceable stop/detent tab travelling in a recessed 180-degree body
  track.
- A recessed top tool slot and direction arrow.
- Fixed debossed `L` and `R` marks on the body.

To assemble and operate one collar:

1. Place every loose body section in its matching shallow cradle pocket.
   For the matrix, match both half IDs at each station, such as `A1-S` and
   `A1-N`. For the structural coupon, use the `ROOT`, `S2`, `S3` and `TIP`
   pockets.
2. Check that each 22 mm cradle through-hole is centred below its collar
   cavity. The lower snap lip must pass into this hole without touching the
   cradle.
3. Align the collar throat with either fixed corridor.
4. Press the collar down from the top until the C-shaped lower lip passes
   through the cavity and its shoulder catches below the body.
5. Confirm the top flange sits inside the 17.6 mm recess and the collar has
   slight axial movement without lifting out.
6. Use a small flat tool in the recessed slot. Rotate until the arrow points
   to the required `L` or `R` mark and the collar reaches the hard stop and
   endpoint detent.
7. Insert the racket shaft from that side, through the 8.0 mm body corridor
   and collar throat, until it seats in the 9.0 mm bore.
8. Remove the shaft from the same selected side. Rotate the empty collar
   exactly 180 degrees to change sides.
9. After all three structural-coupon collars are installed, lift the assembled
   four-section chain out of its cradle as one unit.
10. To remove a collar, return the assembly to its cradle, work through the
    hole from below, compress the open C lip evenly and push the collar
    upwards. Do not pry against a fixed body web.

Do not rotate a collar while it is carrying a racket. Do not force a collar
that binds or a throat that will not accept the test shaft.

The stop tab travels from 90 to 270 degrees in the fixed body, giving exactly
180 degrees of throat travel. The track covers the complete moving-tab
envelope and uses direct radial end faces as the hard stops. At both hard
stops, the flexible collar detent and fixed pocket share the same calculated
centre; nominal centre mismatch is 0.00 mm and nominal engagement is 0.18 mm.

### Printable v2.3 prototype files

- `v2_3_tolerance_matrix_fixture.3mf` — nine labelled socket tests covering
  all cavity diameters.
- `v2_3_tolerance_matrix_collars.3mf` — nine matched, labelled collars
  covering all cavity/throat combinations.
- `v2_3_tolerance_matrix_cradle.3mf` — one indexed carrier with eighteen
  shallow half pockets and nine 22 mm snap-lip through-holes.
- `v2_3_structural_coupon_body.3mf` — centred heel, interface, corrected root
  and three bilateral collar positions at 21 mm pitch.
- `v2_3_structural_coupon_collars.3mf` — three nominal 16.5 mm collars with
  6.9, 7.1 and 7.3 mm throats.
- `v2_3_structural_coupon_cradle.3mf` — one four-section carrier with three
  22 mm through-holes; the installed coupon lifts out as one chain.
- `v2_3_skadis_back_two_hook.3mf` — full 72 mm back with exactly two centred
  SKÅDIS hooks.
- `v2_3_multiboard_back_centred.3mf` — full 72 mm centred Multiboard back.
- `v2_3_skadis_fit_coupon_two_hook.3mf` — lower-material two-hook fit coupon.
- `v2_3_multiboard_fit_coupon_50x50.3mf` — lower-material 50 × 50 mm spacing
  coupon.

The collar build plates print flange-down. Each collar has a snap-off label
tag joined to the solid arc so its cavity and throat combination remains
identifiable. Both matrix socket halves carry their complete station and side
ID, from `A1-S`/`A1-N` through `C3-S`/`C3-N`. The nearby matrix text also gives
the cavity and throat dimensions, for example `B2 16.5/7.1`.

### Required v2.3 test sequence

Complete the tests in this order:

1. **Tolerance matrix:** print the fixture, matched collars and tolerance
   cradle. Seat all eighteen labelled halves in their indexed pockets before
   installing a collar. Check every matched pair for insertion force, free
   rotation, exact left and right alignment, detent engagement, axial play,
   lip retention and release through the 22 mm hole below.
2. **Shaft fit:** test the smallest and largest real racket shafts in all
   three throat widths. Reject any combination that marks, pinches or releases
   the shaft unintentionally.
3. **Cycle test:** rotate each viable combination left-to-right at least
   25 times while empty. Remove and reinstall representative collars at least
   ten times. Inspect the C roots, snap lip and detent after every set.
4. **Three-collar coupon:** print the body, three nominal collars and
   structural cradle. Seat all four sections in the indexed pockets, install
   the three collars through the cradle holes, then lift the connected chain
   out. Confirm all three collars bridge the corridors and three rackets can
   be inserted and removed independently from both sides.
5. **Local load test:** load the three-collar coupon gradually while
   observing collar rotation, lower-lip pull-through, flange lift, body-section
   separation and creep. Stop at the first visible or audible change.
6. **Connector fit:** test the full two-hook SKÅDIS coupon or the centred
   Multiboard coupon on the real board. Confirm simultaneous engagement,
   bearing-pad contact and no rocking.
7. **Back/interface dry fit:** install the selected 72 mm back, heat-set
   inserts and structural coupon while empty. Confirm key seating, screw-head
   access and board clearance.
8. Record the selected cavity/throat pair, material, layer orientation,
   printer compensation and every failure before considering another
   prototype revision.

The short structural coupon does not reproduce the approximately 6.6 N·m
moment of a 3 kg load at the 223 mm concept tip. Passing the coupon tests does
not validate a ten-racket rack. A later full-length prototype needs a separate,
supervised proof-load plan that covers collar creep, interface inserts, the
two SKÅDIS hooks or Multiboard hardware, the board and its wall mounting.

### Prototype rendering and validation

Printable modes:

- `tolerance_matrix_fixture`
- `tolerance_matrix_collars`
- `tolerance_matrix_cradle`
- `structural_coupon_body`
- `structural_coupon_collars`
- `structural_coupon_cradle`
- `skadis_back`
- `multiboard_back`
- `skadis_fit_coupon`
- `multiboard_fit_coupon`

Preview-only modes:

- `preview_tolerance_matrix`
- `preview_structural_coupon`
- `preview_stop_poses`
- `preview_collar_detail`
- `preview_back_pair`
- `preview_concept_skadis`
- `preview_concept_multiboard`

There is deliberately no printable full-body mode.

Run the dimensional tests:

```sh
TERM=dumb NO_COLOR=1 openscad --hardwarnings \
  -D 'render_mode="none"' \
  -o /tmp/badminton_v2_3_dimensions.echo \
  tests/prototypes/v2_3/test_dimensions.scad
```

Validate generated prototype meshes:

```sh
python3 tests/prototypes/v2_3/validate_meshes.py \
  files/prototypes/v2.3
```

Verify the protected v2.2 3MF and PNG release files:

```sh
shasum -a 256 -c \
  tests/prototypes/v2_3/v2_2_release.sha256
```

## Released v2.2 rack

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
