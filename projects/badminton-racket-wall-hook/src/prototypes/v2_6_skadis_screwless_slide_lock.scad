// v2.6 SKADIS-only screwless slide-lock badminton racket rack prototype.
//
// The back uses exactly two printed board hooks and two forward-facing
// dovetail rails. The connected zigzag body slides down over both rails and
// seats against closed top stops. A replaceable underside clip fills the
// service space below the rails and only prevents upward removal.
//
// All dimensions are millimetres.

render_mode = "preview_assembled_front_iso";
selected_render_mode = render_mode;

prototype_version = "2.6";
prototype_release_status =
    "skadis_screwless_slide_lock_prototype_not_released";
skadis_only = true;
other_board_mode_count = 0;
threaded_fastener_hole_count = 0;
thermal_insert_pocket_count = 0;
metal_fastener_count = 0;
counterbored_hole_count = 0;
legacy_interface_feature_count = 0;
visible_front_fastening_opening_count = 0;
visible_rear_fastening_opening_count = 0;
one_piece_body_export_supported = true;
ten_racket_load_verified = false;
load_rating_status = "physical_validation_required";
print_bed_xy = [256, 256];

/* [SKADIS back] */
back_w = 72;
back_h = 72;
back_t = 10;
back_corner_r = 4;

skadis_board_t = 3;
skadis_board_clearance = 0.4;
skadis_standoff = 0.8;
skadis_hook_x = [-20, 20];
skadis_hook_z = 58;
skadis_board_connector_positions = [
    for (x = skadis_hook_x)
        [x, skadis_hook_z]
];
skadis_board_connector_count =
    len(skadis_board_connector_positions);
skadis_hook_w = 4.2;
skadis_hook_depth = 2.8;
skadis_hook_tongue_h = 12;
skadis_hook_neck_h = 4;
skadis_tongue_chamfer = 0.6;
skadis_tongue_neck_overlap = 0.2;
skadis_upper_pad_x = [-20, 20];
skadis_upper_pad_w = 12;
skadis_upper_pad_h = 14;
skadis_lower_pad_x = [-20, 20];
skadis_lower_pad_z = 11;
skadis_lower_pad_positions = [
    for (x = skadis_lower_pad_x)
        [x, skadis_lower_pad_z]
];
skadis_lower_pad_w = 18;
skadis_lower_pad_h = 14;
skadis_lower_pad_is_connector = false;
skadis_lower_bearing_pad_count =
    len(skadis_lower_pad_positions);

/* [Twin downward dovetails] */
rail_centres_x = [-20, 20];
rail_z0 = 18;
rail_z1 = 54;
rail_engagement = rail_z1 - rail_z0;
male_rail_projection = 6.0;
male_rail_neck_w = 8.0;
male_rail_crown_w = 12.0;
rail_back_overlap = 0.25;
rail_root_fillet_r = 2.0;
rail_lead_in = 1.5;
rail_lead_in_lower_slice_z =
    rail_z1 - rail_lead_in - 0.02;
rail_lead_in_upper_slice_z = rail_z1 - 0.02;
rail_lead_in_upper_end_z = rail_z1 + 0.02;
lead_in_containment_sample_z = [
    52.48,
    53.0,
    53.5,
    53.98,
    54.02
];

rail_side_clearance = 0.30;
rail_depth_clearance = 0.40;
nominal_female_mouth_w =
    male_rail_neck_w + 2 * rail_side_clearance;
nominal_female_crown_w =
    male_rail_crown_w + 2 * rail_side_clearance;
nominal_female_depth =
    male_rail_projection + rail_depth_clearance;

assembly_direction = "downward";
gravity_seats_interface = true;
female_channels_open_bottom = true;
female_channels_closed_top = true;
interface_structural_path =
    "twin_dovetail_rails_and_closed_top_stops";

/* [Connected body] */
heel_w = 72;
heel_t = 14;
heel_z0 = 10;
heel_top_z = 58;
heel_h = heel_top_z - heel_z0;
heel_corner_r = 4;
heel_front_wall = heel_t - nominal_female_depth;
closed_top_stop_t = heel_top_z - rail_z1;

root_start_y = heel_t - 1;
root_flare_w = 52;
root_transition_end_y = 20;
arm_start_y = root_transition_end_y - 1;
arm_w = 28;
arm_h = 36;
arm_z0 = heel_top_z - arm_h;
arm_centre_x = 0;
arm_corner_r = 2;
full_projection = 221;

