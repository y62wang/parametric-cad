/*
  Tesla Model Y (2025+ "Juniper") trunk grocery hook

  Reverse-engineered from the Arcoche B0FN7JHT19 listing, installation video,
  product weight, and the visible weatherstrip interface. The local trim gap is
  not published by Tesla or the seller, so print the fit coupon first.

  Coordinate system in installed orientation:
    X = along the hatch opening
    Y = downward
    Z = outward into the cargo area
*/

/* [Output] */
output_mode = "hook_print"; // [hook_preview,hook_catalog,hook_print,coupon_preview,coupon_print]

/* [Overall hook] */
panel_width = 132;          // [110:1:155]
panel_height = 60;          // [48:1:75]
structure_thickness = 4.0; // [3.2:0.1:5.5]
inner_bend_radius = 8;      // [5:0.5:12]
end_corner_radius = 4;      // [0:0.5:8]

/* [Weatherstrip flange] */
flange_depth = 30;          // [22:1:38]
flange_tip_thickness = 1.8; // [1.2:0.1:2.6]
rail_slot_length = 43;      // [32:1:50]
rail_slot_width = 5.2;      // [3.8:0.2:7]
rail_slot_z = -18;          // [-25:1:-10]

/* [Bag hooks] */
hook_count = 3;             // [2:1:4]
hook_width = 29;            // [22:1:34]
hook_gap = 7;               // [4:1:12]
hook_opening = 15;          // [11:1:20]
hook_lip_thickness = 4.2;   // [3.2:0.2:5.5]
hook_lip_height = 27;       // [21:1:34]
hook_shelf_thickness = 5.5; // [4:0.5:8]
hook_back_overlap = 3.0;    // [2:0.5:5]
hook_corner_radius = 3.0;   // [1.5:0.5:4.5]

/* [Fit coupon] */
coupon_width = 34;
coupon_height = 34;

/* [Quality] */
$fn = 48;
arc_steps = 18;

eps = 0.05;
hook_outer_z = structure_thickness + hook_opening + hook_lip_thickness;

function arc_points(cx, cy, radius, a0, a1, steps) =
    [for (i = [0:steps])
        [cx + radius * cos(a0 + (a1 - a0) * i / steps),
         cy + radius * sin(a0 + (a1 - a0) * i / steps)]];

function bracket_profile(height, tip_t) =
    let(
        r = inner_bend_radius,
        t = structure_thickness,
        cx = -r,
        cy = r + t
    )
    concat(
        [[-flange_depth, 0]],
        arc_points(cx, cy, r + t, -90, 0, arc_steps),
        [[t, height], [0, height]],
        arc_points(cx, cy, r, 0, -90, arc_steps),
        [[-flange_depth, tip_t]]
    );

module extrude_along_x(length) {
    translate([length, 0, 0])
        rotate([0, -90, 0])
            linear_extrude(height = length, convexity = 12)
                children();
}

module rounded_rect_2d(size = [10, 10], radius = 2) {
    offset(r = radius)
        offset(delta = -radius)
            square(size);
}

module slot_cut(x_center, slot_length, slot_width, z_center, cut_height) {
    translate([x_center - slot_length / 2 + slot_width / 2, -1, z_center])
        hull() {
            for (x = [0, slot_length - slot_width])
                translate([x, 0, 0])
                    rotate([-90, 0, 0])
                        cylinder(h = cut_height + 2, r = slot_width / 2);
        }
}

module bracket_body(width = panel_width,
                    height = panel_height,
                    tip_t = flange_tip_thickness,
                    include_slots = true) {
    difference() {
        extrude_along_x(width)
            polygon(points = bracket_profile(height, tip_t));

        if (include_slots) {
            local_slot_length = min(rail_slot_length, width < 80 ? width - 10 : rail_slot_length);
            local_centers = width < 80
                ? [width / 2]
                : [width * 0.31, width * 0.69];

            for (center = local_centers)
                slot_cut(
                    x_center = center,
                    slot_length = local_slot_length,
                    slot_width = rail_slot_width,
                    z_center = rail_slot_z,
                    cut_height = structure_thickness
                );
        }
    }
}

module hook_profile_2d() {
    outer_depth = hook_back_overlap + hook_opening + hook_lip_thickness;
    inner_radius = max(1.0, hook_corner_radius - 0.8);

    difference() {
        translate([
            structure_thickness - hook_back_overlap,
            panel_height - hook_lip_height
        ])
            rounded_rect_2d(
                [outer_depth, hook_lip_height],
                hook_corner_radius
            );

        // The subtraction extends above the outer body so the bag slot is open.
        translate([
            structure_thickness,
            panel_height - hook_lip_height - 1
        ])
            rounded_rect_2d(
                [hook_opening, hook_lip_height - hook_shelf_thickness + 1],
                inner_radius
            );
    }
}

module bag_hooks() {
    total_width = hook_count * hook_width + (hook_count - 1) * hook_gap;
    start_x = (panel_width - total_width) / 2;

    assert(total_width <= panel_width - 8,
        "Hooks exceed the panel width; reduce hook_width, hook_gap, or hook_count.");

    for (i = [0:hook_count - 1])
        translate([start_x + i * (hook_width + hook_gap), 0, 0])
            extrude_along_x(hook_width)
                hook_profile_2d();
}

module overall_rounding_mask() {
    translate([0, 0, -flange_depth - 1])
        linear_extrude(height = flange_depth + hook_outer_z + 2)
            rounded_rect_2d(
                [panel_width, panel_height],
                end_corner_radius
            );
}

module installed_hook() {
    intersection() {
        union() {
            bracket_body();
            bag_hooks();
        }
        overall_rounding_mask();
    }
}

module fit_coupon(tip_t = flange_tip_thickness) {
    bracket_body(
        width = coupon_width,
        height = coupon_height,
        tip_t = tip_t,
        include_slots = true
    );
}

module hook_print_orientation() {
    // Stand on the narrow end. This keeps the load-bearing Y-Z cross-section
    // within each layer. The three hook starts still require build-plate tree
    // supports; use a wide brim because the part is tall.
    translate([hook_outer_z, 0, 0])
        rotate([0, -90, 0])
            installed_hook();
}

module coupon_print_orientation(tip_t = flange_tip_thickness) {
    translate([structure_thickness, 0, 0])
        rotate([0, -90, 0])
            fit_coupon(tip_t);
}

if (output_mode == "hook_preview") {
    installed_hook();
} else if (output_mode == "hook_catalog") {
    color([0.14, 0.15, 0.17])
        translate([0, 0, panel_height])
            rotate([-90, 0, 0])
                installed_hook();
} else if (output_mode == "hook_print") {
    hook_print_orientation();
} else if (output_mode == "coupon_preview") {
    fit_coupon();
} else if (output_mode == "coupon_print") {
    coupon_print_orientation();
} else {
    assert(false, str("Unknown output_mode: ", output_mode));
}
