/* [Part to Display & Export] */
// Choose which 3D model part to display and export:
part_to_export = "print_plate"; // [print_plate:All Parts on One Plate (Batch Print), single_leg:Single Leg Only (Print 4x), single_bar:Single Roosting Bar (Print 3x), single_pin:Single Wedge Pin (Print 6x), assembled:Assembled Standing Stand]

/* [Roost Dimensions] */
// Top apex roosting bar height (mm) - 15cm requested
top_bar_height = 150; // [120:5:180]
// Lower roosting bars height (mm) - 5cm requested
lower_bar_height = 50; // [30:5:80]
// Clear roosting length between the two A-frame sides (mm)
bar_length = 150; // [100:5:200]
// Diameter of the roosting bars (mm) - comfortable chick grip
bar_diameter = 15; // [12:1:20]
// Slant angle of each leg from vertical (degrees)
leg_angle = 24; // [18:1:32]

/* [Anti-Shake & Joint Engineering] */
// Fit clearance tolerance for holes (mm). 0.25mm gives a snug push-fit.
fit_tolerance = 0.25; // [0.15:0.05:0.45]
// Enable wedged locking pins through tenons for zero-shake rigidity
use_locking_pins = true;
// Diameter of connecting tenons (mm)
tenon_dia = 10.0; // [8:1:12]

/* [Leg & Flat Foot Geometry] */
// Thickness of each individual leg slat (mm)
leg_thickness = 6; // [4:1:8]
// Width of the straight leg shaft (mm)
leg_width = 16; // [12:1:22]
// Total length of the flat foot sole resting on the ground (mm)
foot_length = 36; // [26:2:46]
// Height of the foot pad (mm)
foot_height = 10; // [7:1:15]

/* [Print Plate Spacing] */
// Center-to-center spacing between legs on the build plate (mm)
leg_spacing = 35; // [30:1:42]
// Center-to-center spacing between roosting bars on the build plate (mm)
bar_spacing = 20; // [17:1:28]

/* [Colors] */
leg_color_1 = "#E2C499"; // Natural pine tone
leg_color_2 = "#D5B487"; // Natural birch tone
bar_color   = "#C3905A"; // Turned dowel roost bar
pin_color   = "#A76835"; // Hardwood locking wedge pin
bed_color   = "#6B7280"; // Build plate frame color

/* [Print Bed Dimensions for Reference] */
bed_size = 220; // 220x220 mm standard build plate
show_bed_outline = true;

// --- Exact Mathematical Derivations ---
shaft_length = top_bar_height / cos(leg_angle);
dist_apex_to_lower = (top_bar_height - lower_bar_height) / cos(leg_angle);

// Hole diameter with printer fit tolerance
hole_dia = tenon_dia + fit_tolerance;

// Total tenon length to accommodate dual-pin locking slots and chamfer
tenon_length = 2 * leg_thickness + 6.0;

// Flat cut on bars for zero-support bed printing
flat_cut_bar = 2.0;
bar_center_z = bar_diameter / 2 - flat_cut_bar;

$fn = 48;

// ================= MAIN RENDER DISPATCHER =================
if (part_to_export == "print_plate") {
    print_plate_layout();
} else if (part_to_export == "assembled") {
    assembled_model();
} else if (part_to_export == "single_leg") {
    // Isolated single leg centered flat on bed at [0, 0, 0] (Print 4x)
    color(leg_color_1)
    single_leg_centered();
} else if (part_to_export == "single_bar") {
    // Isolated single bar centered flat on bed at [0, 0, 0] (Print 3x)
    color(bar_color)
    single_bar_centered();
} else if (part_to_export == "single_pin") {
    // Isolated single wedge pin centered flat on bed at [0, 0, 0] (Print 6x)
    color(pin_color)
    single_pin_centered();
}

// ================= INDIVIDUAL PART MODULES =================
// Centered at [0, 0, 0] flat on the bed for individual 3D printing export

module single_leg_centered() {
    translate([0, shaft_length / 2, 0])
    linear_extrude(height = leg_thickness, convexity = 4)
    leg_2d_profile();
}

module single_bar_centered() {
    translate([0, 0, bar_center_z])
    roosting_bar();
}

module single_pin_centered() {
    translate([0, 0, 1.2])
    printable_wedge_pin();
}

