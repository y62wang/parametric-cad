// v2.5 connected alternating-sawtooth badminton racket rack prototype.
//
// This isolated prototype replaces the segmented v2.4 collar chain with one
// continuous heel, root flare and arm. Ten centred pockets use one-sided cuts
// that alternate left/right, so the opposite side remains an uninterrupted
// load path. Mounting backs retain the compact v2.4 interface. All dimensions
// are millimetres.

render_mode = "preview_zigzag_spine";
selected_render_mode = render_mode;

prototype_version = "2.5";
prototype_release_status =
    "connected_zigzag_prototype_not_released";
one_piece_body_export_supported = true;
ten_racket_load_verified = false;
load_rating_status = "physical_validation_required";
print_bed_xy = [256, 256];

/* [Mounting backs] */
back_w = 72;
back_h = 72;
back_t = 8;
back_corner_r = 4;

/* [Centred body and interface] */
heel_w = 72;
heel_h = 36;
heel_t = 8;
heel_z0 = 18;
heel_corner_r = 4;
arm_w = 28;
arm_h = 36;
arm_z0 = 18;
arm_centre_x = 0;
arm_corner_r = 2;
key_w = 40;
key_h = 20;
key_depth = 3;
key_z0 = 26;
key_corner_r = 3;
key_clearance_per_side = 0.25;
key_depth_clearance = 0.35;
key_recess_depth = key_depth + key_depth_clearance;
body_bolt_x = [-27, 27];
body_bolt_z = [26, 46];
m4_clearance_d = 4.5;
body_counterbore_d = 8.2;
body_counterbore_depth = 4.2;
insert_entry_d = 5.9;
insert_tip_d = 5.4;
insert_depth = 6.2;
interface_fastener_count = len(body_bolt_x) * len(body_bolt_z);

/* [Continuous root and arm] */
root_start_y = 7;
root_flare_w = 40;
root_transition_end_y = 13;
arm_start_y = 12;
full_projection = 221;
body_component_count = 1;
collar_part_count = 0;
cradle_part_count = 0;
loose_body_section_count = 0;
assembly_joint_count = 0;
has_collar_modes = false;
has_cradle_modes = false;

/* [Racket fit and alternating sawtooth] */
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

/* [SKÅDIS: exactly two printed hooks] */
skadis_slot_w = 5;
skadis_slot_h = 15;
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
skadis_lower_pad_w = 18;
skadis_lower_pad_h = 14;
skadis_lower_pad_is_connector = false;
skadis_lower_bearing_pad_count = len(skadis_lower_pad_x);

/* [Multiboard: two centred external-hardware points] */
multiboard_mount_x = [0];
multiboard_mount_z = [11, 61];
multiboard_attachment_points = [
    for (z = multiboard_mount_z)
        [0, z]
];
multiboard_attachment_point_count =
    len(multiboard_attachment_points);
multiboard_hardware_included = false;
multiboard_attachment_hardware =
    "external_m4_compatible_multiboard_hardware";
multiboard_counterbore_d = 8.4;
multiboard_counterbore_depth = 4.2;

/* [Fit and spacing coupons] */
fit_coupon_t = 3;
spacing_coupon_num_slots = 3;
spacing_coupon_tip_margin = 4.6;
spacing_coupon_centres = [
    for (i = [0 : spacing_coupon_num_slots - 1])
        pocket_d / 2 +
        spacing_coupon_tip_margin +
        i * racket_pitch
];
spacing_coupon_length =
    spacing_coupon_centres[len(spacing_coupon_centres) - 1] +
    pocket_d / 2 +
    spacing_coupon_tip_margin;
spacing_coupon_opening_sides =
    ["left", "right", "left"];

/* [Rendering quality] */
round_fn = 48;

/* [Derived dimensional evidence] */
pocket_r = pocket_d / 2;
last_racket_centre =
    racket_centres[len(racket_centres) - 1];
tip_margin =
    full_projection - last_racket_centre - pocket_r;
opposite_side_ligament =
    arm_w / 2 - pocket_r;
adjacent_pocket_web =
    racket_pitch - pocket_d;
heel_root_overlap =
    heel_t - root_start_y;
root_arm_overlap =
    root_transition_end_y - arm_start_y;
