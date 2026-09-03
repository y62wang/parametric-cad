# Kallax Drawer System — Spec

## Target furniture
IKEA Kallax shelf unit — 1 cube, 4 stacked drawers

## Printer
Elegoo Neptune 2 — build plate **256 × 256mm**

## Kallax dimensions
| | mm |
|-|----|
| Internal cube W | 335 |
| Internal cube H | 335 |
| Internal cube D | 390 |

## Drawer dimensions
| | mm | Notes |
|-|----|----|
| W (external) | 330 | 2.5mm clearance each side in Kallax |
| H (external) | 80 | 4 stacked: (335 − 4×3mm gap) / 4 ≈ 80mm |
| D (external) | 380 | 10mm shorter than Kallax depth |
| Board thickness | 5mm | |
| Count | 4 | |

## Panel dimensions (with board_t = 5mm)
Construction: side panels are full depth; front/back fit between sides.

| Panel | External size | Split halves | Fits on 256mm bed? |
|-------|--------------|-------------|-------------------|
| Side (×2 per drawer) | 380 × 80 × 5mm | 2× (190 × 80mm) | ✓ |
| Front (×1 per drawer) | 320 × 80 × 5mm | 2× (160 × 80mm) | ✓ |
| Back (×1 per drawer) | 320 × 80 × 5mm | 2× (160 × 80mm) | ✓ |

Front/back width = 330 − 2×5 = 320mm (fits between sides)

## Print plan — 4 drawers total

### Pieces per drawer
| Piece | Count | Size |
|-------|-------|------|
| Side half-A (pins) | 2 | 190 × 80 × 5mm |
| Side half-B (holes) | 2 | 190 × 80 × 5mm |
| Front/back half-A | 4 | 160 × 80 × 5mm |
| Front/back half-B | 4 | 160 × 80 × 5mm |
| Corner joints | 4 | ~23 × 23 × 12mm |
| Rail tongue segments | 4 | ~95 × 20 × 8mm |

### Total across 4 drawers
| Piece | Total | Per plate | Plates |
|-------|-------|-----------|--------|
| Side half-A | 8 | 3 | 3 |
| Side half-B | 8 | 3 | 3 |
| Front/back half-A | 16 | 3 | 6 |
| Front/back half-B | 16 | 3 | 6 |
| Corner joints | 16 | 8 | 2 |
| Rail tongue segments | 16 | 8 | 2 |
| Rail channel segments | 16 | 8 | 2 |
| Divider L-brackets | 6 | 6 | 1 |
| **Total** | | | **~25 plates** |

Plate packing for panels (printed flat, 5mm tall):
- 190×80mm pieces: 3 per plate (1 wide × 3 tall in 256mm)
- 160×80mm pieces: 3 per plate (1 wide × 3 tall)

## Rail system
**Type**: Bottom-mount dovetail (no rollers)
- Side-mount ruled out: only 2.5mm clearance per side `(335−330)/2`
- Channel: mounts to horizontal surface, opening faces up, centered
- Tongue: mounts to drawer bottom board, centered
- Lube: candle wax or PTFE spray
- Rail length: 380mm → 4 × 95mm printed segments per drawer

### Horizontal surfaces (rail mounting points)
| Level | Surface | Height from Kallax floor |
|-------|---------|--------------------------|
| 1 | Kallax floor (existing) | 0mm |
| 2 | Divider shelf | ~83mm |
| 3 | Divider shelf | ~166mm |
| 4 | Divider shelf | ~249mm |

**Divider shelves**: 3× wood (330 × 390mm, ~6mm). Secured with 6× printed L-brackets.

## Buy list
| Item | Qty | Size |
|------|-----|------|
| Plywood/MDF (divider shelves) | 3 | 330 × 390mm, 6mm |
| Plywood/MDF (drawer bottoms) | 4 | 320 × 370mm, 6mm |
| M3 × 15mm screws | ~60 | For rails + brackets |

## Source files (parametric_organizer/)
| File | Module | Role |
|------|--------|------|
| drawer_board.scad | `board_half()` | Panel halves with lap joint |
| drawer_connectors.scad | `corner_joint()` | 90° corner connectors |
| drawer_rail.scad | `rail_channel()` | Bottom rail channel |
| drawer_rail.scad | `rail_tongue()` | Bottom rail tongue |

## Open questions
- [x] Board thickness → 5mm
- [x] 4 drawers, stacked in 1 cube
- [ ] Drawer front: flush with Kallax face, or slight overhang?
- [ ] Handle
- [ ] Stop mechanism (prevent full pull-out)