// ================= PRINT PLATE LAYOUT =================
module print_plate_layout() {
    // Print bed outline (rests at Z = 0)
    if (show_bed_outline) {
        %translate([0, 0, -0.6])
        color([0.55, 0.55, 0.55, 0.25])
        cube([bed_size, bed_size, 1.2], center = true);

        // Subtle bed alignment grid
        %translate([0, 0, 0.05])
        color([0.4, 0.4, 0.4, 0.3]) {
            for (g = [-100:20:100]) {
                translate([g, 0, 0]) cube([0.6, 200, 0.1], center = true);
                translate([0, g, 0]) cube([200, 0.6, 0.1], center = true);
            }
        }
    }

    // Plate Layout: All pieces resting 100% FLAT ON THE GROUND (Z = 0)
    // 4 Identical Straight Legs with Flat Feet + 3 Bars + 6 Locking Wedge Pins
    
    // --- 4 Identical Leg Slats ---
    translate([-75, 0, 0]) color(leg_color_1) flat_printable_leg();
    translate([-40, 0, 0]) color(leg_color_2) flat_printable_leg();
    translate([ -5, 0, 0]) color(leg_color_1) flat_printable_leg();
    translate([ 30, 0, 0]) color(leg_color_2) flat_printable_leg();

    // --- 3 Identical Roosting Bars ---
    translate([62, 0, 0]) flat_printable_bar();
    translate([82, 0, 0]) flat_printable_bar();
    translate([102, 0, 0]) flat_printable_bar();

    // --- 6 Tapered Locking Wedge Pins ---
    if (use_locking_pins) {
        // Bay 1 (between Leg 1 and Leg 2)
        translate([-57.5,  25, 0]) color(pin_color) flat_printable_wedge_pin();
        translate([-57.5, -25, 0]) color(pin_color) flat_printable_wedge_pin();

        // Bay 2 (between Leg 2 and Leg 3)
        translate([-22.5,  25, 0]) color(pin_color) flat_printable_wedge_pin();
        translate([-22.5, -25, 0]) color(pin_color) flat_printable_wedge_pin();

        // Bay 3 (between Leg 3 and Leg 4)
        translate([ 12.5,  25, 0]) color(pin_color) flat_printable_wedge_pin();
        translate([ 12.5, -25, 0]) color(pin_color) flat_printable_wedge_pin();
    }
}

// Single leg piece laid flat on the ground (Z = 0 to Z = leg_thickness)
module flat_printable_leg() {
    translate([0, shaft_length / 2 - 10, 0])
    linear_extrude(height = leg_thickness, convexity = 4)
    leg_2d_profile();
}

// Roosting bar laid flat on the ground (Z = 0 to Z = bar_diameter - flat_cut_bar)
module flat_printable_bar() {
    translate([0, 0, bar_center_z])
    roosting_bar();
}

// Tapered wedge pin laid flat on the ground (Z = 0 to Z = 2.4)
module flat_printable_wedge_pin() {
    translate([0, 0, 1.2])
    printable_wedge_pin();
}

// ================= ASSEMBLED MODEL =================
module assembled_model() {
    // --- Left A-Frame (at -Y) ---
    // Front Leg (tilted forward by +leg_angle, foot sole 100% flat on Z=0)
    translate([0, -bar_length / 2 - leg_thickness / 2, 0])
    color(leg_color_1)
    placed_leg(tilt = leg_angle, flip = false);

    // Rear Leg (tilted backward by -leg_angle, foot sole 100% flat on Z=0)
    translate([0, -bar_length / 2 + leg_thickness / 2, 0])
    color(leg_color_2)
    placed_leg(tilt = -leg_angle, flip = true);

    // --- Right A-Frame (at +Y) ---
    // Front Leg (inner, tilted forward)
    translate([0, bar_length / 2 - leg_thickness / 2, 0])
    color(leg_color_1)
    placed_leg(tilt = leg_angle, flip = false);

    // Rear Leg (outer, tilted backward)
    translate([0, bar_length / 2 + leg_thickness / 2, 0])
    color(leg_color_2)
    placed_leg(tilt = -leg_angle, flip = true);