body_print_bounds = [
    heel_w,
    full_projection + key_depth
];
multiboard_edge_margin =
    min(
        multiboard_mount_z[0] -
            multiboard_counterbore_d / 2,
        back_h -
            multiboard_mount_z[1] -
            multiboard_counterbore_d / 2
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

function spacing_coupon_records() = [
    for (i = [0 : spacing_coupon_num_slots - 1])
        [
            0,
            spacing_coupon_centres[i],
            spacing_coupon_opening_sides[i]
        ]
];

function printable_modes() = [
    "body_start_left",
    "body_start_right",
    "skadis_back",
    "multiboard_back",
    "skadis_fit_coupon",
    "multiboard_fit_coupon",
    "spacing_coupon"
];

function preview_modes() = [
    "preview_assembled_skadis",
    "preview_assembled_multiboard",
    "preview_zigzag_spine",
    "preview_skadis_rear",
    "preview_multiboard_rear",
    "preview_print_orientation"
];

function mode_is_printable(mode) =
    len([for (candidate = printable_modes())
        if (candidate == mode) candidate]) == 1;

function mode_is_preview(mode) =
    len([for (candidate = preview_modes())
        if (candidate == mode) candidate]) == 1;

function mode_is_supported(mode) =
    mode == "none" ||
    mode_is_printable(mode) ||
    mode_is_preview(mode);

function expected_component_count(mode) =
    mode_is_printable(mode) ? 1 : 0;

assert(
    num_racket_positions == 10 &&
    racket_centres == [
        23, 44, 65, 86, 107,
        128, 149, 170, 191, 212
    ],
    "v2.5 requires ten centred positions at 23 + 21i mm"
);
assert(
    opening_sides_for(false) == [
        "left", "right", "left", "right", "left",
        "right", "left", "right", "left", "right"
    ] &&
    opening_sides_for(true) == [
        "right", "left", "right", "left", "right",
        "left", "right", "left", "right", "left"
    ],
    "The two printable bodies need exact opposite alternating sequences"
);
assert(
    opposite_side_ligament == 9.6 &&
    adjacent_pocket_web == 12.2,
    "The reviewed ligament and adjacent-pocket web changed"
);
assert(
    heel_root_overlap >= 1 &&
    root_arm_overlap >= 1,
    "Heel, root and arm need at least 1 mm positive overlap"
);
assert(
    tip_margin >= 4 &&
    body_print_bounds[0] <= print_bed_xy[0] &&
    body_print_bounds[1] <= print_bed_xy[1],
    "The one-piece body must retain its tip margin and fit the print bed"
);
assert(
    skadis_board_connector_count == 2 &&
    !skadis_lower_pad_is_connector,
    "SKÅDIS needs exactly two printed hooks; lower pads are supports"
);
assert(
    multiboard_attachment_point_count == 2 &&
    !multiboard_hardware_included,
    "Multiboard needs two centred points for external hardware"
);
assert(
    body_component_count == 1 &&
    collar_part_count == 0 &&
    cradle_part_count == 0 &&
    assembly_joint_count == 0,
    "v2.5 must be one connected body with no segmented mechanism"
);
assert(
    !ten_racket_load_verified &&
    load_rating_status == "physical_validation_required",
    "Ten modelled positions must remain physically unverified"
);
assert(
    mode_is_supported(selected_render_mode),
    str("Unknown v2.5 render mode: ", selected_render_mode)
);

echo(str(
    "V2_5_MODE: ", selected_render_mode,
    "; status: ", prototype_release_status
));
echo("RACKET_CENTRES_Y", racket_centres);
echo("START_LEFT_OPENINGS", opening_sides_for(false));
echo("START_RIGHT_OPENINGS", opening_sides_for(true));
echo(
    "CONNECTED_BODY_CLEARANCES_MM",
    [
        ["opposite_side_ligament", opposite_side_ligament],
        ["adjacent_pocket_web", adjacent_pocket_web],
        ["tip_margin", tip_margin],
        ["heel_root_overlap", heel_root_overlap],
        ["root_arm_overlap", root_arm_overlap]
    ]
);
echo(
    "SKADIS_HOOK_POSITIONS_X_Z",
    skadis_board_connector_positions
);
echo(
    "MULTIBOARD_ATTACHMENT_POINTS_X_Z",
    multiboard_attachment_points
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
        for (x = [-width / 2 + safe_r, width / 2 - safe_r])
            for (z = [z0 + safe_r, z0 + height - safe_r])
                translate([x, y0, z])
                    rotate([-90, 0, 0])
                        cylinder(
                            r = safe_r,
                            h = depth,
                            $fn = round_fn
                        );
    }
}

