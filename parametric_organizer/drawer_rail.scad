// =============================================================
// drawer_rail.scad
// Modular dovetail drawer slide — no rollers required.
//
// Two pieces per side of the drawer:
//   rail_channel()  — "female" piece, mounts to cabinet wall
//   rail_tongue()   — "male" piece, mounts to drawer side wall
//
// How it works
// ─────────────
//   The tongue slides inside the channel along the X axis (rail length).
//   The dovetail shape locks them together vertically — can't fall out.
//   Lubricate with candle wax, PTFE spray, or soap for smooth sliding.
//
// Modular
// ───────
//   Print as many segments as needed to reach full drawer depth.
//   Butt segments end-to-end; alignment pins (optional) or just glue
//   at the joint. The dovetail profile is continuous across joints.
//
// To stop drawer from pulling fully out: print a small end cap
// (a strip that screws across the channel opening at the front end).
//
// Parameters
//   rw      rail width  (Y, mm)                [20]
//   rh      rail height (Z, mm)                [12]
//   seg_len segment length (X, mm)             [100]
//   dt_h    dovetail slot depth (mm)           [5]
//   dt_b    dovetail opening width (mm)        [8]
//   dt_ang  dovetail angle from vertical (°)   [30]
//   tol     sliding clearance per face (mm)    [0.3]
//   mt_d    mounting screw diameter (mm)       [3]
//
// Print orientation
//   Both pieces: flat side down (mounting face on build plate). No supports.
//   PETG recommended — better wear resistance and slight flex.
// =============================================================

$fa = 2; $fs = 0.4;

rw      = 20;
rh      = 12;
seg_len = 100;
dt_h    = 5;
dt_b    = 8;
dt_ang  = 30;
tol     = 0.3;
mt_d    = 3;

dt_exp  = dt_h * tan(dt_ang);   // horizontal flare per side at full depth


// ── helper: extrude 2D child along X axis ──────────────────────────
// In the 2D polygon, first coord = Z (height), second coord = Y (width).
module _extrude_x(len) {
    rotate([0, -90, 0])
    linear_extrude(len)
    children();
}


// ── CHANNEL ────────────────────────────────────────────────────────
// Mounting face: Z = rh (the top face — screw through it into cabinet wall).
// Groove opens at Z = 0 (bottom face, facing the drawer).
//
//   Cross-section (YZ, front view):
//
//   Z=rh ┌────────────────────┐  ← mount to wall here
//        │                    │
//   Z=dh ├───╲            ╱───┤  ← widest point of groove
//        │    ╲          ╱    │
//   Z=0  ├─────┤          ├───┤  ← groove opening (faces drawer)
//        (y0)              (y0+dt_b)

module rail_channel(len = seg_len) {
    y0 = (rw - dt_b) / 2;

    difference() {
        // Outer block
        _extrude_x(len)
        square([rh, rw]);

        // Dovetail groove: extend -0.01 below Z=0 for clean face
        _extrude_x(len)
        polygon([
            [-0.01, y0],
            [-0.01, y0 + dt_b],
            [dt_h,  y0 + dt_b + dt_exp],
            [dt_h,  y0 - dt_exp]
        ]);

        // Mounting screw holes through top (Z=rh) face
        for (x = [len * 0.25, len * 0.75])
            translate([x, rw / 2, rh * 0.5 - 0.01])
                cylinder(d = mt_d + 0.2, h = rh * 0.6, $fn = 16);
    }
}


// ── TONGUE ─────────────────────────────────────────────────────────
// Mounting face: Z = 0 (the bottom flat face — screw through it into drawer wall).
// Dovetail tongue protrudes upward from Z = base_h, slides into channel groove.
//
//   Cross-section (YZ, front view):
//
//        /──────────────\    ← tongue (slightly smaller than groove, tol gap)
//       /                \
//   ───┘                  └──  ← shoulder at Z=base_h
//   ─────────────────────────  ← flat base, Z=0..base_h, mount here

module rail_tongue(len = seg_len) {
    b_t    = dt_b - 2 * tol;
    exp_t  = (dt_h - tol) * tan(dt_ang);
    y0_t   = (rw - b_t) / 2;
    base_h = rh - dt_h;

    difference() {
        _extrude_x(len)
        union() {
            // Flat mounting base
            square([base_h, rw]);
            // Dovetail tongue
            polygon([
                [base_h,             y0_t],
                [base_h,             y0_t + b_t],
                [base_h + dt_h - tol, y0_t + b_t + exp_t],
                [base_h + dt_h - tol, y0_t - exp_t]
            ]);
        }

        // Mounting screw holes through bottom (Z=0) face
        for (x = [len * 0.25, len * 0.75])
            translate([x, rw / 2, -0.01])
                cylinder(d = mt_d + 0.2, h = base_h + 0.02, $fn = 16);
    }
}


// ── DEMO ───────────────────────────────────────────────────────────
// Renders channel and tongue side by side, with tongue offset
// to show the cross-section profile clearly.

color("SteelBlue", 0.9)
rail_channel();

// Tongue: separated by 5mm gap for clarity
translate([0, rw + 8, 0])
color("Tomato", 0.9)
rail_tongue();