heel_root_overlap = heel_t - root_start_y;
root_arm_overlap = root_transition_end_y - arm_start_y;
body_component_count = 1;
loose_body_section_count = 0;
collar_part_count = 0;
cradle_part_count = 0;

/* [Racket fit and alternating zigzag] */
num_racket_positions = 10;
racket_first_y = 23;
racket_pitch = 21;
nominal_shaft_d = 7.2;
pocket_d = 8.8;
entry_gap = 6.6;
racket_centres = [
    for (i = [0 : num_racket_positions - 1])
        racket_first_y + i * racket_pitch
];
racket_axes_x = [
    for (i = [0 : num_racket_positions - 1])
        arm_centre_x
];
opening_count_per_pocket = [
    for (i = [0 : num_racket_positions - 1])
        1
];
slot_cut_crosses_full_arm = false;

/* [Replaceable underside anti-lift clip] */
anti_lift_part_count = 1;
anti_lift_is_separate = true;
anti_lift_positive_retention = true;
anti_lift_role = "upward_retention_only";
anti_lift_carries_cantilever_load = false;
anti_lift_release_direction = "below";
anti_lift_visible_from_front = false;
anti_lift_visible_from_rear = false;
anti_lift_service_gap = rail_z0 - heel_z0;
anti_lift_clip_height = anti_lift_service_gap;
anti_lift_bridge_t = 1.8;
anti_lift_bridge_overlap = 0.20;
anti_lift_bridge_z0 = heel_z0 - anti_lift_bridge_t;
anti_lift_clip_side_clearance = 0.20;
anti_lift_clip_depth_clearance = 0.20;
anti_lift_clip_neck_w =
    nominal_female_mouth_w -
    2 * anti_lift_clip_side_clearance;
anti_lift_clip_crown_w =
    nominal_female_crown_w -
    2 * anti_lift_clip_side_clearance;
anti_lift_clip_depth =
    nominal_female_depth -
    anti_lift_clip_depth_clearance;
anti_lift_prong_split = 1.0;
anti_lift_detent_y = 3.0;
anti_lift_detent_z = heel_z0 + anti_lift_service_gap * 0.58;
anti_lift_detent_r = 0.55;
anti_lift_recess_r = 0.75;
anti_lift_detent_interference = 0.25;

/* [Coupons] */
fit_coupon_t = 3;
tolerance_coupon_side_clearances = [0.20, 0.30, 0.40];
tolerance_coupon_base_w = 96;
tolerance_coupon_base_d = 28;
tolerance_coupon_base_t = 3;
tolerance_coupon_rail_centres_x = [-32, 0, 32];
tolerance_coupon_rail_y = 7;
tolerance_coupon_rail_h = 20;
tolerance_coupon_slider_y = 40;
tolerance_coupon_slider_w = 18;
tolerance_coupon_slider_d = 14;
tolerance_coupon_slider_h = 24;
tolerance_coupon_slider_stop_t = 4;

/* [Rendering] */
round_fn = 48;
preview_body_colour = [0.92, 0.45, 0.10];
preview_back_colour = [0.34, 0.35, 0.37];
preview_clip_colour = [0.20, 0.22, 0.24];
preview_shaft_colour = [0.12, 0.13, 0.14];
preview_arrow_colour = [0.15, 0.45, 0.85];

/* [Derived evidence] */
pocket_r = pocket_d / 2;
last_racket_centre =
    racket_centres[len(racket_centres) - 1];
tip_margin =
    full_projection - last_racket_centre - pocket_r;
opposite_side_ligament =
    arm_w / 2 - pocket_r;
adjacent_pocket_web =
    racket_pitch - pocket_d;
body_print_bounds = [heel_w, full_projection];
rail_outer_edge_margin =
    back_w / 2 -
    (abs(rail_centres_x[1]) +
     male_rail_crown_w / 2);
channel_outer_edge_margin =
    heel_w / 2 -
    (abs(rail_centres_x[1]) +
     nominal_female_crown_w / 2);
rail_vertical_margin =
    min(rail_z0, back_h - rail_z1);
rail_surround_min =
    min(
        rail_outer_edge_margin,
        channel_outer_edge_margin,
        rail_vertical_margin,
        heel_front_wall,
        closed_top_stop_t
    );

