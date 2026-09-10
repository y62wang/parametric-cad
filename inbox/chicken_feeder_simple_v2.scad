
// Simple chicken feeder - revised
// Body: 240 x 120 x 200 mm
// Wall thickness: 2 mm
// Bottom thickness: 2 mm
// Two front holes: 80 mm diameter
// Intended with 30 mm attachable legs:
//   hole top ~150 mm above ground
//   hole center on body = 80 mm above feeder bottom
//   ground height = 30 + 80 + 40 = 150 mm
// Separate lid.

part = "body"; // "body" or "lid"

body_w = 240;
body_d = 120;
body_h = 200;

wall = 2;
bottom = 2;

hole_d = 80;
hole_center_z = 80;      // from feeder bottom
hole_spacing = 110;      // center-to-center

lid_clearance = 0.6;
lid_h = 14;
lid_wall = 2;

$fn = 96;

module feeder_body() {
    difference() {
        // Outer body
        cube([body_w, body_d, body_h], center=false);

        // Hollow interior; keep 2 mm walls and 2 mm floor; open top
        translate([wall, wall, bottom])
            cube([
                body_w - 2*wall,
                body_d - 2*wall,
                body_h - bottom + 0.1
            ], center=false);

        // Two front openings, 80 mm diameter
        for (x = [
            body_w/2 - hole_spacing/2,
            body_w/2 + hole_spacing/2
        ]) {
            translate([x, -0.1, hole_center_z])
                rotate([-90, 0, 0])
                    cylinder(h=wall + 0.2, d=hole_d);
        }
    }
}

module feeder_lid() {
    inner_w = body_w + lid_clearance;
    inner_d = body_d + lid_clearance;
    outer_w = inner_w + 2*lid_wall;
    outer_d = inner_d + 2*lid_wall;

    difference() {
        cube([outer_w, outer_d, lid_h], center=false);

        // Hollow underside, leaving 2 mm lid top
        translate([lid_wall, lid_wall, lid_wall])
            cube([inner_w, inner_d, lid_h], center=false);
    }
}

if (part == "body")
    feeder_body();
else if (part == "lid")
    feeder_lid();
