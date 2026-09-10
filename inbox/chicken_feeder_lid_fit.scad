
// Slip-on lid for chicken feeder
// Fits feeder body: 240 x 120 mm outer size
// Designed for 2 mm body walls
// Clearance: 0.6 mm total around body
// Lid wall/top thickness: 2 mm
// Lid skirt depth: 14 mm

body_w = 240;
body_d = 120;

clearance = 0.6;   // total clearance added to body dimensions
lid_wall = 2;
lid_top = 2;
skirt_depth = 14;

$fn = 64;

inner_w = body_w + clearance;
inner_d = body_d + clearance;

outer_w = inner_w + 2 * lid_wall;
outer_d = inner_d + 2 * lid_wall;
lid_h = lid_top + skirt_depth;

difference() {
    // Outer lid
    cube([outer_w, outer_d, lid_h], center=false);

    // Hollow underside
    translate([lid_wall, lid_wall, lid_top])
        cube([inner_w, inner_d, skirt_depth + 0.1], center=false);
}