function opening_side_for(index, reverse = false) =
    (index + (reverse ? 1 : 0)) % 2 == 0
        ? "left"
        : "right";

function opening_sides_for(reverse = false) = [
    for (i = [0 : num_racket_positions - 1])
        opening_side_for(i, reverse)
];

function opening_records_for(reverse = false) = [
    for (i = [0 : num_racket_positions - 1])
        [
            arm_centre_x,
            racket_centres[i],
            opening_side_for(i, reverse)
        ]
];

function printable_modes() = [
    "body_start_left",
    "body_start_right",
    "screwless_skadis_back",
    "anti_lift_clip",
    "skadis_fit_coupon",
    "dovetail_tolerance_coupon"
];

function preview_modes() = [
    "preview_assembled_front_iso",
    "preview_rear_two_hooks",
    "preview_exploded_slide",
    "preview_dovetail_closeup",
    "preview_connected_zigzag",
    "preview_print_orientations"
];

function mode_is_printable(mode) =
    len([
        for (candidate = printable_modes())
            if (candidate == mode) candidate
    ]) == 1;

function mode_is_preview(mode) =
    len([
        for (candidate = preview_modes())
            if (candidate == mode) candidate
    ]) == 1;

function mode_is_supported(mode) =
    mode == "none" ||
    mode_is_printable(mode) ||
    mode_is_preview(mode);

function expected_component_count(mode) =
    mode == "dovetail_tolerance_coupon"
        ? 4
        : (mode_is_printable(mode) ? 1 : 0);

function profile_half_width_at_y(
    neck_w,
    crown_w,
    depth,
    y
) =
    neck_w / 2 +
    (crown_w - neck_w) / 2 *
    min(1, max(0, y / depth));

nominal_cavity_half_at_detent =
    profile_half_width_at_y(
        nominal_female_mouth_w,
        nominal_female_crown_w,
        nominal_female_depth,
        anti_lift_detent_y
    );
clip_half_at_detent =
    profile_half_width_at_y(
        anti_lift_clip_neck_w,
        anti_lift_clip_crown_w,
        anti_lift_clip_depth,
        anti_lift_detent_y
    );
anti_lift_bump_centre_x =
    nominal_cavity_half_at_detent +
    anti_lift_detent_interference -
    anti_lift_detent_r;
anti_lift_recess_centre_x =
    nominal_cavity_half_at_detent + 0.30;

assert(
    skadis_only &&
    other_board_mode_count == 0 &&
    threaded_fastener_hole_count == 0 &&
    thermal_insert_pocket_count == 0 &&
    metal_fastener_count == 0,
    "v2.6 must remain SKADIS-only, screwless and all-printed"
);
assert(
    skadis_board_connector_count == 2 &&
    !skadis_lower_pad_is_connector,
    "Exactly two rear hooks are allowed; lower pads are supports"
);
assert(
    rail_centres_x == [-20, 20] &&
    rail_engagement >= 36 &&
    male_rail_projection == 6 &&
    nominal_female_depth == 6.4,
    "The reviewed twin-rail interface dimensions changed"
);
assert(
    heel_front_wall >= 7.6 &&
    rail_surround_min >= 3 &&
    rail_root_fillet_r >= 2,
    "The slide-lock needs the reviewed wall and rail material"
);
assert(
    female_channels_open_bottom &&
    female_channels_closed_top &&
    assembly_direction == "downward" &&
    gravity_seats_interface,
    "The female channels must slide down onto rigid top stops"
);
assert(
    anti_lift_service_gap == anti_lift_clip_height &&
    anti_lift_positive_retention &&
    !anti_lift_carries_cantilever_load,
    "The underside clip must only retain against upward removal"
);
assert(
    num_racket_positions == 10 &&
    opening_sides_for(false) == [
        "left", "right", "left", "right", "left",
        "right", "left", "right", "left", "right"
    ] &&
    opening_sides_for(true) == [
        "right", "left", "right", "left", "right",
        "left", "right", "left", "right", "left"
    ],
    "The two bodies need ten exact alternating positions"
);
assert(
    opposite_side_ligament == 9.6 &&
    adjacent_pocket_web == 12.2 &&
    root_flare_w == 52,
    "The connected zigzag structural dimensions changed"
);
assert(
    heel_root_overlap >= 1 &&
    root_arm_overlap >= 1 &&
    tip_margin >= 4,
    "Heel, root, arm and tip need positive material"
);
assert(
    body_print_bounds[0] <= print_bed_xy[0] &&
    body_print_bounds[1] <= print_bed_xy[1],
    "The connected body must fit the declared print bed"
);
assert(
    mode_is_supported(selected_render_mode),
    str("Unknown v2.6 render mode: ", selected_render_mode)
);

