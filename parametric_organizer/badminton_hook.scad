// ── Badminton Racket Wall Hook — Side-Entry Keyhole ────────────────────────
// Shaft pushes in from the RIGHT face (X+) through a narrow entry gap,
// snaps into a circular pocket. Lips + gravity hold it in place.
//
//     Top view (XY plane):
//
//     ┌──────────────────────────────┐
//     │                              │  ← arm tip
//     │    (O)──────┤  (O)──────┤   │  ← keyhole pockets, entry on right face
//     │                              │
//     └──────────────────────────────┘  ← wall plate
//
//     Shaft pushes in → snaps past lips → seated in pocket (can't roll out)

/* ── Parameters ─────────────────────────────────────────────────────────── */
shaft_r     = 3.6;    // max shaft radius (mm)
snap        = 0.3;    // snap interference per side — firm push, stays in
clearance   = 0.8;    // running clearance per side once seated

pocket_r    = shaft_r + clearance;         // pocket radius ≈ 4.4mm
entry_gap   = shaft_r * 2 - snap * 2;     // entry width ≈ 6.6mm (narrower than shaft)

wall_t      = 8;      // wall thickness each side of pocket (mm)
arm_h       = 22;     // arm height — tall = tilt resistant
r           = 3;      // edge rounding radius

num_slots   = 2;      // ← change to add more rackets
slot_pitch  = 25;     // slot centre-to-centre spacing (mm)
arm_y_start = 12;     // wall plate → first slot centre (mm)

plate_thick = 8;
screw_d     = 4.5;    // M4 screw hole diameter (mm)

/* ── Derived ─────────────────────────────────────────────────────────────── */
arm_w      = 2 * wall_t + pocket_r * 2;   // ≈ 24.8mm
arm_length = arm_y_start
           + (num_slots - 1) * slot_pitch
           + pocket_r
           + 2 * r;        // rounded tip clears last pocket
plate_h    = arm_h + 20;
plate_w    = arm_w;

echo(str("arm_w = ", arm_w, " mm"));
echo(str("arm_length = ", arm_length, " mm"));
echo(str("pocket_r = ", pocket_r, " mm  entry_gap = ", entry_gap, " mm  (shaft Ø = ", shaft_r*2, " mm)"));

/* ── Keyhole slot void ────────────────────────────────────────────────────
   Circular pocket centered in X, at y_center in Y, full arm height in Z.
   Entry channel runs from the pocket center to the right face (X+).
   Shaft pushes in from the right, snaps past lips at Y = ±entry_gap/2.
   ─────────────────────────────────────────────────────────────────────── */
module slot_void(y_center) {
    // Circular pocket — shaft seats here
    translate([arm_w / 2, y_center, -0.1])
        cylinder(r=pocket_r, h=arm_h + 0.2, $fn=32);

    // Entry channel: pocket center → right face (X+)
    translate([arm_w / 2, y_center - entry_gap / 2, -0.1])
        cube([arm_w / 2 + 0.1, entry_gap, arm_h + 0.2]);
}

/* ── Rounded arm body ────────────────────────────────────────────────────── */
module arm_body() {
    hull() {
        for (x = [r, arm_w - r]) {
            for (z = [r, arm_h - r]) {
                translate([x, 0, z])
                    rotate([-90, 0, 0])
                        cylinder(r=r, h=arm_length - r, $fn=32);
                translate([x, arm_length - r, z])
                    sphere(r=r, $fn=32);
            }
        }
    }
}

/* ── Hook arm ─────────────────────────────────────────────────────────── */
module hook_arm() {
    difference() {
        arm_body();
        for (i = [0 : num_slots - 1])
            slot_void(arm_y_start + i * slot_pitch);
    }
}

/* ── Wall mounting plate ─────────────────────────────────────────────── */
module wall_plate() {
    difference() {
        hull() {
            for (x = [r, plate_w - r]) {
                for (z = [r, plate_h - r]) {
                    translate([x, 0, z])
                        rotate([-90, 0, 0])
                            cylinder(r=r, h=plate_thick, $fn=32);
                }
            }
        }
        for (x = [plate_w * 0.25, plate_w * 0.75])
            for (z = [10, plate_h - 10])
                translate([x, -0.1, z])
                    rotate([-90, 0, 0])
                        cylinder(d=screw_d, h=plate_thick + 0.2, $fn=24);
    }
}

/* ── Assembly ────────────────────────────────────────────────────────── */
module badminton_hook() {
    wall_plate();
    translate([0, plate_thick, 0])
        hook_arm();
}

badminton_hook();
