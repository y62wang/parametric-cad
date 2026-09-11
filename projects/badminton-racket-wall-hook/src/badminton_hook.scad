// Compact v2.2 badminton racket rack for IKEA SKÅDIS and Multiboard.
//
// All printable geometry in this file is modelled independently. The racket
// body and mounting backs are separate parts. A positive key carries interface
// shear and four M4 screws retain the body against the selected mounting back.
// All dimensions are millimetres.

/* [Output] */
render_mode = "body_alternating";
// body, body_alternating, body_alternating_reverse, body_right, body_left,
// skadis_back_v2, multiboard_back_v2,
// assembled_skadis_v2, assembled_skadis_v2_reverse,
// assembled_skadis_right, assembled_skadis_left,
// assembled_multiboard_v2, assembled_multiboard_v2_reverse,
// assembled_multiboard_right, assembled_multiboard_left,
// skadis_coupon_v2, multiboard_coupon_v2,
// racket_spacing_coupon_v2_2,
// body_print_preview, skadis_back_rear_preview,
// multiboard_board_side_preview, multiboard_interface_side_preview,
// skadis_engagement_preview,
// racket_spacing_coupon_preview,
// compatibility aliases: skadis_back, multiboard_back, assembled_skadis,
// assembled_multiboard, skadis_coupon, multiboard_coupon,
// racket_spacing_coupon, multiboard_back_preview, alignment_preview, none

/* [Racket fit] */
entry_pattern = "alternating"; // "alternating", "left" or "right"
reverse_alternating = false;   // false begins left; true begins right
num_slots = 10;
shaft_d = 7.2;
pocket_d = 8.8;
entry_gap = 6.6;
slot_pitch = 20;

/* [Universal v2.2 body] */
wall_t = 6.6;
arm_h = 28;
arm_z0 = 32;
arm_corner_r = 3;
arm_start_y = 6;
first_slot_y = 17;
tip_margin = 4;
heel_w = 92;
heel_h = 60;
heel_t = 8;
heel_corner_r = 4;
root_flare_w = 60;
root_transition_end_y = 12;
gusset_t = 6;
gusset_end_y = 12;

/* [Body-to-back interface] */
key_w = 48;
key_h = 30;
key_depth = 3;
key_corner_r = 4;
key_z0 = 17;
key_clearance_per_side = 0.25;
key_depth_clearance = 0.35;
body_to_back_z = 2;
body_bolt_x = [-30, 30];
body_bolt_z = [18, 45];
m4_clearance_d = 4.5;
body_counterbore_d = 8.2;
body_counterbore_depth = 4.2;
insert_entry_d = 5.9;
insert_tip_d = 5.4;
insert_depth = 6.2;

/* [Compact v2.2 mounting backs] */
back_t = 8;
back_corner_r = 4;
skadis_back_w = 100;
skadis_back_h = 72;
multiboard_back_w = 100;
multiboard_back_h = 72;

/* [SKÅDIS v2.2 connection] */
skadis_slot_w = 5;
skadis_slot_h = 15;
skadis_board_t = 3;
skadis_board_clearance = 0.4;
skadis_standoff = 0.8;
skadis_hook_x = [-40, 0, 40];
skadis_hook_z = 58;
skadis_hook_pitch = 40;
skadis_hook_w = 4.2;
skadis_hook_depth = 2.8;
skadis_hook_tongue_h = 12;
skadis_hook_neck_h = 4;
skadis_tongue_chamfer = 0.6;
skadis_tongue_neck_overlap = 0.2;
skadis_upper_pad_x = skadis_hook_x;
skadis_upper_pad_w = 12;
skadis_upper_pad_h = 14;
skadis_lower_pad_x = [-30, 0, 30];
skadis_lower_pad_z = 10;
skadis_lower_pad_w = 24;
skadis_lower_pad_h = 14;
skadis_lower_locator_x = [];

/* [Multiboard v2.2 connection] */
multiboard_cell_pitch = 25;
multiboard_mount_x = [-25, 25];
multiboard_mount_z = [11, 61];
multiboard_mount_pitch_x = 50;
multiboard_mount_pitch_z = 50;
multiboard_counterbore_d = 8.4;
multiboard_counterbore_depth = 4.2;

