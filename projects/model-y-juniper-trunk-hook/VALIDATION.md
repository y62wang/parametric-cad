# Validation report

Validated on September 9, 2026.

## Reference and scale

The Amazon product page and installation video were inspected. The listing
identifies an ABS two-piece accessory weighing 4.8 oz and recommends a maximum
load of 25 lb, but no dimensioned drawing was found.

The CAD model has a calculated solid volume of 57.45 cm³. At an ABS density of
approximately 1.04 g/cm³, that is 59.7 g per hook or 119.5 g per pair, about
12.2% below the listed item weight. This is a useful scale cross-check, but not
a substitute for physical measurement because the listing weight may include
packaging and the molded part may use different local thicknesses.

Sources:

- https://www.amazon.com/dp/B0FN7JHT19
- https://www.tesla.com/ownersmanual/modely/en_us/GUID-E47C4A9B-4969-41E6-8866-33EC9A60534B.html

## Geometry checks

Rendered and exported with OpenSCAD 2026.09.01 using the Manifold backend and
hard-warning mode.

| Geometry | Bounds | Triangles | Volume | Bad edges |
|---|---:|---:|---:|---:|
| Installed hook | 132 × 60 × 53.2 mm | 1,552 | 57.45 cm³ | 0 |
| Print-ready hook | 53.2 × 60 × 132 mm | 1,552 | 57.45 cm³ | 0 |
| 1.4 mm coupon | 34 × 34 × 34 mm | 368 | 6.81 cm³ | 0 |
| 1.8 mm coupon | 34 × 34 × 34 mm | 368 | 6.94 cm³ | 0 |
| 2.2 mm coupon | 34 × 34 × 34 mm | 368 | 7.07 cm³ | 0 |

Every checked mesh was closed, with no boundary or non-manifold edges.

## Printability audit

The full hook is not support-free:

- Downward-facing area steeper than 45°: 678.96 mm².
- Nearly horizontal downward-facing area: 587.22 mm².
- The main unsupported regions are three hook-start faces, each approximately
  194.38 mm², at print heights 15.5, 51.5, and 87.5 mm.
- A sweep of all 24 axis-aligned orientations found the supplied narrow-end
  orientation had the least overhang area. It was retained to keep the
  load-bearing cross-section within each layer, with supports required.

The full hook completed an ElegooSlicer toolpath for an Elegoo Centauri Carbon
2:

| Setting | Value |
|---|---:|
| Material profile | Elegoo ASA |
| Nozzle / layer | 0.4 / 0.20 mm |
| Walls | 6 |
| Infill | 50% gyroid |
| Brim | 10 mm |
| Support | Organic tree, build plate only, 35° |
| Layers | 660 |
| Estimated material | 78.09 g |
| Estimated time | 3 h 00 m 34 s |

The nominal 1.8 mm coupon also completed a no-support slicer pass: 170 layers,
7.70 g, and 17 m 26 s estimated time.

## Mechanical screening

Putting the listing's entire 25 lb (111 N) load on one nominal hook and treating
its 29 mm-wide, 5.5 mm-thick shelf as a 15 mm cantilever gives a nominal root
bending stress of approximately 11.4 MPa. Sharing the load evenly among three
hooks gives approximately 3.8 MPa per hook.

This calculation excludes layer adhesion, voids, impact loading, stress
concentrations, elevated vehicle temperatures, trim-interface behavior, and
long-term plastic creep. It is not a load rating.

## Required physical validation

The model has not been fitted to an actual 2025+ Model Y. Print the 1.8 mm
coupon first, then use the 1.4 or 2.2 mm variant if needed. Proceed only if the
weatherstrip fully reseats without pinching, cutting, or visible distortion.

Suggested screening sequence:

1. Insert the coupon by hand only. Reject it if the seal does not fully reseat,
   leaves a visible gap, or marks the trim.
2. Print the full hook with supports and inspect every hook root for missing
   lines, cracks, or poor bonding.
3. With the vehicle stationary and cargo area clear, apply 2.5 lb for
   30 minutes, then 5 lb for 2 hours, then 10 lb for 8 hours. Stop immediately
   if the flange moves, the seal lifts, the part whitens, or permanent
   deformation appears.
4. Repeat a low-load check after a hot parked-car heat cycle. Do not assume the
   seller's 25 lb molded-part recommendation applies to this print.
