// v2.4 printable full-rack prototype for IKEA SKÅDIS and Multiboard.
//
// This file is deliberately separate from the released v2.2 source and the
// v2.3 mechanism coupons. It provides printable full-length body sections,
// ten rotating collars, an indexed assembly cradle, a two-hook SKÅDIS back and
// a two-point Multiboard back for external M4-compatible board hardware. The
// package still requires physical connector, cycle, sustained-load and
// supervised proof-load testing before release. All dimensions are millimetres.

render_mode = "preview_complete_skadis";
selected_render_mode = render_mode;

prototype_version = "2.4";
prototype_release_status =
    "printable_full_rack_prototype_not_released";
full_body_export_supported = true;
ten_racket_load_verified = false;
load_rating_status = "physical_validation_required";
print_bed_xy = [256, 256];

/* [Mounting backs] */
back_w = 72;
back_h = 72;
back_t = 8;
back_corner_r = 4;

/* [Centred body interface] */
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

/* [Root and printable full body] */
root_start_y = heel_t;
root_flare_w = 40;
root_transition_y = 10.5;
num_racket_positions = 10;
racket_first_y = 23;
collar_pitch = 21;
racket_centres = [
    for (i = [0 : num_racket_positions - 1])
        racket_first_y + i * collar_pitch
];
full_projection = 226;
racket_axes_x = [
    for (i = [0 : num_racket_positions - 1])
        arm_centre_x
];

// Compatibility aliases retained for inherited v2.3 preview helpers.
num_concept_positions = num_racket_positions;
concept_first_y = racket_first_y;
concept_centres = racket_centres;
concept_projection = full_projection;
structural_centres = [23, 44, 65];
structural_projection = 76;

/* [Racket and rotating collar] */
nominal_shaft_d = 7.2;
collar_bore_d = 9.0;
collar_barrel_d = 16.0;
cavity_diameters = [16.4, 16.5, 16.6];
nominal_cavity_d = 16.5;
throat_widths = [6.9, 7.1, 7.3];
nominal_throat_w = 7.1;
fixed_corridor_w = 8.0;
collar_flange_d = 17.2;
collar_flange_h = 2.0;
body_top_recess_d = 17.6;
body_top_recess_depth = 2.2;
captured_body_thickness = arm_h - body_top_recess_depth;
collar_capture_span = 34.0;
collar_axial_movement =
    collar_capture_span - captured_body_thickness;
lip_extra_d = 0.6;
lip_retaining_shoulder = lip_extra_d / 2;
lip_insertion_chamfer_deg = 45;
lip_bottom_z = -1.2;
collar_flex_root_r = 1.5;
throat_lead_extra = 1.0;
throat_lead_length = 1.4;

/* [Collar stop, detent and indication] */
track_travel_deg = 180;
right_throat_pose_deg = 0;
midpoint_throat_pose_deg = 90;
left_throat_pose_deg = 180;
stop_tab_base_angle = 90;
track_start_angle = 90;
track_end_angle = 270;
track_endpoint_overrun_deg = 0;
endpoint_detent_strategy = "coincident_centres";
track_side_clearance = 0.25;
track_inner_r = 8.1;
track_outer_r = 9.6;
track_depth = 1.5;
stop_tab_inner_r = 7.8;
stop_tab_track_inner_r = 8.35;
stop_tab_outer_r = 9.15;
stop_tab_w = 1.4;
stop_tab_h = 1.1;
stop_tab_z0 = captured_body_thickness - track_depth + 0.2;
endpoint_detent_engagement = 0.18;
detent_r = 0.42;
detent_pocket_clearance = 0.08;
detent_pocket_r = detent_r + detent_pocket_clearance;
detent_centre_r =
    track_outer_r + endpoint_detent_engagement - detent_r;
flexible_detent_location = "collar";
fixed_web_has_flexible_feature = false;
tool_slot_l = 4.0;
tool_slot_w = 1.4;
tool_slot_depth = 1.0;
indicator_depth = 0.55;

/* [SKÅDIS connector] */
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

/* [Multiboard attachment points for external board hardware] */
multiboard_mount_x = [0];
multiboard_mount_z = [11, 61];
multiboard_mount_positions = [
    for (z = multiboard_mount_z)
        [0, z]
];
multiboard_mount_count = len(multiboard_mount_positions);
multiboard_attachment_points = multiboard_mount_positions;
multiboard_attachment_point_count =
    len(multiboard_attachment_points);
multiboard_hardware_included = false;
multiboard_attachment_hardware =
    "external_m4_compatible_multiboard_hardware";
multiboard_counterbore_d = 8.4;
multiboard_counterbore_depth = 4.2;

/* [Fit coupons] */
fit_coupon_t = 3;

/* [Tolerance matrix] */
tolerance_matrix_records = [
    [16.4, 6.9, "A1"], [16.5, 6.9, "A2"],
    [16.6, 6.9, "A3"], [16.4, 7.1, "B1"],
    [16.5, 7.1, "B2"], [16.6, 7.1, "B3"],
    [16.4, 7.3, "C1"], [16.5, 7.3, "C2"],
    [16.6, 7.3, "C3"]
];
matrix_cell_w = arm_w;
matrix_cell_d = 40;
matrix_x_pitch = 36;
matrix_y_pitch = 48;
matrix_half_depth =
    (matrix_cell_d - fixed_corridor_w) / 2;
matrix_half_offset_y =
    fixed_corridor_w / 2 + matrix_half_depth / 2;
matrix_cradle_w = 110;
matrix_cradle_d = 146;
matrix_cradle_t = 3.2;
matrix_cradle_corner_r = 5;
matrix_cradle_pocket_depth = 1.2;
matrix_cradle_pocket_clearance = 0.3;
matrix_cradle_hole_d = 22;
collar_plate_x_pitch = 38;
collar_plate_y_pitch = 34;
label_tag_w = 17;
label_tag_d = 7;
label_tag_h = 1.2;
label_bridge_w = 1.2;
label_bridge_h = 0.6;

/* [Structural coupon assembly cradle] */
structural_cradle_w = 80;
structural_cradle_y0 = -7;
structural_cradle_d = 87;
structural_cradle_t = 3.2;
structural_cradle_corner_r = 5;
structural_cradle_pocket_depth = 1.2;
structural_cradle_pocket_clearance = 0.35;
structural_cradle_hole_d = 22;
structural_section_ranges = [
    [-3, 19],
    [27, 40],
    [48, 61],
    [69, 76]
];

