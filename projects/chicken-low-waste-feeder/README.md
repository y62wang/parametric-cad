# Large low-waste chicken gravity feeder

A high-capacity gravity feeder designed around a 256 × 256 mm printer. Two
large head ports provide access to the feed while an internal baffle meters
grain into a shallow front chamber, helping reduce scratching and feed being
thrown onto the ground.

## Highlights

- Two 82 mm clear feeding openings.
- Internal full-height baffle with two lower feed slots.
- Removable flanged port collars.
- Slip-on lid for refilling and weather protection.
- Main body fits a 256 × 256 mm build plate without splitting.
- Fully parameterized OpenSCAD source.

## Dimensions

| Feature | Default |
|---|---:|
| Main body | 235 × 110 × 240 mm |
| Alternate v2 body export | 235 × 125 × 180 mm |
| Body wall / bottom | 3.0 / 3.2 mm |
| Body cutouts | 88 mm diameter |
| Clear port opening | 82 mm diameter |
| Port flange | 102 mm diameter |
| Feed slots | 34 × 19 mm |

## Files

- `src/chicken_low_waste_feeder.scad` — editable source with selectable parts.
- `files/feeder_body.3mf` — main body and internal baffle.
- `files/feeder_body_v2.3mf` — shorter, deeper 235 × 125 × 180 mm body
  alternative retained for slicer and physical comparison.
- `files/feeder_lid.3mf` — slip-on lid.
- `files/feeder_port.3mf` — one removable port collar; print two.
- `files/chicken_feeder.3mf` — assembled reference view, not a one-plate print.

## Recommended print settings

- Material: PETG or ASA for moisture and outdoor-temperature resistance.
- Layer height: 0.24–0.28 mm.
- Walls: 4.
- Infill: 15–25% gyroid.
- Body orientation: upright, open top facing upward.
- Lid orientation: rotate so the closed top is on the build plate and the
  cavity faces upward.
- Port orientation: flange flat on the build plate.
- Brim: 8–12 mm for the tall body.
- Supports: inspect the upper arcs of the large body openings in the slicer;
  use localized support if your printer cannot bridge them cleanly.

## Assembly and use

1. Print one body, one lid, and two port collars.
2. Test-fit each collar in a body opening before applying any adhesive.
3. Install the collars from the outside with the flanges against the front
   wall. Use food-safe sealant only if a permanent installation is required.
4. Fill from the top and fit the lid.
5. Start with a small amount of feed and observe the flow through the baffle
   slots before filling completely.

Keep the feeder dry and inspect it regularly for cracking, trapped moisture,
and sharp damaged edges.

## Customization

OpenSCAD parameters control body size, wall thickness, port diameter and
position, baffle depth, feed-slot size, lid clearance, and collar fit.

## Validation status

Both body alternatives, the lid, and the port export report as manifold
solids. Feed flow, animal access, outdoor durability, and final collar fit
still require physical testing.
