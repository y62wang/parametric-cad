# Model Y Juniper trunk grocery hook

Parameterized OpenSCAD recreation of the three-loop trunk hook sold as Arcoche
ASIN `B0FN7JHT19`, designed for the 2025+ Tesla Model Y ("Juniper") rear-hatch
weatherstrip.

The seller does not publish a dimensioned drawing, and the local
weatherstrip/trim-gap dimensions are not published. The model is therefore
based on listing photos, the installation video, stated product weight, and
printable wall-thickness constraints. Print a fit coupon before the full hook.

## Highlights

- Three separate bag loops on one weatherstrip-mounted panel.
- Tool-free installation under the rear-hatch seal.
- Three flange-thickness coupons for checking the unpublished trim gap.
- Editable dimensions for the panel, flange, slots, and hook geometry.
- Strong-layer print orientation selected after comparing all 24 axis-aligned
  orientations.
- Full geometry and slicer validation documented in `VALIDATION.md`.

## Nominal dimensions

| Feature | Dimension |
|---|---:|
| Overall width | 132 mm |
| Body height | 60 mm |
| Weatherstrip flange depth | 30 mm |
| Main wall thickness | 4.0 mm |
| Tapered flange tip | 1.8 mm |
| Hook opening depth | 15 mm |
| Hook lip height | 27 mm |
| Three hook widths | 29 mm each |
| Rail/flex slots | 43 × 5.2 mm |

All important values are editable near the top of
`src/model_y_juniper_trunk_hook.scad`.

## Files

- `src/model_y_juniper_trunk_hook.scad` — editable source.
- `files/model_y_juniper_trunk_hook.3mf` — full hook in the recommended
  strong-layer orientation.
- `files/model_y_juniper_fit_coupon_1.4mm.3mf` — thin flange test.
- `files/model_y_juniper_fit_coupon_1.8mm.3mf` — nominal flange test.
- `files/model_y_juniper_fit_coupon_2.2mm.3mf` — thick flange test.
- `VALIDATION.md` — geometry, slicer, mechanical-screening, and remaining
  physical-validation details.

## Fit procedure

1. Print the 1.8 mm coupon first.
2. Lift the weatherstrip at the intended passenger-side straight section.
3. Confirm that the flange slides under the seal without forcing it and that
   the seal fully reseats.
4. If loose, try 2.2 mm. If too tight, try 1.4 mm.
5. Set `flange_tip_thickness` to the successful value before exporting the full
   hook.

Do not force a coupon that pinches, cuts, or prevents the weatherstrip from
reseating.

## Suggested full-hook print settings

- Material: ASA or ABS preferred; avoid PLA in a hot vehicle.
- Orientation: use the supplied 3MF, standing on one narrow end.
- Walls: 6.
- Infill: 50% gyroid.
- Layer height: 0.20 mm.
- Brim: 10 mm.
- Supports: required. Use organic/tree supports, build plate only, with a 35°
  threshold and approximately 0.20 mm top Z gap. Confirm in preview that all
  three hook-start faces are supported.

The fit coupons can be printed in their supplied orientation without supports.

The seller's 25 lb claim does not transfer to this 3D-printed recreation. See
`VALIDATION.md` and load-test gradually before relying on the part.

This is an independently recreated accessory, not an OEM Tesla part.