/* [Full-pattern coupons] */
skadis_coupon_w = skadis_back_w;
skadis_coupon_h = skadis_back_h;
skadis_coupon_t = 3;
skadis_coupon_x = skadis_hook_x;
skadis_coupon_hook_z = skadis_hook_z;
skadis_coupon_lower_pad_x = skadis_lower_pad_x;
skadis_coupon_lower_pad_z = skadis_lower_pad_z;
multiboard_coupon_w = multiboard_back_w;
multiboard_coupon_h = multiboard_back_h;
multiboard_coupon_t = 3;
multiboard_coupon_mount_x = multiboard_mount_x;
multiboard_coupon_mount_z = multiboard_mount_z;

/* [Racket spacing coupon] */
spacing_coupon_num_slots = 3;
spacing_coupon_pitch = slot_pitch;
spacing_coupon_end_margin = 4;

/* [Rendering quality] */
round_fn = 40;

/* Derived dimensions */
shaft_r = shaft_d / 2;
pocket_r = pocket_d / 2;
arm_w = pocket_d + 2 * wall_t;
racket_slot_centres = [
    for (i = [0 : num_slots - 1])
        [0, first_slot_y + i * slot_pitch]
];
last_slot_y = racket_slot_centres[len(racket_slot_centres) - 1][1];
body_tip_y = last_slot_y + pocket_r + tip_margin;
body_side_print_length = body_tip_y + key_depth;
interface_fastener_count = len(body_bolt_x) * len(body_bolt_z);
body_bolt_global_z = [for (z = body_bolt_z) z + body_to_back_z];
back_key_z0 = body_to_back_z + key_z0;
arm_top_z = arm_z0 + arm_h;
body_print_support_gap = heel_h - arm_top_z;
body_print_arm_contact_width = arm_w - 2 * arm_corner_r;
body_print_heel_contact_width = heel_w - 2 * heel_corner_r;
body_print_nominal_arm_contact_length =
    body_tip_y - arm_start_y - arm_corner_r;
body_print_nominal_coplanar_area =
    body_print_arm_contact_width *
        body_print_nominal_arm_contact_length +
    body_print_heel_contact_width * heel_t;
spacing_coupon_first_y = pocket_r + spacing_coupon_end_margin;
spacing_coupon_centres = [
    for (i = [0 : spacing_coupon_num_slots - 1])
        [0, spacing_coupon_first_y + i * spacing_coupon_pitch]
];
spacing_coupon_last_y =
    spacing_coupon_centres[len(spacing_coupon_centres) - 1][1];
spacing_coupon_length =
    spacing_coupon_last_y + pocket_r + spacing_coupon_end_margin;
spacing_coupon_pocket_d = pocket_d;
spacing_coupon_entry_gap = entry_gap;
spacing_coupon_arm_w = arm_w;
spacing_coupon_arm_h = arm_h;
spacing_coupon_print_support_gap = 0;
spacing_coupon_opening_records = [
    for (i = [0 : spacing_coupon_num_slots - 1])
        [
            spacing_coupon_centres[i][0],
            spacing_coupon_centres[i][1],
            i % 2 == 0 ? "left" : "right"
        ]
];
skadis_hook_tongue_z0 =
    skadis_hook_z - skadis_hook_tongue_h / 2;
skadis_hook_neck_z0 =
    skadis_hook_tongue_z0 +
    skadis_hook_tongue_h -
    skadis_hook_neck_h;
skadis_hook_down_latch_h =
    skadis_hook_neck_z0 - skadis_hook_tongue_z0;
skadis_engaged_slot_z =
    skadis_hook_z + skadis_hook_down_latch_h;

// Rigid openings on both sides of each pocket would cut the arm into separate
// sections. True per-pocket left-or-right access needs moving or removable
// gates; the robust one-piece choices are left, right or alternating.
function valid_entry_pattern(pattern) =
    pattern == "alternating" ||
    pattern == "left" ||
    pattern == "right";

function invalid_entry_pattern_message(pattern) =
    str(
        "entry_pattern must be \"alternating\", \"left\" or \"right\"; ",
        "\"both\" is unsupported because bilateral cuts would disconnect ",
        "the arm. True per-pocket access needs moving or removable gates. Got ",
        pattern
    );

function slot_side_for(index, pattern, reverse = false) =
    assert(
        valid_entry_pattern(pattern),
        invalid_entry_pattern_message(pattern)
    )
    pattern == "alternating"
        ? ((index + (reverse ? 1 : 0)) % 2 == 0 ? "left" : "right")
        : pattern;

