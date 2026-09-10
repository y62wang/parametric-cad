// Chicken feeder stand - SUPPORT-FREE FDM VERSION
// Fits feeder body: 240 x 120 mm
// Stand footprint: 244.6 x 124.6 mm (same as lid footprint)
// Four removable rounded legs: 50 mm tall, 28 mm feet
//
// PRINT ORIENTATION:
//   stand : exactly as modeled, tray/lip facing UP
//   leg   : foot flat on bed, peg pointing UP
//   legs4 : exactly as modeled
//
// No supports required:
// - stand has a flat 3 mm base
// - leg sockets are straight THROUGH sockets, so there is no blind-hole roof/bridge
// - tray lip grows vertically from the base
// - legs grow vertically from a flat 28 x 28 foot
// - rounded corners are only in XY, not unsupported bottom fillets

$fn = 64;
part = "assembly"; // "stand", "leg", "legs4", "assembly"

// -------- Existing feeder / lid dimensions --------
feeder_w = 240;
feeder_d = 120;
stand_outer_w = 244.6;
stand_outer_d = 124.6;

// Pocket gives 0.3 mm clearance per side around the feeder.
pocket_w = 240.6;
pocket_d = 120.6;

// -------- Stand --------
stand_base = 3.0;
lip_h = 14.0;
lip_wall = (stand_outer_w - pocket_w) / 2; // 2 mm

// Reinforced corner pads. The feeder rests on these four pads.
pad_size = 24;
pad_h = 8;
pad_center_inset = 18;

// -------- Leg connector --------
// Straight square peg/socket is intentionally support-free and easy to tune.
peg_size = 16.0;
fit_clearance = 0.4;       // total XY clearance
socket_size = peg_size + fit_clearance;
peg_insert = pad_h;

// -------- Legs --------
leg_height = 50;
leg_shaft = 20;
foot_size = 28;
foot_h = 3;
foot_radius = 4;
shaft_radius = 3;

function leg_x(i) = (i == 0 || i == 2)
    ? pad_center_inset
    : stand_outer_w - pad_center_inset;

function leg_y(i) = (i == 0 || i == 1)
    ? pad_center_inset
    : stand_outer_d - pad_center_inset;

// Rounded rectangle prism with vertical sides.
// XY rounding prints cleanly without support.
module rounded_box_xy(w, d, h, r) {
    linear_extrude(height=h)
        offset(r=r)
            square([w - 2*r, d - 2*r], center=true);
}

module tray_shell() {
    difference() {
        // Flat-bottomed outer tray.
        cube([stand_outer_w, stand_outer_d, lip_h]);

        // Open pocket from z=stand_base upward.
        translate([lip_wall, lip_wall, stand_base])
            cube([pocket_w, pocket_d, lip_h - stand_base + 0.1]);
    }
}

module corner_pad(x, y) {
    translate([x - pad_size/2, y - pad_size/2, 0])
        cube([pad_size, pad_size, pad_h]);
}

module through_socket(x, y) {
    // IMPORTANT: cuts completely through the corner pad.
    // No horizontal roof inside the socket -> no support / no bridge.
    translate([x - socket_size/2,
               y - socket_size/2,
               -0.1])
        cube([socket_size, socket_size, pad_h + 0.2]);
}

module stand() {
    difference() {
        union() {
            tray_shell();
            for (i = [0:3])
                corner_pad(leg_x(i), leg_y(i));
        }

        for (i = [0:3])
            through_socket(leg_x(i), leg_y(i));
    }
}

module peg() {
    // Straight vertical peg. A tiny top lead-in makes assembly easier,
    // but the taper narrows upward, so it is support-free.
    straight_h = peg_insert - 1.5;

    translate([-peg_size/2, -peg_size/2, 0])
        cube([peg_size, peg_size, straight_h]);

    translate([0, 0, straight_h])
        linear_extrude(height=1.5, scale=(peg_size - 1.2)/peg_size)
            square([peg_size, peg_size], center=true);
}

module leg() {
    shaft_h = leg_height - foot_h;

    union() {
        // Flat 28 x 28 footprint goes directly on the print bed.
        rounded_box_xy(foot_size, foot_size, foot_h, foot_radius);

        // 20 x 20 rounded vertical shaft.
        translate([0, 0, foot_h])
            rounded_box_xy(leg_shaft, leg_shaft, shaft_h, shaft_radius);

        // Connector points upward during printing.
        translate([0, 0, leg_height])
            peg();
    }
}

module legs4() {
    // Four legs already oriented for support-free printing.
    spacing = 42;
    for (ix = [0:1], iy = [0:1])
        translate([28 + ix*spacing, 28 + iy*spacing, 0])
            leg();
}

module assembly() {
    translate([0, 0, leg_height])
        stand();

    for (i = [0:3])
        translate([leg_x(i), leg_y(i), 0])
            leg();

    // Ghost feeder for fit visualization only.
    %translate([(stand_outer_w - feeder_w)/2,
               (stand_outer_d - feeder_d)/2,
               leg_height + pad_h])
        cube([feeder_w, feeder_d, 200]);
}

if (part == "stand") stand();
else if (part == "leg") leg();
else if (part == "legs4") legs4();
else assembly();