/* [Printable full-rack package] */
full_section_ranges = [
    [-key_depth, racket_centres[0] - fixed_corridor_w / 2],
    for (i = [0 : len(racket_centres) - 2])
        [
            racket_centres[i] + fixed_corridor_w / 2,
            racket_centres[i + 1] - fixed_corridor_w / 2
        ],
    [
        racket_centres[len(racket_centres) - 1] +
            fixed_corridor_w / 2,
        full_projection
    ]
];
full_section_labels = [
    "ROOT", "S2", "S3", "S4", "S5", "S6",
    "S7", "S8", "S9", "S10", "TIP"
];
collar_labels = [
    "R1", "R2", "R3", "R4", "R5",
    "R6", "R7", "R8", "R9", "R10"
];
full_cradle_w = 82;
full_cradle_y0 = -7;
full_cradle_d = 238;
full_cradle_t = 3.2;
full_cradle_corner_r = 5;
full_cradle_pocket_depth = 1.2;
full_cradle_pocket_clearance = 0.35;
full_cradle_hole_d = 22;
full_collar_x_pitch = 42;
full_collar_y_pitch = 48;

/* [Rendering] */
round_fn = 56;
preview_collar_angles = [
    0, 180, 0, 180, 0,
    180, 180, 0, 180, 0
];

/* Derived clearances */
function collar_lip_od(cavity_d) = cavity_d + lip_extra_d;

function nearly_equal(actual, expected, tolerance = 0.001) =
    abs(actual - expected) <= tolerance;

function normalise_angle(angle) =
    angle - 360 * floor(angle / 360);

function angular_distance(a, b) =
    let(delta = abs(normalise_angle(a) - normalise_angle(b)))
        min(delta, 360 - delta);

function point_at(radius, angle) = [
    radius * cos(angle),
    radius * sin(angle)
];

function point_distance(a, b) =
    sqrt(pow(a[0] - b[0], 2) + pow(a[1] - b[1], 2));

function stop_tab_angle_for(throat_angle) =
    normalise_angle(throat_angle + stop_tab_base_angle);

function tab_pose_inside_track(tab_angle) =
    let(progress =
        normalise_angle(tab_angle - track_start_angle))
        progress <= track_travel_deg;

function matrix_x(index) =
    (index % 3 - 1) * matrix_x_pitch;

function matrix_y(index) =
    (floor(index / 3) - 1) * matrix_y_pitch;

function matrix_half_label(record, side) =
    str(record[2], "-", side);

function mode_is_printable(mode) =
    mode == "full_body_sections" ||
    mode == "full_rack_collars" ||
    mode == "full_rack_cradle" ||
    mode == "tolerance_matrix_fixture" ||
    mode == "tolerance_matrix_collars" ||
    mode == "tolerance_matrix_cradle" ||
    mode == "structural_coupon_body" ||
    mode == "structural_coupon_collars" ||
    mode == "structural_coupon_cradle" ||
    mode == "skadis_back" ||
    mode == "multiboard_back" ||
    mode == "skadis_fit_coupon" ||
    mode == "multiboard_fit_coupon";

function expected_component_count(mode) =
    mode == "full_body_sections" ? 11 :
    mode == "full_rack_collars" ? 10 :
    mode == "full_rack_cradle" ? 1 :
    mode == "tolerance_matrix_fixture" ? 18 :
    mode == "tolerance_matrix_collars" ? 9 :
    mode == "tolerance_matrix_cradle" ? 1 :
    mode == "structural_coupon_body" ? 4 :
    mode == "structural_coupon_collars" ? 3 :
    mode == "structural_coupon_cradle" ? 1 :
    mode == "skadis_back" ? 1 :
    mode == "multiboard_back" ? 1 :
    mode == "skadis_fit_coupon" ? 1 :
    mode == "multiboard_fit_coupon" ? 1 :
    0;

right_stop_tab_angle =
    stop_tab_angle_for(right_throat_pose_deg);
midpoint_stop_tab_angle =
    stop_tab_angle_for(midpoint_throat_pose_deg);
left_stop_tab_angle =
    stop_tab_angle_for(left_throat_pose_deg);
hard_stop_travel_deg =
    normalise_angle(
        left_stop_tab_angle - right_stop_tab_angle
    );
right_throat_alignment_error_deg =
    angular_distance(right_throat_pose_deg, 0);
left_throat_alignment_error_deg =
    angular_distance(left_throat_pose_deg, 180);
right_pose_inside_track =
    tab_pose_inside_track(right_stop_tab_angle);
midpoint_pose_inside_track =
    tab_pose_inside_track(midpoint_stop_tab_angle);
left_pose_inside_track =
    tab_pose_inside_track(left_stop_tab_angle);
right_detent_bump_centre =
    point_at(detent_centre_r, right_stop_tab_angle);
left_detent_bump_centre =
    point_at(detent_centre_r, left_stop_tab_angle);
right_detent_pocket_centre =
    point_at(detent_centre_r, track_start_angle);
left_detent_pocket_centre =
    point_at(detent_centre_r, track_end_angle);
right_detent_centre_mismatch =
    point_distance(
        right_detent_bump_centre,
        right_detent_pocket_centre
    );
left_detent_centre_mismatch =
    point_distance(
        left_detent_bump_centre,
        left_detent_pocket_centre
    );
min_track_radial_clearance =
    min(
        stop_tab_track_inner_r - track_inner_r,
        track_outer_r - stop_tab_outer_r
    );
track_vertical_clearance = track_depth - stop_tab_h;
stop_tab_half_angle_deg =
    atan((stop_tab_w / 2) / stop_tab_inner_r);
track_tab_envelope_start_angle =
    track_start_angle - stop_tab_half_angle_deg;
track_tab_envelope_end_angle =
    track_end_angle + stop_tab_half_angle_deg;
track_tab_envelope_sweep_deg =
    track_travel_deg + 2 * stop_tab_half_angle_deg;

matrix_cradle_hole_centres = [
    for (i = [0 : len(tolerance_matrix_records) - 1])
        [matrix_x(i), matrix_y(i)]
];
matrix_cradle_pocket_centres = [
    for (i = [0 : len(tolerance_matrix_records) - 1])
        for (side = [-1, 1])
            [
                matrix_x(i),
                matrix_y(i) +
                    side * matrix_half_offset_y
            ]
];
matrix_half_labels = [
    for (record = tolerance_matrix_records)
        [
            matrix_half_label(record, "S"),
            matrix_half_label(record, "N")
        ]
];
matrix_cradle_floor_z =
    matrix_cradle_t - matrix_cradle_pocket_depth;
matrix_cradle_lip_radial_clearance =
    (matrix_cradle_hole_d -
        collar_lip_od(max(cavity_diameters))) / 2;
matrix_cradle_lip_bottom_z =
    matrix_cradle_floor_z + lip_bottom_z;

structural_cradle_hole_centres = [
    for (centre_y = structural_centres)
        [0, centre_y]
];
structural_cradle_pocket_records = [
    ["ROOT", structural_section_ranges[0]],
    ["S2", structural_section_ranges[1]],
    ["S3", structural_section_ranges[2]],
    ["TIP", structural_section_ranges[3]]
];
structural_cradle_floor_z =
    structural_cradle_t -
    structural_cradle_pocket_depth;
structural_cradle_lip_radial_clearance =
    (structural_cradle_hole_d -
        collar_lip_od(nominal_cavity_d)) / 2;