module shear_key() {
    rounded_prism_y(
        key_w,
        key_depth + 0.2,
        key_h,
        key_corner_r,
        -key_depth,
        key_z0
    );
}

module body_fastener_void(x, z) {
    translate([x, -0.2, z])
        rotate([-90, 0, 0])
            cylinder(
                d = m4_clearance_d,
                h = heel_t + 0.4,
                $fn = round_fn
            );

    translate([
        x,
        heel_t - body_counterbore_depth,
        z
    ])
        rotate([-90, 0, 0])
            cylinder(
                d = body_counterbore_d,
                h = body_counterbore_depth + 0.3,
                $fn = round_fn
            );
}

module body_heel_and_interface() {
    difference() {
        union() {
            rounded_prism_y(
                heel_w,
                heel_t,
                heel_h,
                heel_corner_r,
                0,
                heel_z0
            );
            shear_key();
        }

        for (x = body_bolt_x)
            for (z = body_bolt_z)
                body_fastener_void(x, z);
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

module connected_body(reverse = false) {
    difference() {
        union() {
            body_heel_and_interface();
            connected_root_flare();
            connected_arm_blank();
        }

        for (opening_record = opening_records_for(reverse))
            racket_slot_void(opening_record);
    }
}

module connected_body_print(reverse = false) {
    // The mounted heel and arm tops are coplanar at Z=54. Inversion places
    // both broad surfaces at Z=0 and keeps the 224 mm axis on the bed.
    translate([
        heel_w / 2,
        key_depth,
        heel_z0 + heel_h
    ])
        rotate([0, 180, 0])
            connected_body(reverse);
}

module interface_recess_void() {
    rounded_prism_y(
        key_w + 2 * key_clearance_per_side,
        key_recess_depth + 0.2,
        key_h + 2 * key_clearance_per_side,
        key_corner_r + key_clearance_per_side,
        -key_recess_depth,
        key_z0 - key_clearance_per_side
    );
}

module heat_insert_void(x, z) {
    translate([x, 0.2, z])
        rotate([90, 0, 0])
            cylinder(
                d1 = insert_entry_d,
                d2 = insert_tip_d,
                h = insert_depth + 0.2,
                $fn = round_fn
            );
}

module modular_back_core() {
    difference() {
        rounded_prism_y(
            back_w,
            back_t,
            back_h,
            back_corner_r,
            -back_t,
            0
        );
        interface_recess_void();
        for (x = body_bolt_x)
            for (z = body_bolt_z)
                heat_insert_void(x, z);
    }
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

module skadis_back_assembled() {
    union() {
        modular_back_core();
        skadis_connector_set(back_t);
    }
}

function skadis_part_depth(plate_t) =
    plate_t +
    skadis_standoff +
    skadis_board_t +
    skadis_board_clearance +
    skadis_hook_depth;

module skadis_back_print() {
    translate([
        back_h,
        skadis_part_depth(back_t),
        back_w / 2
    ])
        rotate([0, -90, 0])
            skadis_back_assembled();
}

module multiboard_mount_void(
    x,
    z,
    plate_t,
    counterbore = true
) {
    translate([x, 0.2, z])
        rotate([90, 0, 0])
            cylinder(
                d = m4_clearance_d,
                h = plate_t + 0.4,
                $fn = round_fn
            );

    if (counterbore)
        translate([x, 0.2, z])
            rotate([90, 0, 0])
                cylinder(
                    d = multiboard_counterbore_d,
                    h = multiboard_counterbore_depth + 0.2,
                    $fn = round_fn
                );
}

module multiboard_back_assembled() {
    difference() {
        modular_back_core();
        for (x = multiboard_mount_x)
            for (z = multiboard_mount_z)
                multiboard_mount_void(
                    x,
                    z,
                    back_t,
                    true
                );
    }
}

module multiboard_back_print() {
    translate([back_w / 2, back_h, back_t])
        rotate([90, 0, 0])
            multiboard_back_assembled();
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

module multiboard_fit_coupon_assembled() {
    difference() {
        rounded_prism_y(
            back_w,
            fit_coupon_t,
            back_h,
            3,
            -fit_coupon_t,
            0
        );
        for (x = multiboard_mount_x)
            for (z = multiboard_mount_z)
                multiboard_mount_void(
                    x,
                    z,
                    fit_coupon_t,
                    false
                );
    }
}

module multiboard_fit_coupon_print() {
    translate([back_w / 2, back_h, fit_coupon_t])
        rotate([90, 0, 0])
            multiboard_fit_coupon_assembled();
}

module spacing_coupon_assembled() {
    difference() {
        rounded_prism_y(
            arm_w,
            spacing_coupon_length,
            arm_h,
            arm_corner_r,
            0,
            0
        );

        for (opening_record = spacing_coupon_records())
            racket_slot_void(
                opening_record,
                0,
                arm_h,
                arm_w
            );
    }
}

module preview_racket_shafts() {
    for (centre_y = racket_centres)
        color([0.16, 0.17, 0.18])
            translate([
                0,
                centre_y,
                arm_z0 - 9
            ])
                cylinder(
                    d = nominal_shaft_d,
                    h = arm_h + 18,
                    $fn = round_fn
                );
}

module preview_assembled(back_kind = "skadis") {
    color([0.34, 0.35, 0.37])
        if (back_kind == "skadis")
            skadis_back_assembled();
        else
            multiboard_back_assembled();

    // The complete connected body uses one colour so every alternating tooth
    // reads as part of the same continuous print.
    color([0.92, 0.45, 0.10])
        connected_body(false);

    preview_racket_shafts();
}

module preview_zigzag_spine() {
    color([0.92, 0.45, 0.10])
        connected_body(false);
}

module preview_skadis_rear() {
    color([0.34, 0.35, 0.37])
        modular_back_core();

    for (x = skadis_hook_x)
        color([0.92, 0.45, 0.10])
            skadis_load_hook(
                x,
                skadis_hook_z,
                back_t
            );

    // Bearing supports use the back colour and are not counted as hooks.
    for (x = skadis_lower_pad_x)
        color([0.34, 0.35, 0.37])
            skadis_lower_bearing_pad(
                x,
                skadis_lower_pad_z,
                back_t
            );
}

module preview_multiboard_rear() {
    color([0.34, 0.35, 0.37])
        multiboard_back_assembled();

    // Preview-only labels identify the two actual holes without depicting
    // printed Multiboard connectors. External M4-compatible board hardware
    // supplies the board-side engagement.
    for (z = multiboard_mount_z)
        color([0.92, 0.45, 0.10])
            translate([18, -back_t - 0.3, z])
                rotate([90, 0, 0])
                    linear_extrude(height = 0.5)
                        text(
                            "M4",
                            size = 4,
                            halign = "center",
                            valign = "center"
                        );
}

module preview_print_orientation() {
    color([0.92, 0.45, 0.10])
        connected_body_print(false);

    color([0.70, 0.70, 0.68, 0.35])
        translate([-5, -5, -0.6])
            cube([
                body_print_bounds[0] + 10,
                body_print_bounds[1] + 10,
                0.6
            ]);
}

if (selected_render_mode == "body_start_left")
    connected_body_print(false);
else if (selected_render_mode == "body_start_right")
    connected_body_print(true);
else if (selected_render_mode == "skadis_back")
    skadis_back_print();
else if (selected_render_mode == "multiboard_back")
    multiboard_back_print();
else if (selected_render_mode == "skadis_fit_coupon")
    skadis_fit_coupon_print();
else if (selected_render_mode == "multiboard_fit_coupon")
    multiboard_fit_coupon_print();
else if (selected_render_mode == "spacing_coupon")
    spacing_coupon_assembled();
else if (selected_render_mode == "preview_assembled_skadis")
    preview_assembled("skadis");
else if (selected_render_mode == "preview_assembled_multiboard")
    preview_assembled("multiboard");
else if (selected_render_mode == "preview_zigzag_spine")
    preview_zigzag_spine();
else if (selected_render_mode == "preview_skadis_rear")
    preview_skadis_rear();
else if (selected_render_mode == "preview_multiboard_rear")
    preview_multiboard_rear();
else if (selected_render_mode == "preview_print_orientation")
    preview_print_orientation();
else if (selected_render_mode == "none") {
    // Test mode deliberately emits no source geometry.
}
