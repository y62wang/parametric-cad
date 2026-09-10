/*
  Chick Roost A-Frame Side Connector — retrofit part only

  Designed specifically for the geometry in:
    roosting_bar_fixed(1).scad

  PURPOSE
  -------
  Print TWO identical connectors. One slides onto the two exposed LOWER
  roost-bar tenons on the left side of the stand; the other slides onto the
  corresponding two tenons on the right side. This ties the two legs on each
  A-frame side together and greatly reduces leg splay/wobble without using
  the original wedge pins.

  IMPORTANT
  ---------
  The round holes do NOT go around the rectangular legs. They fit over the
  two 10 mm round lower-bar tenons already present in your printed model.

  Default export lays out TWO connectors flat on the print bed.
*/

/* [Export] */
part_to_export = "pair"; // [pair:Print two connectors, single:Print one connector]

/* [Copied exactly from your existing roost model] */
top_bar_height   = 150;
lower_bar_height = 50;
leg_angle         = 24;
tenon_dia          = 10.0;
fit_tolerance      = 0.25;

/* [Connector] */
connector_thickness = 6.0;   // Y thickness when installed; Z thickness when printed
connector_end_dia   = 24.0;  // material around each hole
connector_bridge_h  = 16.0;  // narrow center bridge height

// Same nominal hole fit as the existing legs.
connector_hole_dia = 10.40; // validated clearance over 10 mm tenon + crush ribs

// Exact lower-roost geometry from the source model.
dist_apex_to_lower = (top_bar_height - lower_bar_height) / cos(leg_angle);
lower_x = dist_apex_to_lower * sin(leg_angle);
connector_hole_spacing = 2 * lower_x;  // 89.045737... mm center-to-center

$fn = 64;

if (part_to_export == "pair") {
    // Two identical braces, flat and separated for easy slicing.
    translate([0, -16, 0]) side_connector();
    translate([0,  16, 0]) side_connector();
} else {
    side_connector();
}

// ============================================================
// SIDE CONNECTOR
// Printed flat in XY, thickness along +Z.
// Installed vertically at each outer side of the A-frame.
// ============================================================
module side_connector() {
    linear_extrude(height = connector_thickness, convexity = 4)
    difference() {
        connector_outline_2d();

        // Exact centers of the two lower-roost tenons.
        translate([-connector_hole_spacing / 2, 0])
            circle(d = connector_hole_dia);
        translate([ connector_hole_spacing / 2, 0])
            circle(d = connector_hole_dia);
    }
}

module connector_outline_2d() {
    end_r = connector_end_dia / 2;
    bridge_r = connector_bridge_h / 2;

    union() {
        // Smooth narrow bridge between the two ends.
        hull() {
            translate([-connector_hole_spacing / 2, 0]) circle(r = bridge_r);
            translate([ connector_hole_spacing / 2, 0]) circle(r = bridge_r);
        }

        // Reinforced round ends around each tenon hole.
        translate([-connector_hole_spacing / 2, 0]) circle(r = end_r);
        translate([ connector_hole_spacing / 2, 0]) circle(r = end_r);
    }
}
