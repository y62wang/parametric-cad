// =============================================================
// drawer_connectors.scad
// Parametric 3D-print connectors for split IKEA-style drawer boards.
//
// Two joint types:
//   flat_splice(...)    join two boards end-to-end, same plane
//   corner_joint(...)   join two boards at 90°
//
// Design strategy:
//   • Each board end slides into a snug U-channel (slot) and is locked
//     with M3 bolts that pass through the connector and the board.
//   • Walls are 3 mm — minimum FDM structural thickness.
//   • No supports needed: print flat on the build plate.
//   • Glue the joint for permanent assemblies; bolts alone for removable ones.
//
// Shared parameters
//   board_t   board thickness (mm)               [default 6]
//   board_w   board width = drawer height (mm)   [default 80]
//   grip      how deep each board inserts (mm)   [default 20]
//   wall      connector wall thickness (mm)      [default 3]
//   bolt_d    through-bolt diameter (0 = none)   [default 3  → M3]
//   tol       board-into-slot clearance          [default 0.25]
// =============================================================

$fa = 2; $fs = 0.4;
_tol = 0.25;   // FDM fit tolerance (add to slot size, not board size)


// =============================================================
// TYPE 1 — FLAT SPLICE
// Join two boards end-to-end in the same plane.
//
// How it works
// ─────────────
//   The connector is a hollow H-profile:
//   • Pocket A — board A slides in from the left  (−X face open)
//   • Pocket B — board B slides in from the right (+X face open)
//   • Center rib — 'wall' thick; separates the two pockets
//   • Top & bottom walls — 'wall' thick
//   Two M3 bolts per pocket pass through top→board→bottom to lock.
//
// Cross-section view (boards going left-right, Z = up):
//
//   ┌────────────────────────┐  ← top wall (wall mm)
//   │←── board A  │  board B─→│  ← slot (board_t + tol)
//   └────────────────────────┘  ← bottom wall (wall mm)
//   |←── grip ───|rib|─ grip──|
//
// Print orientation: flat on build plate (Z = up). No supports.
// =============================================================

module flat_splice(
    board_t = 6,
    board_w = 80,
    grip    = 20,
    wall    = 3,
    bolt_d  = 3
) {
    slot_h    = board_t + _tol;
    outer_h   = slot_h + 2 * wall;
    outer_len = 2 * grip + wall;   // pocket A + center rib + pocket B

    difference() {
        // ── solid outer block ─────────────────────────────────
        cube([outer_len, board_w, outer_h]);

        // ── pocket A — open on −X face (board enters from left) ─
        translate([-0.01, -0.01, wall])
            cube([grip + 0.01, board_w + 0.02, slot_h]);

        // ── pocket B — open on +X face (board enters from right) ─
        translate([grip + wall - 0.01, -0.01, wall])
            cube([grip + 0.02, board_w + 0.02, slot_h]);

        // ── bolt holes — through Z, 2 per pocket ──────────────
        // Placed at 30 % and 70 % of board_w so they clear edges.
        if (bolt_d > 0) {
            for (bx = [grip / 2,            // centre of pocket A
                       grip + wall + grip / 2])  // centre of pocket B
            for (by = [board_w * 0.3, board_w * 0.7])
                translate([bx, by, -0.01])
                    cylinder(d = bolt_d + _tol, h = outer_h + 0.02, $fn = 16);
        }

        // ── hollow center rib interior (material saving) ───────
        // Only if the rib is wider than 4 mm; leaves a 1 mm shell.
        if (wall > 4)
            translate([grip + 1, 1, 1])
                cube([wall - 2, board_w - 2, outer_h - 2]);
    }
}


// =============================================================
// TYPE 2 — CORNER JOINT
// Join two boards at 90° (e.g., drawer side ↔ drawer front).
//
// How it works
// ─────────────
//   The connector is an L-shaped body, each arm being a U-channel:
//   • Arm A — board A slides in from the +X face
//   • Arm B — board B slides in from the +Y face
//   • The arms overlap in a solid corner block (grip+wall square).
//     Below and above the slot zone this block is fully solid;
//     within the slot zone four 3 mm corner pillars carry the load.
//
// Top-view schematic (looking down):
//
//            board A →
//   ┌──────────────────┐
//   │   arm A (slot)   │    ← board A enters from +X
//   │ ─────────────── │
//   ├──────────────┐   │
//   │   arm B      │   │    ← board B enters from +Y (going up in this view)
//   │   (slot)     │   │
//   └──────────────┘   │
//
// Print orientation: flat on build plate (Z = up). No supports.
// =============================================================

module corner_joint(
    board_t = 6,
    board_w = 80,
    grip    = 20,
    wall    = 3,
    bolt_d  = 3
) {
    slot_h  = board_t + _tol;
    outer_h = slot_h + 2 * wall;
    ow      = grip + wall;    // arm width = insertion depth + back wall

    difference() {
        union() {
            // ── arm A — board_w in Y, ow deep in X ──────────────
            cube([ow, board_w, outer_h]);

            // ── arm B — board_w in X, ow deep in Y ──────────────
            cube([board_w, ow, outer_h]);
            // The two arms overlap in the corner block [0,ow]×[0,ow],
            // which union() handles naturally — no double-geometry issue.
        }

        // ── slot A — board enters from +X face ────────────────
        // Slot runs from x=wall inward to x=ow (open at x=ow).
        // Full board_w in Y, slot_h in Z, centred at wall offset from base.
        translate([wall, -0.01, wall])
            cube([grip + 0.01, board_w + 0.02, slot_h]);

        // ── slot B — board enters from +Y face ────────────────
        translate([-0.01, wall, wall])
            cube([board_w + 0.02, grip + 0.01, slot_h]);

        // ── bolt holes for arm A — 2 bolts through Z ──────────
        if (bolt_d > 0) {
            for (by = [board_w * 0.3, board_w * 0.7])
                translate([wall + grip / 2, by, -0.01])
                    cylinder(d = bolt_d + _tol, h = outer_h + 0.02, $fn = 16);

            // ── bolt holes for arm B ───────────────────────────
            for (bx = [board_w * 0.3, board_w * 0.7])
                translate([bx, wall + grip / 2, -0.01])
                    cylinder(d = bolt_d + _tol, h = outer_h + 0.02, $fn = 16);
        }
    }
}


// =============================================================
// DEMO — renders both connectors side by side for preview.
//
// Default values match a 6 mm thick board, 80 mm tall (drawer height),
// with M3 bolts. Adjust to your actual board dimensions.
//
// To print:
//   1. Render (F6) and export each connector to STL separately.
//   2. Print flat (the wide face on the build plate). No supports.
//   3. For the flat splice: bolt through top + bottom with M3 × 15 mm.
//   4. For the corner joint: bolt through top + bottom with M3 × 15 mm.
//   5. Optional: apply CA glue in the slot for a permanent bond.
//
// Material note: PETG > PLA for a drawer (humidity resistance, flex).
// =============================================================

_board_t = 6;
_board_w = 80;
_grip    = 20;
_wall    = 3;
_bolt_d  = 3;

color("SteelBlue", 0.9)
flat_splice(
    board_t = _board_t,
    board_w = _board_w,
    grip    = _grip,
    wall    = _wall,
    bolt_d  = _bolt_d
);

// Corner joint offset to the right for side-by-side view
translate([2 * _grip + _wall + 20, 0, 0])
color("Tomato", 0.9)
corner_joint(
    board_t = _board_t,
    board_w = _board_w,
    grip    = _grip,
    wall    = _wall,
    bolt_d  = _bolt_d
);