echo(str(
    "V2_6_MODE: ", selected_render_mode,
    "; status: ", prototype_release_status
));
echo("SKADIS_HOOK_POSITIONS_X_Z",
    skadis_board_connector_positions);
echo("DOVETAIL_RAIL_CENTRES_X", rail_centres_x);
echo("RACKET_CENTRES_Y", racket_centres);
echo("START_LEFT_OPENINGS", opening_sides_for(false));
echo("START_RIGHT_OPENINGS", opening_sides_for(true));
echo(
    "SLIDE_LOCK_DIMENSIONS_MM",
    [
        ["rail_engagement", rail_engagement],
        ["side_clearance", rail_side_clearance],
        ["depth_clearance", rail_depth_clearance],
        ["front_wall", heel_front_wall],
        ["top_stop", closed_top_stop_t],
        ["service_gap", anti_lift_service_gap],
        ["material_min", rail_surround_min]
    ]
);
echo(
    "LOAD_RATING_STATUS",
    [
        ["ten_racket_load_verified",
            ten_racket_load_verified],
        ["status", load_rating_status]
    ]
);

// Rounded rectangle in X/Z, extruded along positive Y.
module rounded_prism_y(
    width,
    depth,
    height,
    radius,
    y0 = 0,
    z0 = 0
) {
    safe_r = min(radius, min(width, height) / 2);
    hull() {
        for (x = [-width / 2 + safe_r,
                  width / 2 - safe_r])
            for (z = [z0 + safe_r,
                      z0 + height - safe_r])
                translate([x, y0, z])
                    rotate([-90, 0, 0])
                        cylinder(
                            r = safe_r,
                            h = depth,
                            $fn = round_fn
                        );
    }
}

module right_root_fillet_2d(radius = rail_root_fillet_r) {
    difference() {
        translate([male_rail_neck_w / 2, 0])
            square([radius, radius]);
        translate([
            male_rail_neck_w / 2 + radius,
            radius
        ])
            circle(r = radius, $fn = round_fn);
    }
}

module rail_root_fillets_2d(
    radius = rail_root_fillet_r
) {
    right_root_fillet_2d(radius);
    mirror([1, 0, 0])
        right_root_fillet_2d(radius);
}

module male_dovetail_profile_2d(
    include_root_fillets = true
) {
    union() {
        polygon([
            [-male_rail_neck_w / 2, 0],
            [ male_rail_neck_w / 2, 0],
            [ male_rail_crown_w / 2,
                male_rail_projection],
            [-male_rail_crown_w / 2,
                male_rail_projection]
        ]);

        // This overlap makes the rail and back one volumetric component.
        translate([
            -male_rail_neck_w / 2,
            -rail_back_overlap
        ])
            square([
                male_rail_neck_w,
                rail_back_overlap + 0.05
            ]);

        if (include_root_fillets)
            rail_root_fillets_2d();
    }
}

module female_dovetail_profile_2d(
    side_clearance = rail_side_clearance,
    depth_clearance = rail_depth_clearance,
    lead_extra = 0
) {
    mouth_w =
        male_rail_neck_w +
        2 * (side_clearance + lead_extra);
    crown_w =
        male_rail_crown_w +
        2 * (side_clearance + lead_extra);
    depth =
        male_rail_projection +
        depth_clearance +
        lead_extra;

    union() {
        polygon([
            [-mouth_w / 2, -0.35],
            [ mouth_w / 2, -0.35],
            [ crown_w / 2, depth],
            [-crown_w / 2, depth]
        ]);

        // Reliefs clear the R2 rail roots while retaining the nominal throat.
        offset(delta = side_clearance + lead_extra)
            rail_root_fillets_2d();
    }
}