    // --- 3 Roosting Bars (100% Identical) ---
    // 1. Top Apex Roosting Bar (15 cm level)
    translate([0, 0, top_bar_height])
    roosting_bar();

    // 2. Lower Front Roosting Bar (5 cm level)
    lower_x = dist_apex_to_lower * sin(leg_angle);
    translate([lower_x, 0, lower_bar_height])
    roosting_bar();

    // 3. Lower Rear Roosting Bar (5 cm level)
    translate([-lower_x, 0, lower_bar_height])
    roosting_bar();

    // --- Tapered Locking Wedge Pins ---
    if (use_locking_pins) {
        // Top bar wedges
        translate([0, -bar_length / 2 - 2 * leg_thickness - 1.2, top_bar_height])
        inserted_wedge_pin();

        translate([0, bar_length / 2 + 2 * leg_thickness + 1.2, top_bar_height])
        inserted_wedge_pin();

        // Lower Front wedges
        translate([lower_x, -bar_length / 2 - leg_thickness - 1.2, lower_bar_height])
        inserted_wedge_pin();

        translate([lower_x, bar_length / 2 + leg_thickness + 1.2, lower_bar_height])
        inserted_wedge_pin();

        // Lower Rear wedges
        translate([-lower_x, -bar_length / 2 - leg_thickness - 1.2, lower_bar_height])
        inserted_wedge_pin();

        translate([-lower_x, bar_length / 2 + leg_thickness + 1.2, lower_bar_height])
        inserted_wedge_pin();
    }
}

// Places a straight leg into assembled 3D position
module placed_leg(tilt = 24, flip = false) {
    translate([0, 0, top_bar_height])
    rotate([0, tilt, 0])
    rotate([90, 0, 0])
    if (flip) {
        // Flip 180° around leg long axis to mirror foot slant
        rotate([0, 180, 0])
        translate([0, 0, -leg_thickness / 2])
        linear_extrude(height = leg_thickness, convexity = 4)
        leg_2d_profile();
    } else {
        translate([0, 0, -leg_thickness / 2])
        linear_extrude(height = leg_thickness, convexity = 4)
        leg_2d_profile();
    }
}

// Wedge pin dropped vertically into the tenon slot
module inserted_wedge_pin() {
    color(pin_color)
    translate([0, 0, 2])
    rotate([90, 0, 0])
    printable_wedge_pin();
}

// Tapered wedge pin geometry
module printable_wedge_pin() {
    linear_extrude(height = 2.4, center = true)
    hull() {
        // Finger grip head at top
        translate([0, 10]) circle(r = 3.5, $fn = 24);
        // Tapered shaft: 3.6mm near head down to 2.4mm at tip (clamps tight!)
        translate([-1.8, 5]) square([3.6, 1]);
        translate([-1.2, -8]) square([2.4, 1]);
        translate([0, -8]) circle(r = 1.2, $fn = 20);
    }
}

// ================= 2D LEG PROFILE =================
// Both holes are mathematically locked at X = 0 (DEAD CENTER in the shaft).
// The foot pad features a guaranteed 100% horizontal flat sole on the ground!
module leg_2d_profile() {
    apex_r = 12;
    foot_toe = foot_length * 0.55;
    foot_heel = foot_length * 0.45;

    // Unit vectors along floor and normal to floor
    rad = leg_angle * PI / 180;
    tx = cos(leg_angle);
    ty = -sin(leg_angle);
    nx = sin(leg_angle);
    ny = cos(leg_angle);

    // Floor contact center point
    p0_x = 0;
    p0_y = -shaft_length;

