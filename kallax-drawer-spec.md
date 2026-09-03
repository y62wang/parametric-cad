# Kallax Drawer System — Spec

## Target furniture
IKEA Kallax shelf unit (4-slot configuration)

## Kallax dimensions
| | mm |
|-|----|
| Internal cube W | 335 |
| Internal cube H | 335 |
| Internal cube D | 390 |

## Drawer dimensions
| | mm |
|-|----|
| W | 330 |
| H | 80 (4 stacked in 1 Kallax cube) |
| D | 380 |
| Count | 4 |

Height math: (335 - 5×3mm gap) / 4 ≈ 80mm per drawer

## Construction
| Component | Material | Notes |
|-----------|----------|-------|
| Side panels | PLA/PETG printed, 6mm | Split into segments, lap-joint |
| Front panel | PLA/PETG printed, 6mm | Split into segments, lap-joint |
| Back panel | PLA/PETG printed, 6mm | Split into segments, lap-joint |
| Bottom board | Wood (plywood/MDF) | Too large to print; ~330×380mm |
| Corner joints | PLA/PETG printed | Reuse corner_joint.scad |
| Drawer rail | PLA/PETG printed | Bottom-mount dovetail (see below) |

## Rail system
**Type**: Bottom-mount dovetail (no rollers)
- Reason: side-mount impossible — only 2.5mm clearance per side
  `(335 - 330) / 2 = 2.5mm`
- Channel mounts to each **horizontal surface**, opening faces up, centered
- Tongue mounts to **drawer bottom**, tongue faces down, centered
- Lubrication: candle wax or PTFE spray
- Rail length: 380mm total → 4 × 100mm printed segments joined end-to-end

### Horizontal surfaces (1 per drawer)
4 drawers require 4 rail mounting surfaces:

| Level | Surface | Height from floor |
|-------|---------|-------------------|
| 1 (bottom) | Kallax floor (existing) | 0mm |
| 2 | Divider shelf | ~83mm |
| 3 | Divider shelf | ~166mm |
| 4 | Divider shelf | ~249mm |

**Divider shelves**: 3× wood panel (plywood/MDF), 330 × 390mm, ~6mm thick.
Secured to Kallax side walls with printed L-brackets (×6 total, 2 per shelf).
Rail channel screwed to top face of each shelf (+ Kallax floor for level 1).

## Existing modules (in parametric_organizer/)
| File | Module | Use |
|------|--------|-----|
| drawer_board.scad | `board_half(a/b)` | Panel segments with lap joint |
| drawer_connectors.scad | `corner_joint()` | 90° corners |
| drawer_connectors.scad | `flat_splice()` | Flat end-to-end join (alt to lap) |
| drawer_rail.scad | `rail_channel()` | Bottom rail channel |
| drawer_rail.scad | `rail_tongue()` | Bottom rail tongue |

## Open questions
- [x] 4 drawers in how many cubes? → 4 stacked in 1 cube
- [ ] Board thickness: 6mm (default) or thicker for rigidity on large panels?
- [ ] Drawer front: flush with Kallax face, or slight overhang?
- [ ] Handle: printed handle or none?
- [ ] Stop mechanism: prevent drawer from pulling out fully?