module male_dovetail_rail(
    x,
    z0 = rail_z0,
    height = rail_engagement
) {
    straight_h = height - rail_lead_in;

    translate([x, 0, z0])
        linear_extrude(height = straight_h + 0.02)
            male_dovetail_profile_2d();

    hull() {
        translate([x, 0, z0 + straight_h - 0.02])
            linear_extrude(height = 0.04)
                male_dovetail_profile_2d(false);
        translate([x, 0, z0 + height - 0.02])
            linear_extrude(height = 0.04)
                scale([0.84, 0.84])
                    male_dovetail_profile_2d(false);
    }
}

module anti_lift_detent_recesses(x) {
    for (side = [-1, 1])
        translate([
            x +
                side * anti_lift_recess_centre_x,
            anti_lift_detent_y,
            anti_lift_detent_z
        ])
            sphere(
                r = anti_lift_recess_r,
                $fn = round_fn
            );
}

module female_dovetail_channel_void(
    x,
    side_clearance = rail_side_clearance,
    depth_clearance = rail_depth_clearance,
    include_clip_detents = true,
    local_bottom = heel_z0,
    local_top = rail_z1
) {
    lead_top = local_bottom + rail_lead_in;

    translate([x, 0, lead_top - 0.01])
        linear_extrude(
            height = local_top - lead_top + 0.03
        )
            female_dovetail_profile_2d(
                side_clearance,
                depth_clearance
            );

    hull() {
        translate([x, 0, local_bottom - 0.02])
            linear_extrude(height = 0.04)
                female_dovetail_profile_2d(
                    side_clearance,
                    depth_clearance,
                    0.55
                );
        translate([x, 0, lead_top - 0.02])
            linear_extrude(height = 0.04)
                female_dovetail_profile_2d(
                    side_clearance,
                    depth_clearance
                );
    }

    if (include_clip_detents)
        anti_lift_detent_recesses(x);
}

module back_plate() {
    rounded_prism_y(
        back_w,
        back_t,
        back_h,
        back_corner_r,
        -back_t,
        0
    );
}

module twin_dovetail_rails() {
    for (x = rail_centres_x)
        male_dovetail_rail(x);
}

module skadis_contact_pad(
    x,
    z,
    width,
    height,
    plate_t
) {
    translate([x, 0, 0])
        rounded_prism_y(
            width,
            skadis_standoff + 0.2,
            height,
            min(2.5, height / 3),
            -plate_t - skadis_standoff,
            z - height / 2
        );
}

module skadis_chamfered_tongue(
    x,
    tongue_y0,
    tongue_front_y,
    tongue_z0
) {
    lead_depth = 0.2;
    chamfer = skadis_tongue_chamfer;

    hull() {
        translate([
            x - skadis_hook_w / 2 + chamfer,
            tongue_y0,
            tongue_z0 + chamfer
        ])
            cube([
                skadis_hook_w - 2 * chamfer,
                lead_depth,
                skadis_hook_tongue_h - 2 * chamfer
            ]);
        translate([
            x - skadis_hook_w / 2,
            tongue_y0 + chamfer,
            tongue_z0
        ])
            cube([
                skadis_hook_w,
                tongue_front_y -
                    tongue_y0 -
                    chamfer +
                    skadis_tongue_neck_overlap,
                skadis_hook_tongue_h
            ]);
    }
}

module skadis_load_hook(x, z, plate_t) {
    board_front_y = -plate_t - skadis_standoff;
    board_rear_y = board_front_y - skadis_board_t;
    tongue_front_y =
        board_rear_y - skadis_board_clearance;
    tongue_y0 = tongue_front_y - skadis_hook_depth;
    tongue_z0 = z - skadis_hook_tongue_h / 2;
    neck_z0 =
        tongue_z0 +
        skadis_hook_tongue_h -
        skadis_hook_neck_h;
    neck_depth = -plate_t + 0.2 - tongue_front_y;

    skadis_contact_pad(
        x,
        z,
        skadis_upper_pad_w,
        skadis_upper_pad_h,
        plate_t
    );

    translate([
        x - skadis_hook_w / 2,
        tongue_front_y,
        neck_z0
    ])
        cube([
            skadis_hook_w,
            neck_depth,
            skadis_hook_neck_h
        ]);

    skadis_chamfered_tongue(
        x,
        tongue_y0,
        tongue_front_y,
        tongue_z0
    );
}

module skadis_lower_bearing_pad(x, z, plate_t) {
    skadis_contact_pad(
        x,
        z,
        skadis_lower_pad_w,
        skadis_lower_pad_h,
        plate_t
    );
}