structural_cradle_lip_bottom_z =
    structural_cradle_floor_z + lip_bottom_z;

full_cradle_hole_centres = [
    for (centre_y = racket_centres)
        [0, centre_y]
];
full_cradle_pocket_records = [
    for (i = [0 : len(full_section_ranges) - 1])
        [full_section_labels[i], full_section_ranges[i]]
];
full_cradle_floor_z =
    full_cradle_t - full_cradle_pocket_depth;
full_cradle_lip_radial_clearance =
    (full_cradle_hole_d -
        collar_lip_od(nominal_cavity_d)) / 2;
full_cradle_lip_bottom_z =
    full_cradle_floor_z + lip_bottom_z;
full_body_print_bounds = [
    heel_w,
    full_projection + key_depth
];
full_cradle_bounds = [
    full_cradle_w,
    full_cradle_d
];

max_cavity_d = max(cavity_diameters);
min_cavity_web = collar_pitch - max_cavity_d;
min_corridor_web = collar_pitch - fixed_corridor_w;
min_cavity_side_wall = (arm_w - max_cavity_d) / 2;
top_recess_side_wall = (arm_w - body_top_recess_d) / 2;
track_to_arm_edge = arm_w / 2 - track_outer_r;
track_to_next_track = collar_pitch - 2 * track_outer_r;
final_track_tip_margin =
    full_projection -
    racket_centres[len(racket_centres) - 1] -
    track_outer_r;
concept_tip_margin = final_track_tip_margin;

body_counterbore_side_margin =
    heel_w / 2 - max(body_bolt_x) - body_counterbore_d / 2;
body_counterbore_bottom_margin =
    min(body_bolt_z) - heel_z0 - body_counterbore_d / 2;
body_counterbore_top_margin =
    heel_z0 + heel_h - max(body_bolt_z) -
    body_counterbore_d / 2;
insert_to_key_side_wall =
    min([for (x = body_bolt_x)
        abs(x) - insert_entry_d / 2 -
        (key_w / 2 + key_clearance_per_side)]);

skadis_hook_edge_margin =
    back_w / 2 - max(skadis_hook_x) - skadis_hook_w / 2;
skadis_lower_pad_edge_margin =
    back_w / 2 - max(skadis_lower_pad_x) -
    skadis_lower_pad_w / 2;
multiboard_edge_margin =
    min([
        for (position = multiboard_mount_positions)
            min(
                back_w / 2 - abs(position[0]) -
                    multiboard_counterbore_d / 2,
                position[1] -
                    multiboard_counterbore_d / 2,
                back_h - position[1] -
                    multiboard_counterbore_d / 2
            )
    ]);
multiboard_insert_cavity_clearance =
    min([
        for (position = multiboard_mount_positions)
            for (ix = body_bolt_x)
                for (iz = body_bolt_z)
                    sqrt(
                        pow(position[0] - ix, 2) +
                        pow(position[1] - iz, 2)
                    ) -
                    multiboard_counterbore_d / 2 -
                    insert_entry_d / 2
    ]);
multiboard_interface_vertical_clearance =
    min(
        heel_z0 -
            (
                multiboard_mount_z[0] +
                multiboard_counterbore_d / 2
            ),
        (
            multiboard_mount_z[1] -
            multiboard_counterbore_d / 2
        ) -
            (heel_z0 + heel_h)
    );
multiboard_key_clearance =
    min(
        key_z0 -
            (
                multiboard_mount_z[0] +
                multiboard_counterbore_d / 2
            ) -
            key_clearance_per_side,
        (
            multiboard_mount_z[1] -
            multiboard_counterbore_d / 2
        ) -
            (key_z0 + key_h) -
            key_clearance_per_side
    );

assert(
    collar_bore_d > nominal_shaft_d,
    "The collar bore must clear the nominal shaft"
);
assert(
    max(throat_widths) < collar_bore_d,
    "The C-throat must retain a solid collar arc"
);
assert(
    nearly_equal(captured_body_thickness, 33.8) &&
    nearly_equal(collar_axial_movement, 0.2),
    "The reviewed collar capture stack changed"
);
assert(
    track_to_next_track > 1.5 &&
    track_to_arm_edge >= 4.4,
    "The stop tracks do not fit the 21 mm pitch and 28 mm arm"
);
assert(
    nearly_equal(track_start_angle, right_stop_tab_angle) &&
    nearly_equal(track_end_angle, left_stop_tab_angle) &&
    nearly_equal(hard_stop_travel_deg, 180),
    "The stop track must follow the collar tab from 90 to 270 degrees"
);
assert(
    (
        track_endpoint_overrun_deg >= 10 ||
        (
            endpoint_detent_strategy ==
                "coincident_centres" &&
            right_detent_centre_mismatch <= 0.05 &&
            left_detent_centre_mismatch <= 0.05
        )
    ) &&
    right_pose_inside_track &&
    midpoint_pose_inside_track &&
    left_pose_inside_track,
    "The stop poses need endpoint overrun or coincident detent centres"
);
assert(
    right_detent_centre_mismatch <= 0.05 &&
    left_detent_centre_mismatch <= 0.05,
    "Endpoint detent and pocket centres do not coincide"
);
assert(
    endpoint_detent_engagement >= 0.15 &&
    endpoint_detent_engagement <= 0.20 &&
    flexible_detent_location == "collar",
    "The replaceable collar detent must retain 0.15..0.20 mm engagement"
);
assert(
    matrix_cradle_hole_d >= 18 &&
    structural_cradle_hole_d >= 18 &&
    full_cradle_hole_d >= 18 &&
    len(matrix_cradle_pocket_centres) == 18 &&
    len(structural_cradle_pocket_records) == 4 &&
    len(full_cradle_pocket_records) == 11 &&
    len(full_cradle_hole_centres) == 10,
    "Every assembly cradle must locate its loose body sections"
);
assert(
    matrix_cradle_lip_bottom_z > 0 &&
    structural_cradle_lip_bottom_z > 0 &&
    full_cradle_lip_bottom_z > 0,
    "Cradle through-holes must leave the lower snap lips unobstructed"
);
assert(
    final_track_tip_margin >= 4.4,
    "The printable tip needs at least 4.4 mm beyond the final stop track"
);
assert(
    skadis_board_connector_count == 2 &&
    !skadis_lower_pad_is_connector,
    "The SKÅDIS back must have exactly two printed board hooks"
);
assert(
    multiboard_attachment_point_count == 2 &&
    !multiboard_hardware_included &&
    multiboard_attachment_hardware ==
        "external_m4_compatible_multiboard_hardware",
    "Multiboard must expose two points for external M4-compatible hardware"
);
assert(
    num_racket_positions == 10 &&
    !ten_racket_load_verified &&
    load_rating_status == "physical_validation_required",
    "Ten modelled positions must not imply a verified ten-racket load rating"
);
assert(
    full_body_print_bounds[0] <= print_bed_xy[0] &&
    full_body_print_bounds[1] <= print_bed_xy[1] &&
    full_cradle_bounds[0] <= print_bed_xy[0] &&
    full_cradle_bounds[1] <= print_bed_xy[1],
    "The full body and one-piece cradle must fit a 256 x 256 mm bed"
);
assert(
    mode_is_printable("full_body_sections") &&
    mode_is_printable("full_rack_collars") &&
    mode_is_printable("full_rack_cradle"),
    "The complete v2.4 rack package must expose printable export modes"
);

