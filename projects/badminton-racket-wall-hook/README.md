# Side-entry badminton racket wall hook

A compact wall-mounted rack that stores racket shafts in individual side-entry
keyhole pockets. Instead of threading every handle through a front opening, the
shaft pushes sideways through a narrow entry and snaps into a larger circular
pocket.

## Highlights

- Holds up to eight rackets in the default configuration.
- Side-entry snap pockets make rackets easy to add and remove.
- Entry direction can be changed from right to left in OpenSCAD.
- Integrated wall plate with four mounting holes.
- Rounded arm and tip reduce sharp edges around racket frames and hands.
- Single-piece, manifold 3MF export.

## Dimensions and fit

| Feature | Default |
|---|---:|
| Overall size | 24.8 × 205.4 × 42 mm |
| Racket slots | 8 |
| Slot pitch | 25 mm |
| Nominal shaft diameter | 7.2 mm |
| Pocket diameter | 8.8 mm |
| Snap-entry width | 6.6 mm |

Measure the narrow shaft area of the racket before printing. Increase
`shaft_r`, `clearance`, or `snap` if your equipment differs.

## Files

- `src/badminton_hook.scad` — editable source and fit parameters.
- `files/badminton_hook.3mf` — default eight-slot rack.

## Recommended print settings

- Material: PETG preferred; PLA is suitable for a light indoor test.
- Layer height: 0.20 mm.
- Walls: 4–5.
- Infill: 25–35% gyroid or cubic.
- Supports: none in the supplied flat orientation.
- Brim: optional for printers with inconsistent bed adhesion.

## Installation and use

1. Hold the rack level and mark the four mounting holes.
2. Fasten into a stud or use anchors rated for the wall material and load.
3. Press each racket shaft sideways through the entry until it seats in the
   circular pocket.
4. Confirm the shaft cannot escape under a gentle downward pull before loading
   the remaining slots.

Mounting hardware is not included. The printed rack is not a substitute for
proper wall anchors.

## Customization

The main OpenSCAD parameters control the shaft radius, snap interference,
running clearance, entry side, slot count, slot spacing, and mounting-hole
diameter.