module skadis_connector_set(plate_t) {
    for (x = skadis_hook_x)
        skadis_load_hook(x, skadis_hook_z, plate_t);

    for (x = skadis_lower_pad_x)
        skadis_lower_bearing_pad(
            x,
            skadis_lower_pad_z,
            plate_t
        );
}

module screwless_skadis_back_assembled() {
    union() {
        back_plate();
        twin_dovetail_rails();
        skadis_connector_set(back_t);
    }
}

function skadis_part_depth(plate_t) =
    plate_t +
    skadis_standoff +
    skadis_board_t +
    skadis_board_clearance +
    skadis_hook_depth;

module screwless_skadis_back_print() {
    translate([
        back_h,
        skadis_part_depth(back_t),
        back_w / 2
    ])
        rotate([0, -90, 0])
            screwless_skadis_back_assembled();
}

module body_heel_blank() {
    rounded_prism_y(
        heel_w,
        heel_t,
        heel_h,
        heel_corner_r,
        0,
        heel_z0
    );
}

module body_heel_with_channels() {
    difference() {
        body_heel_blank();
        for (x = rail_centres_x)
            female_dovetail_channel_void(x);
    }
}

module connected_root_flare() {
    hull() {
        rounded_prism_y(
            root_flare_w,
            1.2,
            arm_h,
            arm_corner_r,
            root_start_y,
            arm_z0
        );
        rounded_prism_y(
            arm_w,
            1.2,
            arm_h,
            arm_corner_r,
            root_transition_end_y - 1.2,
            arm_z0
        );
    }
}

module connected_arm_blank(
    projection = full_projection
) {
    rounded_prism_y(
        arm_w,
        projection - arm_start_y,
        arm_h,
        arm_corner_r,
        arm_start_y,
        arm_z0
    );
}

module racket_slot_void(
    opening_record,
    z0 = arm_z0,
    height = arm_h,
    width = arm_w
) {
    centre_x = opening_record[0];
    centre_y = opening_record[1];
    side = opening_record[2];

    assert(
        side == "left" || side == "right",
        str("Each pocket needs one assigned side; got ", side)
    );

    translate([centre_x, centre_y, z0 - 0.2])
        cylinder(
            d = pocket_d,
            h = height + 0.4,
            $fn = round_fn
        );

    if (side == "right")
        translate([
            centre_x,
            centre_y - entry_gap / 2,
            z0 - 0.2
        ])
            cube([
                width / 2 - centre_x + 0.3,
                entry_gap,
                height + 0.4
            ]);
    else
        translate([
            -width / 2 - 0.3,
            centre_y - entry_gap / 2,
            z0 - 0.2
        ])
            cube([
                centre_x + width / 2 + 0.3,
                entry_gap,
                height + 0.4
            ]);
}

module connected_screwless_body(reverse = false) {
    difference() {
        union() {
            body_heel_with_channels();
            connected_root_flare();
            connected_arm_blank();
        }

        for (opening_record = opening_records_for(reverse))
            racket_slot_void(opening_record);
    }
}

module connected_body_print(reverse = false) {
    // The heel and arm tops are coplanar. Inversion places their broad faces
    // on the bed and leaves both dovetail channels open upwards.
    translate([
        heel_w / 2,
        0,
        heel_top_z
    ])
        rotate([0, 180, 0])
            connected_screwless_body(reverse);
}

module anti_lift_clip_profile_2d() {
    polygon([
        [-anti_lift_clip_neck_w / 2, 0.15],
        [ anti_lift_clip_neck_w / 2, 0.15],
        [ anti_lift_clip_crown_w / 2,
            anti_lift_clip_depth],
        [-anti_lift_clip_crown_w / 2,
            anti_lift_clip_depth]
    ]);
}

module anti_lift_shoe(x) {
    translate([
        x,
        0,
        heel_z0 - anti_lift_bridge_overlap
    ])
        linear_extrude(
            height =
                anti_lift_clip_height +
                anti_lift_bridge_overlap
        )
            anti_lift_clip_profile_2d();

    for (side = [-1, 1])
        translate([
            x + side * anti_lift_bump_centre_x,
            anti_lift_detent_y,
            anti_lift_detent_z
        ])
            sphere(
                r = anti_lift_detent_r,
                $fn = round_fn
            );
}

