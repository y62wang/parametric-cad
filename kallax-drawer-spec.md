# Kallax Drawer System — Spec

## Target furniture
IKEA Kallax shelf unit (4-slot configuration)

## Kallax dimensions
| | mm |
|-|----|
| Internal cube W | 335 |
| Internal cube H | 335 |
| Internal cube D | 390 |

## Drawer dimensions (target)
| | mm |
|-|----|
| W | 330 |
| H | TBD — 4 drawers total (see open questions) |
| D | 380 |
| Count | 4 |

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
- Channel mounts to **Kallax floor**, opening faces up, centered
- Tongue mounts to **drawer bottom**, tongue faces down, centered
- Lubrication: candle wax or PTFE spray
- Rail length: 380mm total → 4 × 100mm printed segments joined end-to-end

## Existing modules (in parametric_organizer/)
| File | Module | Use |
|------|--------|-----|
| drawer_board.scad | `board_half(a/b)` | Panel segments with lap joint |
| drawer_connectors.scad | `corner_joint()` | 90° corners |
| drawer_connectors.scad | `flat_splice()` | Flat end-to-end join (alt to lap) |
| drawer_rail.scad | `rail_channel()` | Bottom rail channel |
| drawer_rail.scad | `rail_tongue()` | Bottom rail tongue |

## Open questions
- [ ] 4 drawers in how many cubes?
  - Option A: 1 cube × 4 drawers each ~80mm tall (very shallow)
  - Option B: 2 cubes × 2 drawers each ~160mm tall ← likely
  - Option C: 4 cubes × 1 drawer each 330mm tall (full height per cube)
- [ ] Board thickness: 6mm (default) or thicker for larger panels?
- [ ] Drawer front: flush with Kallax face, slight overhang, or separate decorative face?
- [ ] Handle: printed handle or none?
- [ ] Stop mechanism: prevent drawer from pulling out fully?
