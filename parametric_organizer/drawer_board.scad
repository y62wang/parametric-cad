// =============================================================
// drawer_board.scad
// Printable drawer wall board segments with integrated lap joints.
//
// A single board is split into two halves; each half prints within
// your printer's bed. They connect via an overlapping lap joint —
// no separate connector piece needed.
//
// Usage
// ─────
//   Print one "a" half and one "b" half per board.
//   Slide them together (A on bottom, B on top at joint).
//   Pins auto-align. Glue for permanent; friction-fit alone is strong.
//
// For corners (90°) use corner_joint from drawer_connectors.scad,
// OR design boards with a matching rabbet end (see corner_board below).
//
// Parameters
//   length     total segment length (mm)          [120]
//   width      board height = drawer wall height   [80]
//   thickness  board thickness                     [6]
//   lap        overlap depth of lap joint          [20]
//   pin_d      alignment pin diameter (0 = none)   [2]
// =============================================================

$fa = 2; $fs = 0.4;
_tol = 0.25;


// =============================================================
// board_half() — one printable segment
//
// joint_end = "a"  → step removed from top half; alignment pins added.
//                    Print this as the BOTTOM piece of the joint.
// joint_end = "b"  → step removed from bottom half; pin holes added.
//                    Print this as the TOP piece of the joint.
// joint_side       = "left" | "right"  which end has the lap feature.
//
// Assembly cross-section at joint (side view, Z = up):
//
//   ┌──────────────────────────────┐  ← Board B (joint_end="b")
//   │  [top half, rest of board]   │
//   │ ┌────────────────────────────┘  ← B's step (bottom removed)
//   │ │
//   └─┘ ┌──────────────────────────┐  ← A's step (top removed)
//       │  [bottom half, rest]     │
//       └──────────────────────────┘  ← Board A (joint_end="a")
//       |←────── lap ─────────────|
//
// Print flat on the build plate (width × length footprint, thickness tall).
// No supports needed.
// =============================================================

module board_half(
    length     = 120,
    width      = 80,
    thickness  = 6,
    joint_end  = "a",
    joint_side = "right",
    lap        = 20,
    pin_d      = 2,
    pin_h      = 3
) {
    ht = thickness / 2;

    // x-coordinate of lap region start
    lx = (joint_side == "right") ? length - lap : 0;

    difference() {
        cube([length, width, thickness]);

        if (joint_end == "a") {
            // Remove top half at lap region
            translate([lx - 0.01, -0.01, ht])
                cube([lap + 0.02, width + 0.02, ht + 0.01]);
        }

        if (joint_end == "b") {
            // Remove bottom half at lap region
            translate([lx - 0.01, -0.01, -0.01])
                cube([lap + 0.02, width + 0.02, ht + 0.01]);

            // Pin holes: drilled from mating surface (z = ht) upward
            if (pin_d > 0)
                for (py = [width * 0.3, width * 0.7])
                    translate([lx + lap / 2, py, ht - 0.01])
                        cylinder(d = pin_d + _tol, h = pin_h + 0.5, $fn = 16);
        }
    }

    // Alignment pins on "a" board: protrude upward from z = ht
    if (joint_end == "a" && pin_d > 0)
        for (py = [width * 0.3, width * 0.7])
            translate([lx + lap / 2, py, ht])
                cylinder(d = pin_d, h = pin_h, $fn = 16);
}


// =============================================================
// DEMO — board A and board B side by side
//
// In the assembled board, slide B (top piece) over A (bottom piece)
// at the lap zone. The pins engage the holes; glue or press-fit.
// =============================================================

_len  = 120;
_w    = 80;
_t    = 6;
_lap  = 20;
_pd   = 2;

// Board A — bottom piece of joint (joint on right end)
color("SteelBlue", 0.9)
board_half(length=_len, width=_w, thickness=_t,
           joint_end="a", joint_side="right",
           lap=_lap, pin_d=_pd);

// Board B — top piece of joint (joint on left end), offset for preview
translate([0, _w + 10, 0])
color("Tomato", 0.9)
board_half(length=_len, width=_w, thickness=_t,
           joint_end="b", joint_side="left",
           lap=_lap, pin_d=_pd);