module anti_lift_bridge() {
    bridge_w =
        2 * abs(rail_centres_x[1]) +
        anti_lift_clip_crown_w;
    translate([
        -bridge_w / 2,
        1.0,
        anti_lift_bridge_z0
    ])
        cube([
            bridge_w,
            anti_lift_clip_depth - 2.0,
            anti_lift_bridge_t
        ]);
}

module anti_lift_clip_assembled() {
    difference() {
        union() {
            anti_lift_bridge();
            for (x = rail_centres_x)
                anti_lift_shoe(x);
        }

        // Each split creates two short flexible prongs for the side detents.
        for (x = rail_centres_x)
            translate([
                x - anti_lift_prong_split / 2,
                -0.2,
                heel_z0
            ])
                cube([
                    anti_lift_prong_split,
                    anti_lift_clip_depth + 0.5,
                    anti_lift_clip_height
                ]);
    }
}

module anti_lift_clip_print() {
    bridge_w =
        2 * abs(rail_centres_x[1]) +
        anti_lift_clip_crown_w;
    translate([
        bridge_w / 2,
        0,
        -anti_lift_bridge_z0
    ])
        anti_lift_clip_assembled();
}

module skadis_fit_coupon_assembled() {
    union() {
        rounded_prism_y(
            back_w,
            fit_coupon_t,
            back_h,
            3,
            -fit_coupon_t,
            0
        );
        skadis_connector_set(fit_coupon_t);
    }
}

module skadis_fit_coupon_print() {
    translate([
        back_h,
        skadis_part_depth(fit_coupon_t),
        back_w / 2
    ])
        rotate([0, -90, 0])
            skadis_fit_coupon_assembled();
}

module tolerance_coupon_fixed_rail(x, marker_count) {
    translate([
        x,
        tolerance_coupon_rail_y,
        tolerance_coupon_base_t - 0.2
    ])
        linear_extrude(
            height = tolerance_coupon_rail_h + 0.2
        )
            male_dovetail_profile_2d();

    for (marker = [0 : marker_count - 1])
        translate([
            x - 3 + marker * 3,
            1.5,
            tolerance_coupon_base_t - 0.1
        ])
            cube([1.5, 4, 1.2]);
}

module tolerance_coupon_slider(
    x,
    side_clearance
) {
    difference() {
        translate([
            x - tolerance_coupon_slider_w / 2,
            tolerance_coupon_slider_y,
            0
        ])
            cube([
                tolerance_coupon_slider_w,
                tolerance_coupon_slider_d,
                tolerance_coupon_slider_h
            ]);

        translate([
            x,
            tolerance_coupon_slider_y,
            -0.2
        ])
            linear_extrude(
                height =
                    tolerance_coupon_slider_h -
                    tolerance_coupon_slider_stop_t +
                    0.2
            )
                female_dovetail_profile_2d(
                    side_clearance,
                    rail_depth_clearance
                );
    }
}

module dovetail_tolerance_coupon_print() {
    union() {
        translate([
            -tolerance_coupon_base_w / 2,
            0,
            0
        ])
            cube([
                tolerance_coupon_base_w,
                tolerance_coupon_base_d,
                tolerance_coupon_base_t
            ]);

        for (index = [
            0 : len(tolerance_coupon_side_clearances) - 1
        ])
            tolerance_coupon_fixed_rail(
                tolerance_coupon_rail_centres_x[index],
                index + 1
            );
    }

    for (index = [
        0 : len(tolerance_coupon_side_clearances) - 1
    ])
        tolerance_coupon_slider(
            tolerance_coupon_rail_centres_x[index],
            tolerance_coupon_side_clearances[index]
        );
}

module preview_racket_shafts() {
    for (centre_y = racket_centres)
        color(preview_shaft_colour)
            translate([
                0,
                centre_y,
                arm_z0 - 8
            ])
                cylinder(
                    d = nominal_shaft_d,
                    h = arm_h + 16,
                    $fn = round_fn
                );
}

module preview_down_arrow(
    x = 0,
    y = 20,
    z_top = 105,
    length = 28
) {
    color(preview_arrow_colour) {
        translate([x, y, z_top - length + 6])
            cylinder(
                d = 2.6,
                h = length - 6,
                $fn = round_fn
            );
        translate([x, y, z_top - length])
            cylinder(
                d1 = 0,
                d2 = 8,
                h = 7,
                $fn = round_fn
            );
    }
}