echo(str(
    "V2_4_MODE: ", selected_render_mode,
    "; status: ", prototype_release_status
));
echo(
    "TOLERANCE_MATRIX_DIAMETER_THROAT_ID",
    tolerance_matrix_records
);
echo("RACKET_CENTRES_Y", racket_centres);
echo("STRUCTURAL_CENTRES_Y", structural_centres);
echo(
    "STOP_POSES_THROAT_TAB_DEG",
    [
        [right_throat_pose_deg, right_stop_tab_angle],
        [midpoint_throat_pose_deg, midpoint_stop_tab_angle],
        [left_throat_pose_deg, left_stop_tab_angle]
    ]
);
echo(
    "DETENT_ENDPOINT_MISMATCH_MM",
    [
        right_detent_centre_mismatch,
        left_detent_centre_mismatch
    ]
);
echo(
    "MATRIX_CRADLE_HOLE_CENTRES_X_Y",
    matrix_cradle_hole_centres
);
echo(
    "STRUCTURAL_CRADLE_HOLE_CENTRES_X_Y",
    structural_cradle_hole_centres
);
echo(
    "SKADIS_HOOK_POSITIONS_X_Z",
    [for (x = skadis_hook_x) [x, skadis_hook_z]]
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
echo(
    "FULL_SECTION_LABEL_RANGE_Y",
    full_cradle_pocket_records
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

// Rounded rectangle in X/Y, extruded along positive Z.
module rounded_prism_z(
    width,
    depth,
    height,
    radius,
    x0 = 0,
    y0 = 0,
    z0 = 0
) {
    safe_r = min(radius, min(width, depth) / 2);
    hull() {
        for (x = [
            x0 - width / 2 + safe_r,
            x0 + width / 2 - safe_r
        ])
            for (y = [
                y0 - depth / 2 + safe_r,
                y0 + depth / 2 - safe_r
            ])
                translate([x, y, z0])
                    cylinder(
                        r = safe_r,
                        h = height,
                        $fn = round_fn
                    );
    }
}

module annular_sector(
    inner_r,
    outer_r,
    height,
    start_angle,
    sweep_angle
) {
    rotate([0, 0, start_angle])
        rotate_extrude(
            angle = sweep_angle,
            convexity = 10,
            $fn = round_fn * 2
        )
            translate([inner_r, 0, 0])
                square([outer_r - inner_r, height]);
}

module debossed_text(
    label,
    x,
    y,
    z_top,
    size = 2.5,
    depth = 0.55,
    rotation = 0
) {
    translate([x, y, z_top - depth])
        rotate([0, 0, rotation])
            linear_extrude(height = depth + 0.2)
                text(
                    label,
                    size = size,
                    halign = "center",
                    valign = "center"
                );
}

module embossed_text(
    label,
    x,
    y,
    z0,
    size = 2.4,
    height = 0.5,
    rotation = 0
) {
    translate([x, y, z0])
        rotate([0, 0, rotation])
            linear_extrude(height = height)
                text(
                    label,
                    size = size,
                    halign = "center",
                    valign = "center"
                );
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

module root_flare() {
    hull() {
        rounded_prism_y(
            root_flare_w,
            0.6,
            arm_h,
            arm_corner_r,
            root_start_y,
            arm_z0
        );
        rounded_prism_y(
            arm_w,
            0.6,
            arm_h,
            arm_corner_r,
            root_transition_y - 0.6,
            arm_z0
        );
    }
}

module arm_blank(projection) {
    rounded_prism_y(
        arm_w,
        projection - root_transition_y,
        arm_h,
        arm_corner_r,
        root_transition_y,
        arm_z0
    );
}

module stop_track_void(
    centre_y,
    z0 = arm_z0,
    height = arm_h
) {
    track_z0 =
        z0 + height - body_top_recess_depth - track_depth;

    translate([0, centre_y, track_z0])
        // The void follows the full tab envelope. Its two radial end faces
        // are the hard stops for tab-centre poses 90 and 270 degrees. A
        // direct sector avoids leaving isolated stop-land slivers in the
        // fixed body.
        annular_sector(
            track_inner_r,
            track_outer_r,
            track_depth + 0.2,
            track_tab_envelope_start_angle,
            track_tab_envelope_sweep_deg
        );

    // The single radial collar bump has the same polar centre as each pocket
    // at the two hard stops. The mismatch is analytically zero.
    for (a = [
        track_start_angle,
        track_end_angle
    ])
        translate([
            cos(a) * detent_centre_r,
            centre_y +
                sin(a) * detent_centre_r,
            track_z0 + track_depth / 2
        ])
            cylinder(
                r = detent_pocket_r,
                h = track_depth + 0.4,
                center = true,
                $fn = round_fn
            );
}

module socket_indicator_voids(
    centre_y,
    z_top
) {
    debossed_text(
        "L",
        -11.7,
        centre_y + 6.3,
        z_top,
        2.6,
        0.5
    );
    debossed_text(
        "R",
        11.7,
        centre_y + 6.3,
        z_top,
        2.6,
        0.5
    );
}

module collar_socket_void(
    centre_y,
    cavity_d,
    z0 = arm_z0,
    height = arm_h,
    indicators = true
) {
    translate([0, centre_y, z0 - 0.2])
        cylinder(
            d = cavity_d,
            h = height + 0.4,
            $fn = round_fn
        );

    translate([
        -arm_w / 2 - 0.2,
        centre_y - fixed_corridor_w / 2,
        z0 - 0.2
    ])
        cube([
            arm_w + 0.4,
            fixed_corridor_w,
            height + 0.4
        ]);

    translate([
        0,
        centre_y,
        z0 + height - body_top_recess_depth
    ])
        cylinder(
            d = body_top_recess_d,
            h = body_top_recess_depth + 0.3,
            $fn = round_fn
        );

    stop_track_void(centre_y, z0, height);

    if (indicators)
        socket_indicator_voids(centre_y, z0 + height);
}

module rotating_body(
    centres,
    cavity_ds,
    projection,
    include_interface = true,
    indicators = true
) {
    assert(
        len(centres) == len(cavity_ds),
        "Each collar centre needs one cavity diameter"
    );

    difference() {
        union() {
            if (include_interface)
                body_heel_and_interface();
            if (include_interface)
                root_flare();
            arm_blank(projection);
        }

        for (i = [0 : len(centres) - 1])
            collar_socket_void(
                centres[i],
                cavity_ds[i],
                arm_z0,
                arm_h,
                indicators
            );
    }
}

module structural_coupon_body_assembled() {
    rotating_body(
        structural_centres,
        [for (i = [0 : len(structural_centres) - 1])
            nominal_cavity_d],
        structural_projection,
        true,
        true
    );
}

module structural_coupon_body_print() {
    translate([0, 0, -arm_z0])
        structural_coupon_body_assembled();
}

module full_body_section_label_voids() {
    debossed_text(
        full_section_labels[0],
        0,
        4,
        arm_z0 + arm_h,
        2.5,
        0.5
    );

    for (i = [1 : len(full_section_ranges) - 1])
        debossed_text(
            full_section_labels[i],
            -11.6,
            (
                full_section_ranges[i][0] +
                full_section_ranges[i][1]
            ) / 2,
            arm_z0 + arm_h,
            2.1,
            0.5,
            90
        );
}

module full_body_sections_assembled() {
    difference() {
        rotating_body(
            racket_centres,
            [
                for (i = [0 : len(racket_centres) - 1])
                    nominal_cavity_d
            ],
            full_projection,
            true,
            true
        );
        full_body_section_label_voids();
    }
}

module full_body_sections_print() {
    translate([0, 0, -arm_z0])
        full_body_sections_assembled();
}

module concept_full_body_assembled() {
    full_body_sections_assembled();
}

module collar_throat_profile(throat_w, max_outer_r) {
    // Closing the combined bore/corridor profile rounds the two concave
    // C-roots without creating isolated fins or narrowing the lead throat.
    offset(delta = -collar_flex_root_r)
        offset(r = collar_flex_root_r)
            union() {
                circle(d = collar_bore_d, $fn = round_fn);
                polygon(points = [
                    [0, -throat_w / 2],
                    [
                        max_outer_r - throat_lead_length,
                        -throat_w / 2
                    ],
                    [
                        max_outer_r + 0.8,
                        -(throat_w + throat_lead_extra) / 2
                    ],
                    [
                        max_outer_r + 0.8,
                        (throat_w + throat_lead_extra) / 2
                    ],
                    [
                        max_outer_r - throat_lead_length,
                        throat_w / 2
                    ],
                    [0, throat_w / 2]
                ]);
            }
}

module collar_throat_void(throat_w) {
    max_outer_r =
        max(
            collar_flange_d / 2,
            collar_lip_od(max_cavity_d) / 2
        );

    translate([0, 0, lip_bottom_z - 0.3])
        linear_extrude(
            height = arm_h - lip_bottom_z + 0.8
        )
            collar_throat_profile(throat_w, max_outer_r);
}

module collar_stop_tab() {
    rotate([0, 0, stop_tab_base_angle]) {
        hull() {
            translate([
                stop_tab_inner_r,
                -stop_tab_w / 2,
                stop_tab_z0
            ])
                cube([
                    0.5,
                    stop_tab_w,
                    stop_tab_h
                ]);
            translate([
                stop_tab_outer_r - 0.45,
                -stop_tab_w / 2,
                stop_tab_z0
            ])
                cube([
                    0.45,
                    stop_tab_w,
                    stop_tab_h
                ]);
        }

        // One radial bump rides the outer track wall with 0.18 mm nominal
        // interference, then relaxes into a coincident endpoint pocket.
        translate([
            detent_centre_r,
            0,
            stop_tab_z0
        ])
            cylinder(
                r = detent_r,
                h = stop_tab_h,
                $fn = round_fn
            );
    }
}

module collar_outer(cavity_d) {
    lip_od = collar_lip_od(cavity_d);
    lip_radial_growth =
        (lip_od - collar_barrel_d) / 2;
    lip_full_z =
        lip_bottom_z + lip_radial_growth;

    union() {
        translate([0, 0, 0])
            cylinder(
                d = collar_barrel_d,
                h = collar_capture_span,
                $fn = round_fn
            );

        translate([0, 0, collar_capture_span])
            cylinder(
                d = collar_flange_d,
                h = collar_flange_h,
                $fn = round_fn
            );

        // C-shaped snap lip: the 45-degree lower ramp flexes through the
        // cavity and the 0.3 mm radial shoulder retains from below.
        translate([0, 0, lip_bottom_z])
            cylinder(
                d1 = collar_barrel_d,
                d2 = lip_od,
                h = lip_radial_growth,
                $fn = round_fn
            );
        translate([0, 0, lip_full_z])
            cylinder(
                d = lip_od,
                h = -lip_full_z,
                $fn = round_fn
            );

        collar_stop_tab();
    }
}

module collar_tool_and_indicator_voids() {
    // Tool slot is recessed into the solid arc opposite the C opening.
    translate([
        -6.2,
        -tool_slot_w / 2,
        arm_h - tool_slot_depth
    ])
        cube([
            tool_slot_l,
            tool_slot_w,
            tool_slot_depth + 0.3
        ]);

    // A shallow arrow on the same solid arc points towards the open side.
    translate([0, 0, arm_h - indicator_depth])
        linear_extrude(height = indicator_depth + 0.3)
            polygon(points = [
                [-7.2, 1.7],
                [-4.2, 1.7],
                [-4.2, 0.9],
                [-2.8, 2.1],
                [-4.2, 3.3],
                [-4.2, 2.5],
                [-7.2, 2.5]
            ]);
}

module rotating_collar_assembled(
    cavity_d = nominal_cavity_d,
    throat_w = nominal_throat_w
) {
    difference() {
        collar_outer(cavity_d);
        collar_throat_void(throat_w);
        collar_tool_and_indicator_voids();
    }
}

module print_label_tag(label) {
    tag_centre_x =
        -(
            collar_flange_d / 2 +
            1.8 +
            label_tag_w / 2
        );

    union() {
        rounded_prism_z(
            label_tag_w,
            label_tag_d,
            label_tag_h,
            1.2,
            tag_centre_x,
            0,
            0
        );
        translate([
            -collar_flange_d / 2 - 2.0,
            -label_bridge_w / 2,
            0
        ])
            cube([
                2.2,
                label_bridge_w,
                label_bridge_h
            ]);
        embossed_text(
            label,
            tag_centre_x,
            0,
            label_tag_h,
            2.35,
            0.5
        );
    }
}

module rotating_collar_print(
    cavity_d = nominal_cavity_d,
    throat_w = nominal_throat_w,
    label = ""
) {
    union() {
        translate([0, 0, arm_h])
            rotate([180, 0, 0])
                rotating_collar_assembled(
                    cavity_d,
                    throat_w
                );

        if (label != "")
            print_label_tag(label);
    }
}

module matrix_socket_cell(record) {
    cavity_d = record[0];
    throat_w = record[1];
    id = record[2];

    difference() {
        rounded_prism_y(
            matrix_cell_w,
            matrix_cell_d,
            arm_h,
            arm_corner_r,
            -matrix_cell_d / 2,
            0
        );
        collar_socket_void(
            0,
            cavity_d,
            0,
            arm_h,
            true
        );
        debossed_text(
            matrix_half_label(record, "S"),
            0,
            -16,
            arm_h,
            2.5,
            0.6
        );
        debossed_text(
            str(cavity_d, "/", throat_w),
            0,
            -12,
            arm_h,
            1.9,
            0.5
        );
        debossed_text(
            matrix_half_label(record, "N"),
            0,
            16,
            arm_h,
            2.5,
            0.6
        );
        debossed_text(
            str(cavity_d, "/", throat_w),
            0,
            12,
            arm_h,
            1.9,
            0.5
        );
    }
}

module tolerance_matrix_fixture() {
    for (i = [0 : len(tolerance_matrix_records) - 1])
        translate([matrix_x(i), matrix_y(i), 0])
            matrix_socket_cell(tolerance_matrix_records[i]);
}

module tolerance_matrix_collars() {
    for (i = [0 : len(tolerance_matrix_records) - 1]) {
        record = tolerance_matrix_records[i];
        translate([
            (i % 3 - 1) * collar_plate_x_pitch,
            (floor(i / 3) - 1) * collar_plate_y_pitch,
            0
        ])
            rotating_collar_print(
                record[0],
                record[1],
                str(record[2], " ", record[0], "/", record[1])
            );
    }
}

module matrix_cradle_pocket_void(x, y) {
    rounded_prism_z(
        matrix_cell_w +
            2 * matrix_cradle_pocket_clearance,
        matrix_half_depth +
            2 * matrix_cradle_pocket_clearance,
        matrix_cradle_pocket_depth + 0.3,
        arm_corner_r +
            matrix_cradle_pocket_clearance,
        x,
        y,
        matrix_cradle_floor_z
    );
}

module tolerance_matrix_cradle() {
    difference() {
        rounded_prism_z(
            matrix_cradle_w,
            matrix_cradle_d,
            matrix_cradle_t,
            matrix_cradle_corner_r,
            0,
            0,
            0
        );

        for (centre = matrix_cradle_pocket_centres)
            matrix_cradle_pocket_void(
                centre[0],
                centre[1]
            );

        for (centre = matrix_cradle_hole_centres)
            translate([
                centre[0],
                centre[1],
                -0.2
            ])
                cylinder(
                    d = matrix_cradle_hole_d,
                    h = matrix_cradle_t + 0.4,
                    $fn = round_fn
                );

        for (i = [0 : len(tolerance_matrix_records) - 1])
            debossed_text(
                tolerance_matrix_records[i][2],
                matrix_x(i),
                matrix_y(i) - 22,
                matrix_cradle_t,
                2.6,
                0.55
            );
    }
}

module structural_coupon_collars() {
    for (i = [0 : len(throat_widths) - 1])
        translate([0, (i - 1) * 30, 0])
            rotating_collar_print(
                nominal_cavity_d,
                throat_widths[i],
                str("S", throat_widths[i])
            );
}

module full_rack_collars() {
    for (i = [0 : len(collar_labels) - 1])
        translate([
            (i % 5 - 2) * full_collar_x_pitch,
            (floor(i / 5) - 0.5) *
                full_collar_y_pitch,
            0
        ])
            rotating_collar_print(
                nominal_cavity_d,
                nominal_throat_w,
                collar_labels[i]
            );
}

module structural_root_pocket_void() {
    pocket_height =
        structural_cradle_pocket_depth + 0.3;
    pocket_z0 = structural_cradle_floor_z;
    clearance = structural_cradle_pocket_clearance;

    union() {
        rounded_prism_z(
            heel_w + 2 * clearance,
            heel_t + 2 * clearance,
            pocket_height,
            heel_corner_r + clearance,
            0,
            heel_t / 2,
            pocket_z0
        );

        hull() {
            rounded_prism_z(
                root_flare_w + 2 * clearance,
                0.8,
                pocket_height,
                arm_corner_r + clearance,
                0,
                root_start_y + 0.4,
                pocket_z0
            );
            rounded_prism_z(
                arm_w + 2 * clearance,
                0.8,
                pocket_height,
                arm_corner_r + clearance,
                0,
                root_transition_y,
                pocket_z0
            );
        }

        rounded_prism_z(
            arm_w + 2 * clearance,
            structural_section_ranges[0][1] -
                root_transition_y +
                2 * clearance,
            pocket_height,
            arm_corner_r + clearance,
            0,
            (
                root_transition_y +
                structural_section_ranges[0][1]
            ) / 2,
            pocket_z0
        );
    }
}

module structural_arm_section_pocket_void(range) {
    clearance = structural_cradle_pocket_clearance;
    rounded_prism_z(
        arm_w + 2 * clearance,
        range[1] - range[0] + 2 * clearance,
        structural_cradle_pocket_depth + 0.3,
        arm_corner_r + clearance,
        0,
        (range[0] + range[1]) / 2,
        structural_cradle_floor_z
    );
}

module structural_coupon_cradle() {
    cradle_centre_y =
        structural_cradle_y0 +
        structural_cradle_d / 2;

    difference() {
        rounded_prism_z(
            structural_cradle_w,
            structural_cradle_d,
            structural_cradle_t,
            structural_cradle_corner_r,
            0,
            cradle_centre_y,
            0
        );

        structural_root_pocket_void();
        for (i = [1 : len(structural_section_ranges) - 1])
            structural_arm_section_pocket_void(
                structural_section_ranges[i]
            );

        for (centre = structural_cradle_hole_centres)
            translate([
                centre[0],
                centre[1],
                -0.2
            ])
                cylinder(
                    d = structural_cradle_hole_d,
                    h = structural_cradle_t + 0.4,
                    $fn = round_fn
                );

        for (record = structural_cradle_pocket_records)
            debossed_text(
                record[0],
                -31,
                (record[1][0] + record[1][1]) / 2,
                structural_cradle_t,
                2.4,
                0.55,
                90
            );
    }
}

module full_root_pocket_void() {
    pocket_height =
        full_cradle_pocket_depth + 0.3;
    pocket_z0 = full_cradle_floor_z;
    clearance = full_cradle_pocket_clearance;

    union() {
        rounded_prism_z(
            heel_w + 2 * clearance,
            heel_t + 2 * clearance,
            pocket_height,
            heel_corner_r + clearance,
            0,
            heel_t / 2,
            pocket_z0
        );

        hull() {
            rounded_prism_z(
                root_flare_w + 2 * clearance,
                0.8,
                pocket_height,
                arm_corner_r + clearance,
                0,
                root_start_y + 0.4,
                pocket_z0
            );
            rounded_prism_z(
                arm_w + 2 * clearance,
                0.8,
                pocket_height,
                arm_corner_r + clearance,
                0,
                root_transition_y,
                pocket_z0
            );
        }

        rounded_prism_z(
            arm_w + 2 * clearance,
            full_section_ranges[0][1] -
                root_transition_y +
                2 * clearance,
            pocket_height,
            arm_corner_r + clearance,
            0,
            (
                root_transition_y +
                full_section_ranges[0][1]
            ) / 2,
            pocket_z0
        );
    }
}

module full_arm_section_pocket_void(range) {
    clearance = full_cradle_pocket_clearance;
    rounded_prism_z(
        arm_w + 2 * clearance,
        range[1] - range[0] + 2 * clearance,
        full_cradle_pocket_depth + 0.3,
        arm_corner_r + clearance,
        0,
        (range[0] + range[1]) / 2,
        full_cradle_floor_z
    );
}

module full_rack_cradle() {
    cradle_centre_y =
        full_cradle_y0 + full_cradle_d / 2;

    difference() {
        rounded_prism_z(
            full_cradle_w,
            full_cradle_d,
            full_cradle_t,
            full_cradle_corner_r,
            0,
            cradle_centre_y,
            0
        );

        full_root_pocket_void();
        for (i = [1 : len(full_section_ranges) - 1])
            full_arm_section_pocket_void(
                full_section_ranges[i]
            );

        for (centre = full_cradle_hole_centres)
            translate([
                centre[0],
                centre[1],
                -0.2
            ])
                cylinder(
                    d = full_cradle_hole_d,
                    h = full_cradle_t + 0.4,
                    $fn = round_fn
                );

        debossed_text(
            "ROOT",
            0,
            -3.5,
            full_cradle_t,
            2.4,
            0.55
        );

        for (i = [1 : len(full_cradle_pocket_records) - 1]) {
            record = full_cradle_pocket_records[i];
            debossed_text(
                record[0],
                -27,
                (record[1][0] + record[1][1]) / 2,
                full_cradle_t,
                2.2,
                0.55,
                90
            );
        }

        for (i = [0 : len(racket_centres) - 1])
            debossed_text(
                collar_labels[i],
                27,
                racket_centres[i],
                full_cradle_t,
                2.4,
                0.55
            );
    }
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

module skadis_lower_compression_pad(x, z, plate_t) {
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
        skadis_lower_compression_pad(
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

module preview_racket_shafts() {
    for (i = [0 : len(racket_centres) - 1])
        color(
            i % 2 == 0
                ? [0.16, 0.17, 0.18]
                : [0.28, 0.29, 0.30]
        )
            translate([
                0,
                racket_centres[i],
                -8
            ])
                cylinder(
                    d = nominal_shaft_d,
                    h = 78,
                    $fn = round_fn
                );
}

module assembled_full_rack(
    back_kind = "skadis",
    show_shafts = true
) {
    color([0.34, 0.35, 0.37])
        if (back_kind == "skadis")
            skadis_back_assembled();
        else
            multiboard_back_assembled();

    color([0.78, 0.79, 0.76])
        full_body_sections_assembled();

    for (i = [0 : len(racket_centres) - 1])
        color(
            preview_collar_angles[i] == 0
                ? [0.94, 0.38, 0.08]
                : [0.98, 0.68, 0.10]
        )
            translate([
                0,
                racket_centres[i],
                arm_z0
            ])
                rotate([
                    0,
                    0,
                    preview_collar_angles[i]
                ])
                    rotating_collar_assembled(
                        nominal_cavity_d,
                        nominal_throat_w
                    );

    if (show_shafts)
        preview_racket_shafts();
}

module assembled_concept(back_kind = "skadis") {
    assembled_full_rack(back_kind, true);
}

module tolerance_matrix_cradle_assembly() {
    color([0.28, 0.30, 0.31])
        tolerance_matrix_cradle();

    color([0.74, 0.75, 0.72])
        translate([0, 0, matrix_cradle_floor_z])
            tolerance_matrix_fixture();

    for (i = [0 : len(tolerance_matrix_records) - 1]) {
        record = tolerance_matrix_records[i];
        color(
            i % 2 == 0
                ? [0.94, 0.38, 0.08]
                : [0.98, 0.68, 0.10]
        )
            translate([
                matrix_x(i),
                matrix_y(i),
                matrix_cradle_floor_z
            ])
                rotate([0, 0, i % 2 == 0 ? 0 : 180])
                    rotating_collar_assembled(
                        record[0],
                        record[1]
                    );
    }
}

module structural_cradle_assembly() {
    color([0.28, 0.30, 0.31])
        structural_coupon_cradle();

    color([0.74, 0.75, 0.72])
        translate([
            0,
            0,
            structural_cradle_floor_z - arm_z0
        ])
            structural_coupon_body_assembled();

    for (i = [0 : len(structural_centres) - 1])
        color(
            i % 2 == 0
                ? [0.94, 0.38, 0.08]
                : [0.98, 0.68, 0.10]
        )
            translate([
                0,
                structural_centres[i],
                structural_cradle_floor_z
            ])
                rotate([0, 0, i % 2 == 0 ? 0 : 180])
                    rotating_collar_assembled(
                        nominal_cavity_d,
                        throat_widths[i]
                    );
}

module preview_tolerance_matrix() {
    tolerance_matrix_cradle_assembly();
}

module preview_structural_coupon() {
    structural_cradle_assembly();
}

module preview_pose_caption(label, x) {
    color([0.18, 0.18, 0.16])
        translate([x, -24, arm_h + 0.5])
            linear_extrude(height = 0.6)
                text(
                    label,
                    size = 3.2,
                    halign = "center",
                    valign = "center"
                );
}

module preview_stop_poses() {
    pose_x = [-38, 0, 38];
    pose_angles = [
        right_throat_pose_deg,
        midpoint_throat_pose_deg,
        left_throat_pose_deg
    ];
    pose_labels = ["RIGHT 0", "MID 90", "LEFT 180"];

    for (i = [0 : 2]) {
        x = pose_x[i];
        throat_angle = pose_angles[i];
        detent_point =
            point_at(
                detent_centre_r,
                stop_tab_angle_for(throat_angle)
            );

        color([0.70, 0.72, 0.70, 0.28])
            translate([x, 0, 0])
                matrix_socket_cell(
                    [nominal_cavity_d, nominal_throat_w, "POSE"]
                );

        color(
            i == 0
                ? [0.94, 0.38, 0.08]
                : i == 1
                    ? [0.98, 0.68, 0.10]
                    : [0.82, 0.24, 0.10]
        )
            translate([x, 0, 0])
                rotate([0, 0, throat_angle])
                    rotating_collar_assembled(
                        nominal_cavity_d,
                        nominal_throat_w
                    );

        color([0.90, 0.10, 0.10])
            translate([
                x + detent_point[0],
                detent_point[1],
                stop_tab_z0 + stop_tab_h / 2
            ])
                sphere(r = 0.65, $fn = round_fn);

        preview_pose_caption(pose_labels[i], x);
    }
}

module full_cradle_assembly() {
    color([0.28, 0.30, 0.31])
        full_rack_cradle();

    color([0.74, 0.75, 0.72])
        translate([
            0,
            0,
            full_cradle_floor_z - arm_z0
        ])
            full_body_sections_assembled();

    for (i = [0 : len(racket_centres) - 1])
        color(
            i % 2 == 0
                ? [0.94, 0.38, 0.08]
                : [0.98, 0.68, 0.10]
        )
            translate([
                0,
                racket_centres[i],
                full_cradle_floor_z
            ])
                rotate([
                    0,
                    0,
                    preview_collar_angles[i]
                ])
                    rotating_collar_assembled(
                        nominal_cavity_d,
                        nominal_throat_w
                    );
}

module preview_collar_detail() {
    color([0.94, 0.38, 0.08])
        rotating_collar_assembled(
            nominal_cavity_d,
            nominal_throat_w
        );
    color([0.98, 0.68, 0.10])
        translate([26, 0, 0])
            rotate([0, 0, 180])
                rotating_collar_assembled(
                    nominal_cavity_d,
                    nominal_throat_w
                );
}

module preview_back_pair() {
    color([0.34, 0.35, 0.37])
        translate([-43, 0, 0])
            skadis_back_assembled();
    color([0.55, 0.56, 0.53])
        translate([43, 0, 0])
            multiboard_back_assembled();
}

module preview_complete_skadis() {
    assembled_full_rack("skadis", true);
}

module preview_complete_multiboard() {
    assembled_full_rack("multiboard", true);
}

module preview_skadis_rear() {
    color([0.42, 0.43, 0.41])
        modular_back_core();

    for (x = skadis_hook_x)
        color([0.94, 0.38, 0.08])
            skadis_load_hook(
                x,
                skadis_hook_z,
                back_t
            );

    for (x = skadis_lower_pad_x)
        color([0.26, 0.27, 0.26])
            skadis_lower_compression_pad(
                x,
                skadis_lower_pad_z,
                back_t
            );
}

module multiboard_rear_annotation(
    label,
    z,
    size = 2.5
) {
    color([0.96, 0.96, 0.93])
        translate([0, -back_t - 0.25, z])
            rotate([90, 0, 0])
                linear_extrude(height = 0.55)
                    text(
                        label,
                        size = size,
                        halign = "center",
                        valign = "center"
                    );
}

module preview_multiboard_rear() {
    color([0.42, 0.43, 0.41])
        multiboard_back_assembled();

    multiboard_rear_annotation(
        "EXTERNAL M4",
        53
    );
    multiboard_rear_annotation(
        "ATTACHMENT POINT",
        49,
        2.3
    );
    multiboard_rear_annotation(
        "50 mm PITCH",
        36,
        2.8
    );
    multiboard_rear_annotation(
        "EXTERNAL M4",
        23
    );
    multiboard_rear_annotation(
        "ATTACHMENT POINT",
        19,
        2.3
    );
}

module operation_socket_block() {
    difference() {
        rounded_prism_y(
            arm_w,
            40,
            arm_h,
            arm_corner_r,
            -20,
            0
        );
        collar_socket_void(
            0,
            nominal_cavity_d,
            0,
            arm_h,
            true
        );
    }
}

module operation_caption(label, x) {
    color([0.16, 0.16, 0.15])
        translate([x, -26, arm_h + 0.5])
            linear_extrude(height = 0.6)
                text(
                    label,
                    size = 3,
                    halign = "center",
                    valign = "center"
                );
}

module preview_bilateral_operation() {
    cell_x = [-24, 24];
    throat_angles = [0, 180];
    labels = ["RIGHT INSERT", "LEFT INSERT"];

    for (i = [0 : 1]) {
        x = cell_x[i];
        angle = throat_angles[i];
        approach_x =
            x + (angle == 0 ? 15 : -15);

        color([0.74, 0.75, 0.72, 0.72])
            translate([x, 0, 0])
                operation_socket_block();

        color(
            i == 0
                ? [0.94, 0.38, 0.08]
                : [0.98, 0.68, 0.10]
        )
            translate([x, 0, 0])
                rotate([0, 0, angle])
                    rotating_collar_assembled(
                        nominal_cavity_d,
                        nominal_throat_w
                    );

        color([0.16, 0.17, 0.18])
            translate([approach_x, 0, -3])
                cylinder(
                    d = nominal_shaft_d,
                    h = arm_h + 9,
                    $fn = round_fn
                );

        color([0.16, 0.17, 0.18, 0.25])
            translate([x, 0, -3])
                cylinder(
                    d = nominal_shaft_d,
                    h = arm_h + 9,
                    $fn = round_fn
                );

        operation_caption(labels[i], x);
    }
}

module preview_full_cradle_assembly() {
    full_cradle_assembly();
}

if (selected_render_mode == "full_body_sections")
    full_body_sections_print();
else if (selected_render_mode == "full_rack_collars")
    full_rack_collars();
else if (selected_render_mode == "full_rack_cradle")
    full_rack_cradle();
else if (selected_render_mode == "tolerance_matrix_fixture")
    tolerance_matrix_fixture();
else if (selected_render_mode == "tolerance_matrix_collars")
    tolerance_matrix_collars();
else if (selected_render_mode == "tolerance_matrix_cradle")
    tolerance_matrix_cradle();
else if (selected_render_mode == "structural_coupon_body")
    structural_coupon_body_print();
else if (selected_render_mode == "structural_coupon_collars")
    structural_coupon_collars();
else if (selected_render_mode == "structural_coupon_cradle")
    structural_coupon_cradle();
else if (selected_render_mode == "skadis_back")
    skadis_back_print();
else if (selected_render_mode == "multiboard_back")
    multiboard_back_print();
else if (selected_render_mode == "skadis_fit_coupon")
    skadis_fit_coupon_print();
else if (selected_render_mode == "multiboard_fit_coupon")
    multiboard_fit_coupon_print();
else if (selected_render_mode == "preview_tolerance_matrix")
    preview_tolerance_matrix();
else if (selected_render_mode == "preview_structural_coupon")
    preview_structural_coupon();
else if (selected_render_mode == "preview_stop_poses")
    preview_stop_poses();
else if (selected_render_mode == "preview_collar_detail")
    preview_collar_detail();
else if (selected_render_mode == "preview_back_pair")
    preview_back_pair();
else if (selected_render_mode == "preview_complete_skadis")
    preview_complete_skadis();
else if (selected_render_mode == "preview_complete_multiboard")
    preview_complete_multiboard();
else if (selected_render_mode == "preview_skadis_rear")
    preview_skadis_rear();
else if (selected_render_mode == "preview_multiboard_rear")
    preview_multiboard_rear();
else if (selected_render_mode == "preview_bilateral_operation")
    preview_bilateral_operation();
else if (selected_render_mode == "preview_full_cradle_assembly")
    preview_full_cradle_assembly();
else if (selected_render_mode == "preview_concept_skadis")
    assembled_concept("skadis");
else if (selected_render_mode == "preview_concept_multiboard")
    assembled_concept("multiboard");
else if (selected_render_mode == "none") {
    // Test mode deliberately emits no source geometry.
}
else
    assert(
        false,
        str("Unknown v2.4 prototype render mode: ",
            selected_render_mode)
    );