function slot_centres_for() = racket_slot_centres;

function slot_opening_records_for(
    pattern = entry_pattern,
    reverse = reverse_alternating
) =
    assert(
        valid_entry_pattern(pattern),
        invalid_entry_pattern_message(pattern)
    )
    [
        for (i = [0 : len(racket_slot_centres) - 1])
            [
                racket_slot_centres[i][0],
                racket_slot_centres[i][1],
                slot_side_for(i, pattern, reverse)
            ]
    ];

function body_nominal_dimensions_for(
    pattern = entry_pattern,
    reverse = reverse_alternating
) =
    assert(
        valid_entry_pattern(pattern),
        invalid_entry_pattern_message(pattern)
    )
    [heel_w, body_side_print_length, heel_h];

function render_pattern_for(mode, fallback_pattern) =
    mode == "body_right" ||
    mode == "assembled_skadis_right" ||
    mode == "assembled_multiboard_right" ? "right" :
    mode == "body_left" ||
    mode == "assembled_skadis_left" ||
    mode == "assembled_multiboard_left" ? "left" :
    mode == "body_alternating" ||
    mode == "body_alternating_reverse" ||
    mode == "assembled_skadis_v2" ||
    mode == "assembled_skadis_v2_reverse" ||
    mode == "assembled_multiboard_v2" ||
    mode == "assembled_multiboard_v2_reverse" ||
    mode == "body_print_preview" ||
    mode == "alignment_preview" ? "alternating" :
    fallback_pattern;

function render_reverse_for(mode, fallback_reverse) =
    mode == "body_alternating_reverse" ||
    mode == "assembled_skadis_v2_reverse" ||
    mode == "assembled_multiboard_v2_reverse" ? true :
    mode == "body_alternating" ||
    mode == "assembled_skadis_v2" ||
    mode == "assembled_multiboard_v2" ||
    mode == "body_print_preview" ||
    mode == "alignment_preview" ? false :
    fallback_reverse;

active_entry_pattern =
    render_pattern_for(render_mode, entry_pattern);
active_reverse_alternating =
    render_reverse_for(render_mode, reverse_alternating);

assert(
    valid_entry_pattern(entry_pattern),
    invalid_entry_pattern_message(entry_pattern)
);
assert(
    entry_gap < shaft_d && shaft_d < pocket_d,
    "Entry, shaft and pocket diameters must increase in that order"
);
assert(num_slots == 10, "The reviewed v2 body requires ten slots");
assert(
    first_slot_y - pocket_r - root_transition_end_y >= 0.5,
    "The root transition overlaps the first pocket"
);
assert(
    first_slot_y - pocket_r - gusset_end_y >= 0.5,
    "The root gussets overlap the first pocket"
);
assert(
    body_side_print_length <= 250,
    str("Body exceeds the 250 mm target: ", body_side_print_length)
);
assert(
    body_print_support_gap == 0,
    str(
        "Heel and arm print planes must be coplanar; gap is ",
        body_print_support_gap,
        " mm"
    )
);
assert(
    spacing_coupon_num_slots == 3 &&
    spacing_coupon_pitch == slot_pitch &&
    spacing_coupon_print_support_gap == 0,
    "The three-slot racket spacing coupon must match the support-free body"
);

