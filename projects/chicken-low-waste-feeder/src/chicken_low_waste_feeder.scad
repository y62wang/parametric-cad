// Chicken low-waste gravity feeder
// Designed for a 256 x 256 mm printer bed (Elegoo Centauri-class)
// Main body and lid each fit without splitting.
// Two large feeding ports sized for chicken heads.
// No external standing tray.
//
// Export examples:
//   openscad -D 'part="body"' -o feeder_body.stl chicken_low_waste_feeder.scad
//   openscad -D 'part="lid"'  -o feeder_lid.stl  chicken_low_waste_feeder.scad
//   openscad -D 'part="port"' -o feeder_port.stl chicken_low_waste_feeder.scad
// Print the port STL twice.

$fn = 96;

part = "assembly";  // "body", "lid", "port", "assembly", "plate_check"

// -------------------- Main dimensions --------------------
body_w = 235;       // X
body_d = 110;       // Y
body_h = 240;       // Z
wall   = 3.0;
bottom = 3.2;

// Two chicken-head openings
port_hole_d = 88;   // body cutout diameter
port_inner_d = 82;  // actual clear opening through removable port
port_center_z = 67;
port_x = [64, 171];

// Internal anti-waste baffle
// Creates a narrow feeding chamber behind the front wall.
baffle_y = 35;      // distance from front outside face
baffle_t = 3.0;
baffle_h = body_h - 22; // tall wall, feed mainly passes through bottom slots
feed_slot_w = 34;
feed_slot_h = 19;

// Lid
lid_clearance = 0.7;   // total XY looseness around body
lid_wall = 3.0;
lid_top = 3.0;
lid_skirt_h = 12;

// Removable port / collar
port_fit_clearance = 0.6; // diametral clearance relative to body hole
port_sleeve_od = port_hole_d - port_fit_clearance;
port_sleeve_len = wall + 13;
port_flange_od = 102;
port_flange_t = 4.0;

// -------------------- Helpers --------------------
module rounded_rect_2d(w, d, r=3) {
    offset(r=r) square([w-2*r, d-2*r], center=true);
}

module body_shell() {
    difference() {
        // outer box
        translate([0,0,body_h/2])
            cube([body_w, body_d, body_h], center=true);

        // open-top inner cavity; leave walls + bottom
        translate([0,0,bottom + (body_h-bottom+1)/2])
            cube([body_w-2*wall, body_d-2*wall, body_h-bottom+1], center=true);

        // front round openings (axis along Y)
        for (x = port_x)
            translate([x-body_w/2, -body_d/2-0.5, port_center_z])
                rotate([-90,0,0])
                    cylinder(d=port_hole_d, h=wall+1.5);
    }
}

module anti_waste_baffle() {
    // Vertical wall supported from the bottom.
    // Bottom slots meter feed into the front feeding chamber.
    difference() {
        translate([0, -body_d/2 + baffle_y, baffle_h/2])
            cube([body_w-2*wall, baffle_t, baffle_h], center=true);

        for (x = port_x)
            translate([x-body_w/2, -body_d/2 + baffle_y - 1, feed_slot_h/2 + bottom])
                cube([feed_slot_w, baffle_t+2, feed_slot_h], center=true);
    }
}

module feeder_body() {
    union() {
        body_shell();
        anti_waste_baffle();
    }
}

module feeder_lid() {
    inner_w = body_w + lid_clearance;
    inner_d = body_d + lid_clearance;
    outer_w = inner_w + 2*lid_wall;
    outer_d = inner_d + 2*lid_wall;

    difference() {
        // closed cap
        translate([0,0,(lid_skirt_h+lid_top)/2])
            cube([outer_w, outer_d, lid_skirt_h+lid_top], center=true);

        // cavity enters from bottom, leaving lid_top thickness
        translate([0,0,lid_skirt_h/2 - 0.01])
            cube([inner_w, inner_d, lid_skirt_h+0.02], center=true);
    }
}

module feeder_port() {
    // Front flange + insertion sleeve. Print flat on the flange.
    difference() {
        union() {
            cylinder(d=port_flange_od, h=port_flange_t);
            translate([0,0,port_flange_t])
                cylinder(d=port_sleeve_od, h=port_sleeve_len);
        }
        translate([0,0,-0.5])
            cylinder(d=port_inner_d, h=port_flange_t+port_sleeve_len+1);
    }
}

module assembly() {
    feeder_body();

    // show lid above body
    translate([0,0,body_h+18]) feeder_lid();

    // show ports installed from the front
    for (x = port_x)
        translate([x-body_w/2, -body_d/2-port_flange_t, port_center_z])
            rotate([-90,0,0]) feeder_port();
}

module plate_check() {
    // 256 x 256 reference plate, body sitting on it.
    color([0.75,0.75,0.75,0.25])
        translate([0,0,-0.5]) cube([256,256,1], center=true);
    feeder_body();
}

if (part == "body") feeder_body();
else if (part == "lid") feeder_lid();
else if (part == "port") feeder_port();
else if (part == "plate_check") plate_check();
else assembly();