    difference() {
        union() {
            // 1. Apex rounded head centered at [0, 0]
            circle(r = apex_r);

            // 2. Straight leg shaft (width = leg_width, exactly centered on X = 0)
            translate([-leg_width / 2, -shaft_length + foot_height * 0.6])
            square([leg_width, shaft_length - foot_height * 0.6]);

            // 3. Flat Foot Pad:
            // The sole is a straight flat edge connecting Heel to Toe.
            // When tilted by +leg_angle, this edge is mathematically 100% horizontal on Z = 0!
            hull() {
                // Flat Sole line segment (resting directly on ground line)
                polygon([
                    [p0_x - foot_heel * tx, p0_y - foot_heel * ty],
                    [p0_x + foot_toe * tx,  p0_y + foot_toe * ty],
                    [p0_x + foot_toe * tx + 0.5 * nx, p0_y + foot_toe * ty + 0.5 * ny],
                    [p0_x - foot_heel * tx + 0.5 * nx, p0_y - foot_heel * ty + 0.5 * ny]
                ]);

                // Rounded toe corner
                translate([p0_x + (foot_toe - 3) * tx + (foot_height - 3) * nx,
                           p0_y + (foot_toe - 3) * ty + (foot_height - 3) * ny])
                circle(r = 3);

                // Rounded heel corner
                translate([p0_x - (foot_heel - 3) * tx + (foot_height - 3) * nx,
                           p0_y - (foot_heel - 3) * ty + (foot_height - 3) * ny])
                circle(r = 3);

                // Junction blending into the leg shaft
                translate([-leg_width / 2, -shaft_length + foot_height * 0.6])
                square([leg_width, 2]);
            }
        }

        // --- HOLES DEAD CENTER ON X = 0 ---
        // Top Apex Hole (15cm level): exactly at [0, 0]
        circle(d = hole_dia);

        // Lower Perch Hole (5cm level): exactly at [0, -dist_apex_to_lower]
        // Dead center in the 16mm shaft!
        translate([0, -dist_apex_to_lower])
        circle(d = hole_dia);
    }
}

// ================= ROOSTING BAR COMPONENTS =================

// 2D cross section of roosting bar (flat bottom for zero-support printing & anti-spin chick grip)
module bar_cross_section() {
    r = bar_diameter / 2;
    difference() {
        circle(r = r, $fn = 40);
        translate([-r - 1, -r])
        square([2 * r + 2, flat_cut_bar]);
    }
}

// Roosting bar (runs along Y axis)
module roosting_bar() {
    color(bar_color)
    union() {
        // Main roosting bar body
        rotate([-90, 0, 0])
        linear_extrude(height = bar_length, center = true, convexity = 4)
        bar_cross_section();

        // End Tenon +Y (with dual locking wedge pin slots)
        translate([0, bar_length / 2, 0])
        rotate([-90, 0, 0])
        precision_tenon(len = tenon_length);

        // End Tenon -Y
        translate([0, -bar_length / 2, 0])
        rotate([90, 0, 0])
        precision_tenon(len = tenon_length);
    }
}

// Precision tenon engineered with vertical locking pin slots and crush ribs
module precision_tenon(len = 18) {
    r = tenon_dia / 2;
    chamfer_len = 2.0;
    body_len = len - chamfer_len;

    difference() {
        union() {
            // Main tenon cylinder with anti-overhang print flat
            linear_extrude(height = body_len, convexity = 2)
            difference() {
                circle(r = r, $fn = 36);
                translate([-r - 1, -r]) square([2 * r + 2, flat_cut_bar * 0.7]);
            }

            // 4 Longitudinal micro-crush ribs (0.15mm) for zero wobble
            for (a = [45, 135, 225, 315]) {
                rotate([0, 0, a])
                translate([r - 0.1, -0.4, 0])
                cube([0.22, 0.8, body_len]);
            }

            // Generous lead-in taper for effortless insertion
            translate([0, 0, body_len])
            hull() {
                linear_extrude(height = 0.1)
                difference() {
                    circle(r = r, $fn = 36);
                    translate([-r - 1, -r]) square([2 * r + 2, flat_cut_bar * 0.7]);
                }

                translate([0, 0, chamfer_len])
                linear_extrude(height = 0.1)
                difference() {
                    circle(r = r * 0.82, $fn = 36);
                    translate([-r - 1, -r]) square([2 * r + 2, flat_cut_bar * 0.7]);
                }
            }
        }

        // --- Vertical Pin Slots for Tapered Wedges ---
        // Slot 1 (at 1 * leg_thickness + 1.2 = 7.2mm): for single-leg joints (lower bars)
        translate([0, 0, leg_thickness + 1.2])
        cube([2.6, hole_dia + 4, 5.0], center = true);

        // Slot 2 (at 2 * leg_thickness + 1.2 = 13.2mm): for double-leg apex joint
        translate([0, 0, 2 * leg_thickness + 1.2])
        cube([2.6, hole_dia + 4, 5.0], center = true);
    }
}