echo(str("RENDER_MODE: ", render_mode));
echo(str(
    "RACKET_FIT: shaft dia ", shaft_d,
    ", pocket dia ", pocket_d,
    ", entry ", entry_gap,
    ", pattern ", active_entry_pattern,
    ", reverse ", active_reverse_alternating
));
echo(str(
    "BODY_V2_2: ", num_slots,
    " slots at ", slot_pitch,
    " pitch; projection ", body_tip_y,
    "; print axis ", body_side_print_length,
    "; heel ", heel_w, " x ", heel_h, " x ", heel_t,
    "; arm ", arm_w, " x ", arm_h,
    " at Z ", arm_z0, "..", arm_z0 + arm_h
));
echo(str(
    "BODY_PRINT_CONTACT: support gap ", body_print_support_gap,
    "; arm flat width ", body_print_arm_contact_width,
    "; heel flat width ", body_print_heel_contact_width,
    "; nominal coplanar area ", body_print_nominal_coplanar_area
));
echo("RACKET_SLOT_CENTRES_X_Y", racket_slot_centres);
echo(
    "RACKET_SLOT_OPENINGS",
    slot_opening_records_for(
        active_entry_pattern,
        active_reverse_alternating
    )
);
echo(str(
    "INTERFACE_KEY: ", key_w, " x ", key_h, " x ", key_depth,
    "; recess clearance per side ", key_clearance_per_side
));
echo(
    "BODY_M4_POSITIONS_X_Z",
    [for (x = body_bolt_x) for (z = body_bolt_z) [x, z]]
);
echo(
    "SKADIS_HOOK_POSITIONS_X_Z",
    [for (x = skadis_hook_x) [x, skadis_hook_z]]
);
echo(str(
    "SKADIS_LATCH: ",
    skadis_hook_down_latch_h,
    " mm tongue below the neck; insert then lower"
));
echo(
    "MULTIBOARD_M4_POSITIONS_X_Z",
    [
        for (x = multiboard_mount_x)
            for (z = multiboard_mount_z)
                [x, z]
    ]
);
echo(
    "RACKET_SPACING_COUPON_CENTRES_X_Y",
    spacing_coupon_centres
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
            r = pocket_r,
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

module rounded_arm_shell() {
    hull() {
        for (x = [
            -arm_w / 2 + arm_corner_r,
            arm_w / 2 - arm_corner_r
        ])
            for (z = [
                arm_z0 + arm_corner_r,
                arm_z0 + arm_h - arm_corner_r
            ]) {
                translate([x, arm_start_y, z])
                    rotate([-90, 0, 0])
                        cylinder(
                            r = arm_corner_r,
                            h =
                                body_tip_y -
                                arm_start_y -
                                arm_corner_r,
                            $fn = round_fn
                        );
                translate([x, body_tip_y - arm_corner_r, z])
                    sphere(r = arm_corner_r, $fn = round_fn);
            }
    }
}

module root_flare() {
    hull() {
        rounded_prism_y(
            root_flare_w,
            1,
            arm_h,
            arm_corner_r,
            arm_start_y,
            arm_z0
        );
        rounded_prism_y(
            arm_w,
            1,
            arm_h,
            arm_corner_r,
            root_transition_end_y - 1,
            arm_z0
        );
    }
}

module right_root_gusset(z0) {
    root_inner_x = arm_w / 2 - 1.5;
    root_outer_x = heel_w / 2 - 8;

    hull() {
        translate([
            root_inner_x,
            heel_t - 2,
            z0
        ])
            cube([
                root_outer_x - root_inner_x,
                3,
                gusset_t
            ]);
        translate([
            root_inner_x,
            gusset_end_y - 1,
            z0
        ])
            cube([3, 1, gusset_t]);
    }
}

module symmetric_root_gussets() {
    for (z0 = [
        arm_z0,
        arm_z0 + arm_h - gusset_t
    ]) {
        right_root_gusset(z0);
        mirror([1, 0, 0])
            right_root_gusset(z0);
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

module universal_body(
    pattern = entry_pattern,
    reverse = reverse_alternating
) {
    assert(
        valid_entry_pattern(pattern),
        invalid_entry_pattern_message(pattern)
    );

    difference() {
        union() {
            rounded_prism_y(
                heel_w,
                heel_t,
                heel_h,
                heel_corner_r,
                0,
                0
            );
            shear_key();
            rounded_arm_shell();
            root_flare();
            symmetric_root_gussets();
        }

        for (
            opening_record =
                slot_opening_records_for(pattern, reverse)
        )
            racket_slot_void(opening_record);

        for (x = body_bolt_x)
            for (z = body_bolt_z)
                body_fastener_void(x, z);
    }
}

module universal_body_print(
    pattern = entry_pattern,
    reverse = reverse_alternating
) {
    // The heel top and arm top are coplanar. Inversion places both broad
    // surfaces on Z=0 for a support-free supplied body export.
    translate([heel_w / 2, key_depth, heel_h])
        rotate([0, 180, 0])
            universal_body(pattern, reverse);
}

module interface_recess_void() {
    rounded_prism_y(
        key_w + 2 * key_clearance_per_side,
        key_depth + key_depth_clearance + 0.2,
        key_h + 2 * key_clearance_per_side,
        key_corner_r + key_clearance_per_side,
        -(key_depth + key_depth_clearance),
        back_key_z0 - key_clearance_per_side
    );
}

// Tapered blind pocket for a nominal 5.7 x 6 mm M4 heat-set insert.
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

module modular_back_core(width, height) {
    difference() {
        rounded_prism_y(
            width,
            back_t,
            height,
            back_corner_r,
            -back_t,
            0
        );
        interface_recess_void();
        for (x = body_bolt_x)
            for (z = body_bolt_global_z)
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

// Independent gravity latch. Push the chamfered tongue through the nominal
// slot, bring the plate against the board, then lower it so the neck bears on
// the slot and the downward tongue remains behind the board.
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

module skadis_lower_compression_pad(x, z, plate_t) {
    skadis_contact_pad(
        x,
        z,
        skadis_lower_pad_w,
        skadis_lower_pad_h,
        plate_t
    );
}

module skadis_back_v2() {
    union() {
        modular_back_core(skadis_back_w, skadis_back_h);

        for (x = skadis_hook_x)
            skadis_load_hook(x, skadis_hook_z, back_t);

        for (x = skadis_lower_pad_x)
            skadis_lower_compression_pad(
                x,
                skadis_lower_pad_z,
                back_t
            );
    }
}

function skadis_part_depth(plate_t) =
    plate_t +
    skadis_standoff +
    skadis_board_t +
    skadis_board_clearance +
    skadis_hook_depth;

module skadis_back_v2_print() {
    translate([
        skadis_back_h,
        skadis_part_depth(back_t),
        skadis_back_w / 2
    ])
        rotate([0, -90, 0])
            skadis_back_v2();
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

module multiboard_back_v2() {
    difference() {
        modular_back_core(
            multiboard_back_w,
            multiboard_back_h
        );
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

module multiboard_back_v2_print() {
    translate([
        multiboard_back_w / 2,
        multiboard_back_h,
        back_t
    ])
        rotate([90, 0, 0])
            multiboard_back_v2();
}

module skadis_fit_coupon_v2() {
    union() {
        rounded_prism_y(
            skadis_coupon_w,
            skadis_coupon_t,
            skadis_coupon_h,
            3,
            -skadis_coupon_t,
            0
        );

        for (x = skadis_coupon_x)
            skadis_load_hook(
                x,
                skadis_coupon_hook_z,
                skadis_coupon_t
            );

        for (x = skadis_coupon_lower_pad_x)
            skadis_lower_compression_pad(
                x,
                skadis_coupon_lower_pad_z,
                skadis_coupon_t
            );
    }
}

module skadis_fit_coupon_v2_print() {
    translate([
        skadis_coupon_h,
        skadis_part_depth(skadis_coupon_t),
        skadis_coupon_w / 2
    ])
        rotate([0, -90, 0])
            skadis_fit_coupon_v2();
}

module multiboard_spacing_coupon_v2() {
    difference() {
        rounded_prism_y(
            multiboard_coupon_w,
            multiboard_coupon_t,
            multiboard_coupon_h,
            3.5,
            -multiboard_coupon_t,
            0
        );
        for (x = multiboard_coupon_mount_x)
            for (z = multiboard_coupon_mount_z)
                multiboard_mount_void(
                    x,
                    z,
                    multiboard_coupon_t,
                    false
                );
    }
}

module multiboard_spacing_coupon_v2_print() {
    translate([
        multiboard_coupon_w / 2,
        multiboard_coupon_h,
        multiboard_coupon_t
    ])
        rotate([90, 0, 0])
            multiboard_spacing_coupon_v2();
}

// Three real rackets can be trialled at the final 20 mm spacing before the
// full body is printed. The coupon reuses the body's arm, pocket and entry
// dimensions and alternates left/right/left insertion.
module racket_spacing_coupon_v2_2() {
    difference() {
        rounded_prism_y(
            spacing_coupon_arm_w,
            spacing_coupon_length,
            spacing_coupon_arm_h,
            arm_corner_r,
            0,
            0
        );

        for (opening_record = spacing_coupon_opening_records)
            racket_slot_void(
                opening_record,
                0,
                spacing_coupon_arm_h,
                spacing_coupon_arm_w
            );
    }
}

module racket_spacing_coupon_v2_2_print() {
    racket_spacing_coupon_v2_2();
}

module assembled_skadis_v2(
    pattern = "alternating",
    reverse = false
) {
    color([0.32, 0.34, 0.36])
        skadis_back_v2();
    color([0.88, 0.42, 0.12])
        translate([0, 0, body_to_back_z])
            universal_body(pattern, reverse);
}

module assembled_multiboard_v2(
    pattern = "alternating",
    reverse = false
) {
    color([0.32, 0.34, 0.36])
        multiboard_back_v2();
    color([0.88, 0.42, 0.12])
        translate([0, 0, body_to_back_z])
            universal_body(pattern, reverse);
}

// Preview-only build plate. It is never included by a printable body mode.
module body_print_orientation_preview() {
    color([0.88, 0.58, 0.10])
        universal_body_print("alternating", false);
    color([0.72, 0.72, 0.70, 0.55])
        translate([-5, -5, -0.6])
            cube([
                heel_w + 10,
                body_side_print_length + 10,
                0.6
            ]);
}

module skadis_back_rear_preview() {
    color([0.30, 0.32, 0.34])
        skadis_back_v2();
}

// These two preview modes intentionally use the same printable back. Their
// camera directions distinguish the board side, where only the four actual
// Multiboard mounting holes are visible, from the body-facing interface side.
module multiboard_board_side_preview() {
    color([0.30, 0.32, 0.34])
        multiboard_back_v2();
}

module multiboard_interface_side_preview() {
    color([0.30, 0.32, 0.34])
        multiboard_back_v2();
}

module multiboard_back_preview() {
    multiboard_board_side_preview();
}

module racket_spacing_coupon_preview() {
    color([0.88, 0.58, 0.10])
        racket_spacing_coupon_v2_2();
}

// Preview-only SKÅDIS board patch. Slots are shown after the back has lowered
// by the 8 mm latch travel, so the downward tongues remain behind the board.
module skadis_board_preview() {
    preview_board_w = skadis_back_w + 20;
    preview_board_h = 28;
    preview_board_z0 =
        skadis_engaged_slot_z - preview_board_h / 2;
    board_front_y = -back_t - skadis_standoff;
    board_rear_y = board_front_y - skadis_board_t;

    difference() {
        rounded_prism_y(
            preview_board_w,
            skadis_board_t,
            preview_board_h,
            3,
            board_rear_y,
            preview_board_z0
        );
        for (x = skadis_hook_x)
            translate([
                x - skadis_slot_w / 2,
                board_rear_y - 0.2,
                skadis_engaged_slot_z - skadis_slot_h / 2
            ])
                cube([
                    skadis_slot_w,
                    skadis_board_t + 0.4,
                    skadis_slot_h
                ]);
    }
}

// Preview-only frames mark the nominal slot edges on the rear board face. The
// orange necks remain inside these frames while each longer tongue extends
// below the lower edge after the back is lowered.
module skadis_slot_frame_preview(x) {
    frame_w = 0.8;
    frame_depth = 0.35;
    board_front_y = -back_t - skadis_standoff;
    board_rear_y = board_front_y - skadis_board_t;
    frame_y0 = board_rear_y - frame_depth - 0.05;
    slot_z0 = skadis_engaged_slot_z - skadis_slot_h / 2;

    translate([
        x - skadis_slot_w / 2 - frame_w,
        frame_y0,
        slot_z0 - frame_w
    ])
        cube([
            frame_w,
            frame_depth,
            skadis_slot_h + 2 * frame_w
        ]);

    translate([
        x + skadis_slot_w / 2,
        frame_y0,
        slot_z0 - frame_w
    ])
        cube([
            frame_w,
            frame_depth,
            skadis_slot_h + 2 * frame_w
        ]);

    for (z = [slot_z0 - frame_w, slot_z0 + skadis_slot_h])
        translate([
            x - skadis_slot_w / 2 - frame_w,
            frame_y0,
            z
        ])
            cube([
                skadis_slot_w + 2 * frame_w,
                frame_depth,
                frame_w
            ]);
}

module skadis_neck_highlight_preview(x, z, plate_t) {
    board_front_y = -plate_t - skadis_standoff;
    board_rear_y = board_front_y - skadis_board_t;
    tongue_front_y =
        board_rear_y - skadis_board_clearance;
    tongue_z0 = z - skadis_hook_tongue_h / 2;
    neck_z0 =
        tongue_z0 +
        skadis_hook_tongue_h -
        skadis_hook_neck_h;
    neck_depth = -plate_t + 0.2 - tongue_front_y;

    translate([
        x - skadis_hook_w / 2,
        tongue_front_y - 0.02,
        neck_z0
    ])
        cube([
            skadis_hook_w,
            neck_depth + 0.04,
            skadis_hook_neck_h
        ]);
}

module skadis_engagement_preview() {
    // Separate preview-only colours make the three unchanged load hooks
    // readable through the transparent board from a rear oblique camera.
    color([0.30, 0.32, 0.34, 1]) {
        modular_back_core(skadis_back_w, skadis_back_h);
        for (x = skadis_lower_pad_x)
            skadis_lower_compression_pad(
                x,
                skadis_lower_pad_z,
                back_t
            );
    }

    for (x = skadis_hook_x)
        color([0.95, 0.42, 0.08, 1])
            skadis_load_hook(x, skadis_hook_z, back_t);

    for (x = skadis_hook_x)
        color([1.00, 0.82, 0.12, 1])
            skadis_neck_highlight_preview(
                x,
                skadis_hook_z,
                back_t
            );

    color([0.82, 0.84, 0.80, 0.20])
        skadis_board_preview();

    for (x = skadis_hook_x)
        color([0.92, 0.92, 0.88, 1])
            skadis_slot_frame_preview(x);
}

if (render_mode == "body")
    universal_body_print(
        entry_pattern,
        reverse_alternating
    );
else if (render_mode == "body_alternating")
    universal_body_print("alternating", false);
else if (render_mode == "body_alternating_reverse")
    universal_body_print("alternating", true);
else if (render_mode == "body_right")
    universal_body_print("right", false);
else if (render_mode == "body_left")
    universal_body_print("left", false);
else if (
    render_mode == "skadis_back_v2" ||
    render_mode == "skadis_back"
)
    skadis_back_v2_print();
else if (
    render_mode == "multiboard_back_v2" ||
    render_mode == "multiboard_back"
)
    multiboard_back_v2_print();
else if (render_mode == "assembled_skadis_v2")
    assembled_skadis_v2("alternating", false);
else if (render_mode == "assembled_skadis_v2_reverse")
    assembled_skadis_v2("alternating", true);
else if (render_mode == "assembled_skadis_right")
    assembled_skadis_v2("right", false);
else if (render_mode == "assembled_skadis_left")
    assembled_skadis_v2("left", false);
else if (render_mode == "assembled_skadis")
    assembled_skadis_v2(
        entry_pattern,
        reverse_alternating
    );
else if (render_mode == "assembled_multiboard_v2")
    assembled_multiboard_v2("alternating", false);
else if (render_mode == "assembled_multiboard_v2_reverse")
    assembled_multiboard_v2("alternating", true);
else if (render_mode == "assembled_multiboard_right")
    assembled_multiboard_v2("right", false);
else if (render_mode == "assembled_multiboard_left")
    assembled_multiboard_v2("left", false);
else if (render_mode == "assembled_multiboard")
    assembled_multiboard_v2(
        entry_pattern,
        reverse_alternating
    );
else if (
    render_mode == "skadis_coupon_v2" ||
    render_mode == "skadis_coupon"
)
    skadis_fit_coupon_v2_print();
else if (
    render_mode == "multiboard_coupon_v2" ||
    render_mode == "multiboard_coupon"
)
    multiboard_spacing_coupon_v2_print();
else if (
    render_mode == "racket_spacing_coupon_v2_2" ||
    render_mode == "racket_spacing_coupon"
)
    racket_spacing_coupon_v2_2_print();
else if (render_mode == "body_print_preview")
    body_print_orientation_preview();
else if (render_mode == "skadis_back_rear_preview")
    skadis_back_rear_preview();
else if (
    render_mode == "multiboard_board_side_preview" ||
    render_mode == "multiboard_back_preview"
)
    multiboard_board_side_preview();
else if (render_mode == "multiboard_interface_side_preview")
    multiboard_interface_side_preview();
else if (render_mode == "skadis_engagement_preview")
    skadis_engagement_preview();
else if (render_mode == "racket_spacing_coupon_preview")
    racket_spacing_coupon_preview();
else if (render_mode == "alignment_preview")
    // Compatibility alias: printable alternating body only, with no guides.
    color([0.88, 0.58, 0.10])
        universal_body("alternating", false);
else if (render_mode == "none") {
    // Test mode deliberately emits no source geometry.
}
else
    assert(false, str("Unknown render_mode: ", render_mode));