module preview_assembled_front_iso() {
    // Rotate the explanatory view towards the body side. Rear hooks and pads
    // are hidden by the back in this view and are shown in the dedicated rear
    // preview instead.
    rotate([0, 0, 180]) {
        color(preview_back_colour)
            union() {
                back_plate();
                twin_dovetail_rails();
            }
        color(preview_body_colour)
            connected_screwless_body(false);
        color(preview_clip_colour)
            anti_lift_clip_assembled();
        preview_racket_shafts();
    }
}

module preview_rear_two_hooks() {
    color(preview_back_colour)
        union() {
            back_plate();
            twin_dovetail_rails();
            for (x = skadis_lower_pad_x)
                skadis_lower_bearing_pad(
                    x,
                    skadis_lower_pad_z,
                    back_t
                );
        }

    color(preview_body_colour)
        for (x = skadis_hook_x)
            skadis_load_hook(
                x,
                skadis_hook_z,
                back_t
            );
}

module preview_exploded_slide() {
    color(preview_back_colour)
        screwless_skadis_back_assembled();
    color(preview_body_colour)
        translate([0, 0, 55])
            connected_screwless_body(false);
    color(preview_clip_colour)
        translate([0, 0, -11])
            anti_lift_clip_assembled();

    preview_down_arrow(-44, 18, 90, 34);
    preview_down_arrow(44, 18, 90, 34);
}

module preview_male_dovetail_section() {
    rotate([90, 0, 0])
        linear_extrude(height = 8)
            union() {
                translate([-12, -back_t])
                    square([24, back_t]);
                male_dovetail_profile_2d();
            }
}

module preview_female_dovetail_section() {
    rotate([90, 0, 0])
        linear_extrude(height = 8)
            difference() {
                translate([-12, -0.5])
                    square([24, heel_t + 0.5]);
                female_dovetail_profile_2d();
            }
}

module preview_dovetail_closeup() {
    // Exact cross-sections of the production male and female profiles avoid
    // perspective hiding the root reliefs and nominal clearances.
    color(preview_back_colour)
        translate([-30, 0, 24])
            preview_male_dovetail_section();

    color(preview_body_colour)
        translate([30, 0, 24])
            preview_female_dovetail_section();

    color(preview_clip_colour)
        translate([30, 0, 8])
            rotate([90, 0, 0])
                linear_extrude(height = 8)
                    anti_lift_clip_profile_2d();

    preview_down_arrow(
        x = 30,
        y = 5,
        z_top = 57,
        length = 14
    );
}

module preview_connected_zigzag() {
    color(preview_body_colour)
        connected_screwless_body(false);
}

module preview_print_orientations() {
    color(preview_body_colour)
        connected_body_print(false);

    color(preview_back_colour)
        translate([92, 0, 0])
            screwless_skadis_back_print();

    color(preview_clip_colour)
        translate([174, 4, 0])
            anti_lift_clip_print();

    color(preview_back_colour)
        translate([92, 42, 0])
            skadis_fit_coupon_print();

    color([0.52, 0.54, 0.57])
        translate([142, 150, 0])
            dovetail_tolerance_coupon_print();
}

if (selected_render_mode == "body_start_left")
    connected_body_print(false);
else if (selected_render_mode == "body_start_right")
    connected_body_print(true);
else if (selected_render_mode == "screwless_skadis_back")
    screwless_skadis_back_print();
else if (selected_render_mode == "anti_lift_clip")
    anti_lift_clip_print();
else if (selected_render_mode == "skadis_fit_coupon")
    skadis_fit_coupon_print();
else if (selected_render_mode == "dovetail_tolerance_coupon")
    dovetail_tolerance_coupon_print();
else if (selected_render_mode == "preview_assembled_front_iso")
    preview_assembled_front_iso();
else if (selected_render_mode == "preview_rear_two_hooks")
    preview_rear_two_hooks();
else if (selected_render_mode == "preview_exploded_slide")
    preview_exploded_slide();
else if (selected_render_mode == "preview_dovetail_closeup")
    preview_dovetail_closeup();
else if (selected_render_mode == "preview_connected_zigzag")
    preview_connected_zigzag();
else if (selected_render_mode == "preview_print_orientations")
    preview_print_orientations();
else if (selected_render_mode == "none") {
    // Test mode deliberately emits no source geometry.
}
