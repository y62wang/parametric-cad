# Parametric CAD Library — Backlog

> Status: **idea list only** — nothing built yet (except `parametric_screws/`).
> Add rows freely; re-sort by priority when ready to pick next project.

## Fastener Ecosystem

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Washers | ID, OD, thickness | Goes with screws constantly | ⭐⭐⭐⭐⭐ |
| Nuts | thread, width across flats, height | Screw/bolt ecosystem | ⭐⭐⭐⭐⭐ |
| Spacers / standoffs | ID, OD, height | Extremely common in custom builds | ⭐⭐⭐⭐⭐ |
| Heat-set inserts | insert size, OD, depth | Excellent for printed assemblies | ⭐⭐⭐⭐⭐ |
| Threaded rods | thread, diameter, length | Same engine as screws | ⭐⭐⭐⭐ |
| Alignment pins | pin Ø, socket clearance, depth | Repeatable part registration | ⭐⭐⭐⭐⭐ |
| Bushings | ID, OD, length, clearance | Mechanical adapters | ⭐⭐⭐⭐⭐ |
| Shaft couplings | bore Ø pair, OD, length | Connect dissimilar shafts | ⭐⭐⭐⭐ |

## Holes & Recesses (subtract from solids)

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Clearance holes | screw size, fit class, depth | More useful than modeling screws | ⭐⭐⭐⭐⭐ |
| Countersinks | screw size, head angle, depth | Auto-fit flat-head screws | ⭐⭐⭐⭐⭐ |
| Counterbores | screw size, head OD, depth | Hide bolt heads | ⭐⭐⭐⭐⭐ |
| O-ring groove | wire Ø, groove OD, tolerance | Sealing anything | ⭐⭐⭐⭐ |
| Panel cutouts | shape, W×H, corner radius | Templates for enclosure openings | ⭐⭐⭐⭐⭐ |

## Containers & Storage

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Boxes | W × D × H, wall, bottom thickness | Generic container | ⭐⭐⭐⭐⭐ |
| Lids | box dims, fit tolerance, lip depth | Reusable containers | ⭐⭐⭐⭐⭐ |
| Dividers | count, spacing, thickness, height | Drawer organization | ⭐⭐⭐⭐⭐ |
| PCB enclosures | PCB size + margin, lid, vent, ports | Electronics housing | ⭐⭐⭐⭐⭐ |
| Battery holders | cell type (AA/18650/…), count, contacts | Power projects | ⭐⭐⭐⭐ |
| End caps | profile dims, wall, tolerance | Wood/extrusion projects | ⭐⭐⭐⭐⭐ |

## Joints & Connections

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Snap fits | width, hook depth, flex arm, clearance | Modular assemblies | ⭐⭐⭐⭐ |
| Dovetails | width, depth, angle, clearance | Joining printed panels | ⭐⭐⭐⭐⭐ |
| T-slot joints | dims, nut slot, clearance | Modular construction | ⭐⭐⭐⭐⭐ |
| Hinges | pin Ø, width, knuckle count, gap | Doors / lids | ⭐⭐⭐⭐ |

## Mounting Hardware

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Brackets (generic) | W/H/D, thickness, hole pattern | DIY/furniture | ⭐⭐⭐⭐⭐ |
| L-brackets | leg lengths, thickness, hole pattern | Constantly useful | ⭐⭐⭐⭐⭐ |
| U-brackets | inner width, depth, holes | Mounting things | ⭐⭐⭐⭐ |
| Pipe / conduit clips | pipe OD, thickness, screw hole | Plumbing / cable runs | ⭐⭐⭐⭐ |
| Cable clips | cable Ø, count, screw hole | Easy practical prints | ⭐⭐⭐⭐ |
| Cable raceways | W × H, snap-fit, open/closed | Clean cable runs | ⭐⭐⭐⭐ |
| Strain relief | cable Ø, wall thickness, anchor type | Protects connections | ⭐⭐⭐⭐ |
| PCB mounts | PCB size, hole pattern, standoff height | Electronics | ⭐⭐⭐⭐⭐ |
| LED holders | LED Ø / type, friction or clip | Lighting projects | ⭐⭐⭐⭐ |
| Shelf pins | pin Ø, shelf thickness | Adjustable shelving | ⭐⭐⭐⭐ |

## Handles, Knobs & User Touches

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Knobs | Ø, height, screw/thread insert | Furniture / controls | ⭐⭐⭐⭐ |
| Handles | length, grip Ø, hole spacing | Drawers / doors | ⭐⭐⭐⭐⭐ |
| Hooks | opening, thickness, wall mount | Garage organization | ⭐⭐⭐⭐ |
| Feet | Ø, height, screw hole, rubber pad | Furniture / projects | ⭐⭐⭐⭐ |

## Mechanisms

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Gears | module, teeth, bore, width, pressure angle | Huge parametric payoff | ⭐⭐⭐⭐⭐ |
| Pulleys | diameter, belt type (GT2/V/round), bore | Mechanisms | ⭐⭐⭐⭐ |
| Bearings (pocket) | ID, OD, width, clearance fit | Press/slip fit pockets | ⭐⭐⭐⭐⭐ |
| Springs | OD, wire Ø, pitch, turns, end type | Good geometry test | ⭐⭐⭐ |
| Magnets (pocket) | Ø, thickness, clearance, depth | Modular containers / closures | ⭐⭐⭐⭐⭐ |
| Rubber gaskets | OD, ID, thickness, cross-section | Sealing / vibration isolation | ⭐⭐⭐⭐ |

## Vents, Grilles & Textures

| Family | Key Parameters | Why Useful | Priority |
|--------|---------------|------------|----------|
| Vents / grilles | W × H, pattern (hex/square/louvre), cell size, wall | Enclosure airflow | ⭐⭐⭐⭐ |
| Knurling | pattern (diamond/straight), pitch, depth | Grip surfaces | ⭐⭐⭐ |

---

## Notes

- **Countersinks / counterbores / clearance holes** are arguably higher ROI than screw bodies — model the negative space.
- **PCB enclosures** = Boxes + PCB mounts + Panel cutouts + Vents; build the sub-components first.
- **Dovetails + T-slots** share geometry with the joinery engine; consider a shared `joint_engine.scad`.
- **Bearings pocket** can reuse the `parametric_screws` clearance-hole concept for OD/ID fits.
- Standard data files to create alongside each family (like `wood_screws_ANSI_B18.6.1.csv`):
  - `washers_ANSI_B18.22.1.csv`
  - `nuts_ANSI_B18.2.2.csv`
  - `heat_set_inserts_common.csv` (Brass M2–M6, inch #4–#10)
  - `bearings_ISO_15.csv` (common 608, 624, etc.)
  - `magnets_common.csv` (disc magnets by Ø×H)
