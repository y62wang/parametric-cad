// v2.7 dual-board screwless slide-lock badminton racket rack prototype.
//
// The proven v2.6 connected body, twin dovetails and underside anti-lift clip
// are retained. Separate 72 x 72 x 10 mm backs provide either two printed
// IKEA SKADIS hooks or two independent parameterised Multiboard split catches.
// Multiboard dimensions are design assumptions and require physical coupons.
//
// All dimensions are millimetres.

default_render_mode = "preview_assembled_skadis_clean";
render_mode = default_render_mode;
selected_render_mode = render_mode;

prototype_version = "2.7";
prototype_release_status =
    "dual_board_screwless_parameterised_prototype_not_released";
supported_board_types = ["skadis", "multiboard"];
threaded_fastener_hole_count = 0;
thermal_insert_pocket_count = 0;
metal_fastener_count = 0;
counterbored_hole_count = 0;
production_board_through_hole_count = 0;
one_piece_body_export_supported = true;
ten_racket_load_verified = false;
load_rating_claimed = false;
load_rating_status = "physical_validation_required";
print_bed_xy = [256, 256];

/* [Shared compact back] */
back_w = 72;
back_h = 72;
back_t = 10;
back_corner_r = 4;

/* [SKADIS: documented/community compatibility measurements] */
selected_skadis_hook_w = 4.2;
selected_skadis_board_t = 3.0;
selected_skadis_board_clearance = 0.4;
selected_skadis_capture_depth =
    selected_skadis_board_t +
    selected_skadis_board_clearance;
skadis_board_t = selected_skadis_board_t;
skadis_board_clearance = selected_skadis_board_clearance;
skadis_standoff = 0.8;
skadis_hook_x = [-20, 20];
skadis_hook_z = 58;
skadis_board_connector_positions = [
    for (x = skadis_hook_x)
        [x, skadis_hook_z]
];
skadis_board_connector_count =
    len(skadis_board_connector_positions);
skadis_hook_horizontal_pitch =
    skadis_hook_x[1] - skadis_hook_x[0];
skadis_hook_w = selected_skadis_hook_w;
skadis_slot_entering_width = skadis_hook_w;
skadis_hook_depth = 2.8;
skadis_hook_tongue_h = 12;
skadis_hook_neck_h = 4;
skadis_proxy_slot_w = 5.2;
skadis_proxy_slot_h = 15.2;
skadis_proxy_slot_radius = skadis_proxy_slot_w / 2;
skadis_neck_slot_clearance_h = 0.15;
skadis_neck_transition_profile =
    "width_aware_chamfer_to_rounded_slot";
function skadis_neck_seating_chamfer_height(hook_w) =
    skadis_proxy_slot_radius -
    sqrt(max(
        0,
        skadis_proxy_slot_radius *
            skadis_proxy_slot_radius -
        hook_w * hook_w / 4
    )) +
    skadis_neck_slot_clearance_h;
skadis_neck_seating_chamfer_h =
    skadis_neck_seating_chamfer_height(
        skadis_hook_w
    );
skadis_tongue_chamfer = 0.6;
skadis_tongue_neck_overlap = 0.2;
skadis_hook_root_fillet_r = 1.2;
skadis_hook_root_fillet_enters_slot = false;
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
skadis_seating_vertical_clearance = 0.4;
skadis_insertion_slot_z = skadis_hook_z;
skadis_downward_seating_travel =
    skadis_proxy_slot_h -
    skadis_proxy_slot_w -
    skadis_seating_vertical_clearance;
skadis_seated_slot_z =
    skadis_insertion_slot_z +
    skadis_downward_seating_travel;
skadis_proxy_board_w = 96;
skadis_proxy_board_z0 = -12;
skadis_proxy_board_z1 = 92;
skadis_proxy_board_h =
    skadis_proxy_board_z1 - skadis_proxy_board_z0;
skadis_proxy_board_component_count = 1;
skadis_board_contact_plane_y =
    -back_t - skadis_standoff;
skadis_lower_pad_contact_plane_y =
    skadis_board_contact_plane_y;
skadis_lower_pads_share_board_plane = true;

/* [Multiboard: independent parameterised design assumptions] */
multiboard_interface_status =
    "parameterised_unreleased_physical_coupon_required";
multiboard_official_profile_used = false;
multiboard_copied_snap_mesh_used = false;
multiboard_connector_x = [0];
multiboard_connector_z = [11, 61];
multiboard_connector_positions = [
    for (z = multiboard_connector_z)
        [multiboard_connector_x[0], z]
];
multiboard_connector_count =
    len(multiboard_connector_positions);
multiboard_cell_pitch = 25;
multiboard_vertical_pitch =
    multiboard_connector_z[1] -
    multiboard_connector_z[0];
multiboard_standoff = 0.8;
selected_multiboard_catch_span = 7.60;
selected_multiboard_board_t = 6.0;
selected_multiboard_shoulder_depth =
    selected_multiboard_board_t + 0.35;
selected_multiboard_rear_clearance =
    9.0 - selected_multiboard_board_t;
multiboard_board_t_assumed =
    selected_multiboard_board_t;
multiboard_board_rear_clearance =
    selected_multiboard_rear_clearance;
multiboard_proxy_hole_d = 7.2;
multiboard_core_d = 6.6;
multiboard_catch_span =
    selected_multiboard_catch_span;
multiboard_lead_in_tip_d = 5.8;
multiboard_profile_kind = "transverse_kite";
multiboard_transverse_kite_profile_retained = true;
multiboard_core_vertical_span = 6.6;
multiboard_catch_vertical_span = 6.6;
multiboard_tip_vertical_span = 5.8;
multiboard_core_lower_face_angle_deg =
    atan(
        (
            multiboard_core_vertical_span / 2 +
            (
                multiboard_core_d -
                multiboard_core_vertical_span
            ) / 2
        ) /
        (multiboard_core_d / 2)
    );
multiboard_catch_lower_face_angle_deg =
    atan(
        (
            multiboard_catch_vertical_span / 2 +
            (
                multiboard_catch_span -
                multiboard_catch_vertical_span
            ) / 2
        ) /
        (multiboard_catch_span / 2)
    );
multiboard_tip_lower_face_angle_deg =
    atan(
        (
            multiboard_tip_vertical_span / 2 +
            (
                multiboard_lead_in_tip_d -
                multiboard_tip_vertical_span
            ) / 2
        ) /
        (multiboard_lead_in_tip_d / 2)
    );
multiboard_min_lower_face_angle_deg =
    min(
        multiboard_core_lower_face_angle_deg,
        multiboard_catch_lower_face_angle_deg,
        multiboard_tip_lower_face_angle_deg
    );
multiboard_split_w = 1.2;
multiboard_unsplit_root_web = 1.5;
multiboard_flex_length = 7.0;
multiboard_projection = 8.5;
multiboard_retention_shoulder_behind_board = 0.35;
multiboard_retention_shoulder_depth =
    selected_multiboard_shoulder_depth;
multiboard_shoulder_ramp_length = 0.30;
multiboard_shoulder_ramp_start =
    multiboard_retention_shoulder_depth -
    multiboard_shoulder_ramp_length;
multiboard_positive_retention = true;
multiboard_friction_ribs_only = false;
multiboard_split_crack_stop_d = 1.8;
multiboard_split_has_rounded_crack_stop = true;
multiboard_root_fillet_r = 2.0;
multiboard_root_profile_span =
    multiboard_core_d + 2 * multiboard_root_fillet_r;
multiboard_root_transition_preserves_transverse_kite = true;
multiboard_horizontal_underside_removed = true;
multiboard_plug_to_pad_overlap = 0.60;
multiboard_bearing_pad_positions =
    multiboard_connector_positions;
multiboard_bearing_pad_count =
    len(multiboard_bearing_pad_positions);
multiboard_bearing_pad_is_connector = false;
multiboard_bearing_pad_outer_w = 42;
multiboard_bearing_pad_h = 16;
multiboard_bearing_centre_gap = 6;
multiboard_bearing_land_w =
    (multiboard_bearing_pad_outer_w -
     multiboard_bearing_centre_gap) / 2;
multiboard_bearing_land_count =
    2 * multiboard_bearing_pad_count;
multiboard_axial_underside_support_required = true;
multiboard_support_required = true;
multiboard_support_strategy =
    "painted_organic_axial_undersides_only";
multiboard_support_type = "organic_tree";
multiboard_support_build_plate_only = true;
multiboard_support_interface_gap = 0.20;
multiboard_support_xy_gap = 0.35;
multiboard_support_interface_layers = 2;
multiboard_support_density_percent = 12;
multiboard_support_regions_per_full_back =
    multiboard_connector_count;
multiboard_support_avoids_split = true;
multiboard_support_avoids_shoulder_side_faces = true;

/* [Twin downward dovetails: unchanged from v2.6] */
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

/* [Connected body: unchanged from v2.6] */
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

/* [Racket fit and alternating zigzag: unchanged from v2.6] */
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

/* [Replaceable underside anti-lift clip: unchanged from v2.6] */
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

skadis_width_coupon_hook_widths = [4.0, 4.2, 4.4];
skadis_width_coupon_board_t = skadis_board_t;
skadis_width_coupon_clearance = skadis_board_clearance;
skadis_width_coupon_capture_depth =
    skadis_width_coupon_board_t +
    skadis_width_coupon_clearance;
skadis_capture_coupon_hook_widths = [
    skadis_hook_w,
    skadis_hook_w,
    skadis_hook_w,
    skadis_hook_w
];
skadis_capture_coupon_board_thicknesses =
    [2.6, 3.0, 4.0, 5.0];
skadis_capture_coupon_clearances =
    [0.4, 0.4, 0.4, 0.4];
skadis_capture_coupon_capture_depths = [
    for (i = [
        0 :
        len(skadis_capture_coupon_board_thicknesses) - 1
    ])
        skadis_capture_coupon_board_thicknesses[i] +
        skadis_capture_coupon_clearances[i]
];
skadis_tolerance_coupon_plate_w = 24;
skadis_tolerance_coupon_plate_h = 24;
skadis_tolerance_coupon_plate_t = 4;
skadis_pattern_coupon_connector_count = 2;
skadis_pattern_coupon_pitch = 40;

multiboard_coupon_catch_spans = [7.35, 7.60, 7.85];
multiboard_coupon_max_span =
    max(multiboard_coupon_catch_spans);
multiboard_max_production_catch_span = 7.85;
multiboard_coupon_proxy_hole_count = 3;
multiboard_coupon_section_window_count = 3;
multiboard_retention_coupon_board_thicknesses =
    [5.0, 6.0, 7.0];
multiboard_retention_coupon_shoulder_depths =
    [5.35, 6.35, 7.35];
multiboard_retention_coupon_rear_clearances =
    [4.0, 3.0, 2.0];
multiboard_retention_coupon_catch_spans =
    [7.60, 7.60, 7.60];
multiboard_retention_coupon_shoulder_offsets = [
    for (i = [
        0 :
        len(multiboard_retention_coupon_board_thicknesses) -
        1
    ])
        multiboard_retention_coupon_shoulder_depths[i] -
        multiboard_retention_coupon_board_thicknesses[i]
];
multiboard_retention_coupon_seating_margins = [
    for (i = [
        0 :
        len(multiboard_retention_coupon_board_thicknesses) -
        1
    ])
        multiboard_retention_coupon_rear_clearances[i] -
        (
            multiboard_projection -
            multiboard_retention_coupon_board_thicknesses[i]
        )
];
multiboard_retention_coupon_proxy_hole_count = 3;
multiboard_retention_coupon_section_window_count = 3;
multiboard_coupon_male_plate_w = 22;
multiboard_coupon_male_plate_h = 18;
multiboard_coupon_male_plate_t = 4;
multiboard_coupon_proxy_w = 22;
multiboard_coupon_proxy_h = 18;
multiboard_coupon_sample_pitch = 50;
multiboard_pattern_coupon_connector_count = 2;
multiboard_pattern_coupon_pitch = 50;
multiboard_pattern_coupon_w = 48;

three_pocket_coupon_centres = [23, 44, 65];
three_pocket_coupon_openings = ["left", "right", "left"];
three_pocket_coupon_projection = 70;

/* [Ready-to-print full-back selection matrix] */
skadis_production_hook_widths = [4.0, 4.2, 4.4];
skadis_production_board_thicknesses =
    [2.6, 3.0, 4.0, 5.0];
skadis_production_clearance = 0.4;
skadis_production_neck_chamfer_heights = [
    for (hook_w = skadis_production_hook_widths)
        skadis_neck_seating_chamfer_height(hook_w)
];
skadis_production_full_width_neck_heights = [
    for (chamfer_h =
        skadis_production_neck_chamfer_heights)
        skadis_hook_neck_h - chamfer_h
];
skadis_production_capture_depths = [
    for (board_t = skadis_production_board_thicknesses)
        board_t + skadis_production_clearance
];
skadis_production_variants = [
    for (hook_w = skadis_production_hook_widths)
        for (board_t = skadis_production_board_thicknesses)
            [
                hook_w,
                board_t,
                skadis_production_clearance,
                board_t + skadis_production_clearance
            ]
];
skadis_production_variant_count =
    len(skadis_production_variants);

multiboard_production_catch_spans =
    [7.35, 7.60, 7.85];
multiboard_production_board_thicknesses =
    [5.0, 6.0, 7.0];
multiboard_production_shoulder_depths = [
    for (board_t =
        multiboard_production_board_thicknesses)
        board_t +
            multiboard_retention_shoulder_behind_board
];
multiboard_production_rear_clearances = [
    for (board_t =
        multiboard_production_board_thicknesses)
        9.0 - board_t
];
multiboard_production_variants = [
    for (catch_span =
        multiboard_production_catch_spans)
        for (board_t =
            multiboard_production_board_thicknesses)
            [
                catch_span,
                board_t,
                board_t +
                    multiboard_retention_shoulder_behind_board,
                9.0 - board_t
            ]
];
multiboard_production_variant_count =
    len(multiboard_production_variants);

v2_7_shared_export_count = 11;
v2_7_skadis_back_export_count =
    skadis_production_variant_count;
v2_7_multiboard_back_export_count =
    multiboard_production_variant_count;
v2_7_export_recipe_count =
    v2_7_shared_export_count +
    v2_7_skadis_back_export_count +
    v2_7_multiboard_back_export_count;

/* [Rendering] */
round_fn = 48;
preview_body_colour = [0.92, 0.45, 0.10];
preview_back_colour = [0.92, 0.45, 0.10];
preview_clip_colour = [0.92, 0.45, 0.10];
preview_proxy_colour = [0.28, 0.58, 0.86, 0.28];
preview_section_colour = [0.62, 0.72, 0.82, 0.55];
default_preview_racket_shaft_count = 0;
default_preview_arrow_count = 0;
default_preview_explanatory_solid_count = 0;
default_preview_has_opaque_board = false;
default_preview_is_exploded = false;
default_preview_model_rotation_z = -25;
preview_multiboard_section_axis = "Y";
preview_multiboard_section_proxy_component_count = 1;
preview_multiboard_section_has_positive_shoulder = true;
preview_multiboard_section_has_rear_clearance_frame = true;
preview_print_skadis_translation = [104, 0, 0];
preview_print_multiboard_translation = [220, 64, 0];
preview_print_clip_translation = [112, 72, 0];
preview_print_back_separation_x =
    (
        preview_print_multiboard_translation[0] -
        back_w / 2
    ) -
    (
        preview_print_skadis_translation[0] +
        back_h
    );

/* [Print transform and recommendation] */
multiboard_part_depth =
    back_t + multiboard_standoff + multiboard_projection;
multiboard_back_print_rotation = [0, 0, 0];
multiboard_back_print_translation = [0, 0, 0];
multiboard_male_coupon_print_rotation = [0, 0, 0];
multiboard_male_coupon_print_translation = [0, 0, 0];
multiboard_print_bed_axes = ["X", "Y"];
multiboard_catch_axis = "Y";
multiboard_split_flex_axis = "X";
multiboard_original_z0_bed_contact = true;
recommended_back_brim_w = 6.0;

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
skadis_hook_edge_margin =
    min(
        back_w / 2 -
            (abs(skadis_hook_x[1]) + skadis_hook_w / 2),
        skadis_hook_z - skadis_hook_tongue_h / 2,
        back_h -
            (skadis_hook_z + skadis_hook_tongue_h / 2)
    );
skadis_lower_pad_edge_margin =
    min(
        back_w / 2 -
            (abs(skadis_lower_pad_x[1]) +
             skadis_lower_pad_w / 2),
        skadis_lower_pad_z - skadis_lower_pad_h / 2
    );
multiboard_insertion_travel =
    multiboard_retention_shoulder_depth;
multiboard_lead_in_length =
    multiboard_projection -
    multiboard_retention_shoulder_depth;
multiboard_core_radial_clearance =
    (multiboard_proxy_hole_d - multiboard_core_d) / 2;
multiboard_nominal_catch_compression_per_side =
    (multiboard_catch_span - multiboard_proxy_hole_d) / 2;
multiboard_retention_shoulder_per_side =
    (multiboard_catch_span - multiboard_core_d) / 2;
multiboard_plug_to_pad_radial_overlap =
    (multiboard_core_d -
     multiboard_bearing_centre_gap) / 2;
multiboard_tip_beyond_board =
    multiboard_projection - multiboard_board_t_assumed;
multiboard_seating_margin =
    multiboard_board_rear_clearance -
    multiboard_tip_beyond_board;
multiboard_pad_side_edge_margin =
    back_w / 2 - multiboard_bearing_pad_outer_w / 2;
multiboard_pad_vertical_edge_margin =
    min(
        multiboard_connector_z[0] -
            multiboard_bearing_pad_h / 2,
        back_h -
            (multiboard_connector_z[1] +
             multiboard_bearing_pad_h / 2)
    );
multiboard_connector_vertical_edge_margin =
    min(
        multiboard_connector_z[0] -
            multiboard_catch_span / 2,
        back_h -
            (multiboard_connector_z[1] +
             multiboard_catch_span / 2)
    );

audit_tip_mass_kg = 3.0;
audit_gravity_m_s2 = 9.81;
audit_tip_lever_m = full_projection / 1000;
audit_tip_moment_nm =
    audit_tip_mass_kg *
    audit_gravity_m_s2 *
    audit_tip_lever_m;
audit_multiboard_couple_reaction_n =
    audit_tip_moment_nm /
    (multiboard_vertical_pitch / 1000);
audit_skadis_effective_reaction_spacing_m = 0.040;
audit_skadis_vertical_reaction_n =
    audit_tip_moment_nm /
    audit_skadis_effective_reaction_spacing_m;
audit_is_load_rating = false;

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

function value_is_selected(values, selected) =
    len([
        for (value = values)
            if (value == selected) value
    ]) == 1;

function printable_modes() = [
    "body_start_left",
    "body_start_right",
    "skadis_back",
    "multiboard_back",
    "anti_lift_clip",
    "dovetail_tolerance_coupon",
    "skadis_hook_width_coupon",
    "skadis_board_capture_coupon",
    "skadis_two_hook_pattern_coupon",
    "multiboard_catch_tolerance_coupon",
    "multiboard_retention_depth_coupon",
    "multiboard_two_catch_pattern_coupon",
    "three_pocket_racket_coupon"
];

function preview_modes() = [
    "preview_assembled_skadis_clean",
    "preview_skadis_rear_two_hooks",
    "preview_skadis_engagement_transparent",
    "preview_assembled_multiboard_clean",
    "preview_multiboard_rear_two_catches",
    "preview_multiboard_proxy_section",
    "preview_exploded_slide_lock",
    "preview_centred_ten_position_sawtooth",
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
        : mode == "skadis_hook_width_coupon"
            ? 3
            : mode == "skadis_board_capture_coupon"
                ? 4
            : mode == "multiboard_catch_tolerance_coupon"
                ? 6
                : mode == "multiboard_retention_depth_coupon"
                    ? 6
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
    threaded_fastener_hole_count == 0 &&
    thermal_insert_pocket_count == 0 &&
    metal_fastener_count == 0 &&
    production_board_through_hole_count == 0,
    "v2.7 production parts must be screwless and all-printed"
);
assert(
    skadis_board_connector_count == 2 &&
    multiboard_connector_count == 2 &&
    !skadis_lower_pad_is_connector &&
    !multiboard_bearing_pad_is_connector,
    "Each back needs exactly two connectors; pads remain supports"
);
assert(
    rail_centres_x == [-20, 20] &&
    rail_engagement == 36 &&
    male_rail_projection == 6 &&
    nominal_female_depth == 6.4,
    "The reviewed v2.6 twin-rail interface changed"
);
assert(
    multiboard_positive_retention &&
    multiboard_seating_margin > 0 &&
    multiboard_plug_to_pad_overlap > 0,
    "Multiboard catches need positive retention and seating margin"
);
assert(
    value_is_selected(
        skadis_production_hook_widths,
        selected_skadis_hook_w
    ) &&
    value_is_selected(
        skadis_production_board_thicknesses,
        selected_skadis_board_t
    ) &&
    selected_skadis_board_clearance ==
        skadis_production_clearance,
    "Selected SKADIS parameters must match a packaged full-back recipe"
);
assert(
    value_is_selected(
        multiboard_production_catch_spans,
        selected_multiboard_catch_span
    ) &&
    value_is_selected(
        multiboard_production_board_thicknesses,
        selected_multiboard_board_t
    ) &&
    selected_multiboard_shoulder_depth ==
        selected_multiboard_board_t +
            multiboard_retention_shoulder_behind_board &&
    selected_multiboard_rear_clearance ==
        9.0 - selected_multiboard_board_t,
    "Selected Multiboard parameters must match a packaged full-back recipe"
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
    mode_is_supported(selected_render_mode),
    str("Unknown v2.7 render mode: ", selected_render_mode)
);

echo(str(
    "V2_7_MODE: ", selected_render_mode,
    "; status: ", prototype_release_status
));
echo("SKADIS_HOOK_POSITIONS_X_Z",
    skadis_board_connector_positions);
echo("MULTIBOARD_CATCH_POSITIONS_X_Z",
    multiboard_connector_positions);
echo("DOVETAIL_RAIL_CENTRES_X", rail_centres_x);
echo("RACKET_CENTRES_Y", racket_centres);
echo(
    "MULTIBOARD_ASSUMPTIONS_MM",
    [
        ["proxy_hole", multiboard_proxy_hole_d],
        ["board_thickness", multiboard_board_t_assumed],
        ["rear_clearance", multiboard_board_rear_clearance],
        ["core", multiboard_core_d],
        ["catch", multiboard_catch_span],
        ["seating_margin", multiboard_seating_margin]
    ]
);
echo(
    "V2_7_SELECTED_EXPORT_PARAMETERS_MM",
    [
        [
            "skadis_hook_width",
            selected_skadis_hook_w
        ],
        [
            "skadis_board_thickness",
            selected_skadis_board_t
        ],
        [
            "skadis_board_clearance",
            selected_skadis_board_clearance
        ],
        [
            "skadis_capture_depth",
            selected_skadis_capture_depth
        ],
        [
            "skadis_neck_chamfer_height",
            skadis_neck_seating_chamfer_h
        ],
        [
            "multiboard_catch_span",
            selected_multiboard_catch_span
        ],
        [
            "multiboard_board_thickness",
            selected_multiboard_board_t
        ],
        [
            "multiboard_shoulder_depth",
            selected_multiboard_shoulder_depth
        ],
        [
            "multiboard_rear_clearance",
            selected_multiboard_rear_clearance
        ]
    ]
);
echo(
    "LOAD_AUDIT_NOT_RATING",
    [
        ["tip_mass_kg", audit_tip_mass_kg],
        ["tip_moment_nm", audit_tip_moment_nm],
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
    plate_t,
    standoff = skadis_standoff
) {
    translate([x, 0, 0])
        rounded_prism_y(
            width,
            standoff + 0.2,
            height,
            min(2.5, height / 3),
            -plate_t - standoff,
            z - height / 2
        );
}

module skadis_chamfered_tongue(
    x,
    tongue_y0,
    tongue_front_y,
    tongue_z0,
    hook_w = skadis_hook_w
) {
    lead_depth = 0.2;
    chamfer = skadis_tongue_chamfer;

    hull() {
        translate([
            x - hook_w / 2 + chamfer,
            tongue_y0,
            tongue_z0 + chamfer
        ])
            cube([
                hook_w - 2 * chamfer,
                lead_depth,
                skadis_hook_tongue_h - 2 * chamfer
            ]);
        translate([
            x - hook_w / 2,
            tongue_y0 + chamfer,
            tongue_z0
        ])
            cube([
                hook_w,
                tongue_front_y -
                    tongue_y0 -
                    chamfer +
                    skadis_tongue_neck_overlap,
                skadis_hook_tongue_h
            ]);
    }
}

module skadis_hook_root_fillets(
    x,
    plate_t,
    board_front_y,
    neck_z0,
    hook_w
) {
    fillet_seed_r = 0.18;
    plate_root_y = -plate_t + 0.05;
    neck_side_y =
        board_front_y + fillet_seed_r + 0.02;

    for (direction = [-1, 1])
        hull() {
            translate([
                x - hook_w / 2,
                neck_side_y,
                neck_z0 +
                    (direction > 0
                        ? skadis_hook_neck_h
                        : 0)
            ])
                rotate([0, 90, 0])
                    cylinder(
                        r = fillet_seed_r,
                        h = hook_w,
                        $fn = 20
                    );
            translate([
                x - hook_w / 2,
                plate_root_y,
                neck_z0 +
                    (direction > 0
                        ? skadis_hook_neck_h +
                          skadis_hook_root_fillet_r
                        : -skadis_hook_root_fillet_r)
            ])
                rotate([0, 90, 0])
                    cylinder(
                        r = fillet_seed_r,
                        h = hook_w,
                        $fn = 20
                    );
        }
}

module skadis_seated_neck(
    x,
    tongue_front_y,
    neck_front_y,
    neck_z0,
    hook_w
) {
    neck_depth = neck_front_y - tongue_front_y;
    neck_chamfer_h =
        skadis_neck_seating_chamfer_height(hook_w);

    translate([x, neck_front_y, neck_z0])
        rotate([90, 0, 0])
            linear_extrude(height = neck_depth)
                polygon([
                    [0, 0],
                    [
                        hook_w / 2,
                        neck_chamfer_h
                    ],
                    [
                        hook_w / 2,
                        skadis_hook_neck_h
                    ],
                    [
                        -hook_w / 2,
                        skadis_hook_neck_h
                    ],
                    [
                        -hook_w / 2,
                        neck_chamfer_h
                    ]
                ]);
}

module skadis_load_hook(
    x,
    z,
    plate_t,
    hook_w = skadis_hook_w,
    board_t = skadis_board_t,
    board_clearance = skadis_board_clearance,
    standoff = skadis_standoff
) {
    board_front_y = -plate_t - standoff;
    board_rear_y = board_front_y - board_t;
    tongue_front_y =
        board_rear_y - board_clearance;
    tongue_y0 = tongue_front_y - skadis_hook_depth;
    tongue_z0 = z - skadis_hook_tongue_h / 2;
    neck_z0 =
        tongue_z0 +
        skadis_hook_tongue_h -
        skadis_hook_neck_h;
    neck_front_y = -plate_t + 0.2;

    skadis_contact_pad(
        x,
        z,
        skadis_upper_pad_w,
        skadis_upper_pad_h,
        plate_t,
        standoff
    );

    skadis_seated_neck(
        x,
        tongue_front_y,
        neck_front_y,
        neck_z0,
        hook_w
    );

    skadis_hook_root_fillets(
        x,
        plate_t,
        board_front_y,
        neck_z0,
        hook_w
    );

    skadis_chamfered_tongue(
        x,
        tongue_y0,
        tongue_front_y,
        tongue_z0,
        hook_w
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

module skadis_connector_set(
    plate_t,
    hook_w = skadis_hook_w,
    board_t = skadis_board_t,
    board_clearance = skadis_board_clearance
) {
    for (x = skadis_hook_x)
        skadis_load_hook(
            x,
            skadis_hook_z,
            plate_t,
            hook_w,
            board_t,
            board_clearance
        );

    for (x = skadis_lower_pad_x)
        skadis_lower_bearing_pad(
            x,
            skadis_lower_pad_z,
            plate_t
        );
}

module screwless_skadis_back_assembled(
    hook_w = skadis_hook_w,
    board_t = skadis_board_t,
    board_clearance = skadis_board_clearance
) {
    union() {
        back_plate();
        twin_dovetail_rails();
        skadis_connector_set(
            back_t,
            hook_w,
            board_t,
            board_clearance
        );
    }
}

function skadis_part_depth(
    plate_t,
    board_t = skadis_board_t,
    board_clearance = skadis_board_clearance
) =
    plate_t +
    skadis_standoff +
    board_t +
    board_clearance +
    skadis_hook_depth;

module screwless_skadis_back_print(
    hook_w = skadis_hook_w,
    board_t = skadis_board_t,
    board_clearance = skadis_board_clearance
) {
    translate([
        back_h,
        skadis_part_depth(
            back_t,
            board_t,
            board_clearance
        ),
        back_w / 2
    ])
        rotate([0, -90, 0])
            screwless_skadis_back_assembled(
                hook_w,
                board_t,
                board_clearance
            );
}

module multiboard_section_profile_2d(
    horizontal_span,
    vertical_span = multiboard_core_d
) {
    side_z =
        (horizontal_span - vertical_span) / 2;

    polygon([
        [0, -vertical_span / 2],
        [horizontal_span / 2, side_z],
        [0, vertical_span / 2],
        [-horizontal_span / 2, side_z]
    ]);
}

module multiboard_axial_slice(
    depth,
    horizontal_span,
    vertical_span = multiboard_core_d,
    thickness = 0.04
) {
    translate([0, 0, depth - thickness / 2])
        linear_extrude(height = thickness)
            multiboard_section_profile_2d(
                horizontal_span,
                vertical_span
            );
}

module multiboard_root_fillet_local() {
    hull() {
        multiboard_axial_slice(
            -multiboard_root_fillet_r,
            multiboard_root_profile_span,
            multiboard_root_profile_span
        );
        multiboard_axial_slice(
            -multiboard_root_fillet_r / 2,
            multiboard_core_d +
                multiboard_root_fillet_r,
            multiboard_core_vertical_span +
                multiboard_root_fillet_r
        );
    }

    hull() {
        multiboard_axial_slice(
            -multiboard_root_fillet_r / 2,
            multiboard_core_d +
                multiboard_root_fillet_r,
            multiboard_core_vertical_span +
                multiboard_root_fillet_r
        );
        multiboard_axial_slice(
            0,
            multiboard_core_d,
            multiboard_core_vertical_span
        );
    }
}

module multiboard_split_catch_local(
    catch_span = multiboard_catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth
) {
    shoulder_ramp_start =
        shoulder_depth -
        multiboard_shoulder_ramp_length;
    crack_stop_centre_depth =
        multiboard_unsplit_root_web +
        multiboard_split_crack_stop_d / 2;

    difference() {
        union() {
            multiboard_root_fillet_local();

            translate([
                0,
                0,
                -multiboard_plug_to_pad_overlap
            ])
                linear_extrude(
                    height =
                        shoulder_ramp_start +
                        multiboard_plug_to_pad_overlap
                )
                    multiboard_section_profile_2d(
                        multiboard_core_d,
                        multiboard_core_vertical_span
                    );

            hull() {
                multiboard_axial_slice(
                    shoulder_ramp_start,
                    multiboard_core_d,
                    multiboard_core_vertical_span
                );
                multiboard_axial_slice(
                    shoulder_depth,
                    catch_span,
                    multiboard_catch_vertical_span
                );
            }

            hull() {
                multiboard_axial_slice(
                    shoulder_depth,
                    catch_span,
                    multiboard_catch_vertical_span
                );
                multiboard_axial_slice(
                    multiboard_projection,
                    multiboard_lead_in_tip_d,
                    multiboard_tip_vertical_span
                );
            }
        }

        translate([
            -multiboard_split_w / 2,
            -catch_span,
            crack_stop_centre_depth
        ])
            cube([
                multiboard_split_w,
                2 * catch_span,
                multiboard_projection -
                    crack_stop_centre_depth +
                    0.2
            ]);

        translate([
            0,
            0,
            crack_stop_centre_depth
        ])
            rotate([90, 0, 0])
                cylinder(
                    d = multiboard_split_crack_stop_d,
                    h = 2 * catch_span,
                    center = true,
                    $fn = 32
                );
    }
}

module multiboard_split_catch(
    x,
    z,
    plate_t,
    catch_span = multiboard_catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth
) {
    board_front_y =
        -plate_t - multiboard_standoff;

    translate([x, board_front_y, z])
        rotate([90, 0, 0])
            multiboard_split_catch_local(
                catch_span,
                shoulder_depth
            );
}

module multiboard_core_envelope(
    x,
    z,
    plate_t
) {
    board_front_y =
        -plate_t - multiboard_standoff;

    translate([x, board_front_y, z])
        rotate([90, 0, 0])
            linear_extrude(
                height = multiboard_board_t_assumed
            )
                multiboard_section_profile_2d(
                    multiboard_core_d,
                    multiboard_core_vertical_span
                );
}

module multiboard_bearing_land(
    x,
    z,
    plate_t,
    side
) {
    centre_offset =
        multiboard_bearing_centre_gap / 2 +
        multiboard_bearing_land_w / 2;

    translate([
        x + side * centre_offset,
        0,
        0
    ])
        rounded_prism_y(
            multiboard_bearing_land_w,
            multiboard_standoff + 0.2,
            multiboard_bearing_pad_h,
            3,
            -plate_t - multiboard_standoff,
            z - multiboard_bearing_pad_h / 2
        );
}

module multiboard_bearing_pad(
    x,
    z,
    plate_t
) {
    for (side = [-1, 1])
        multiboard_bearing_land(
            x,
            z,
            plate_t,
            side
        );
}

module multiboard_connector_set(
    plate_t,
    catch_span = multiboard_catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth
) {
    for (position = multiboard_connector_positions) {
        multiboard_bearing_pad(
            position[0],
            position[1],
            plate_t
        );
        multiboard_split_catch(
            position[0],
            position[1],
            plate_t,
            catch_span,
            shoulder_depth
        );
    }
}

module screwless_multiboard_back_assembled(
    catch_span = multiboard_catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth
) {
    union() {
        back_plate();
        twin_dovetail_rails();
        multiboard_connector_set(
            back_t,
            catch_span,
            shoulder_depth
        );
    }
}

module screwless_multiboard_back_print(
    catch_span = multiboard_catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth
) {
    screwless_multiboard_back_assembled(
        catch_span,
        shoulder_depth
    );
}

module multiboard_board_proxy(
    x,
    z,
    width,
    height,
    plate_t = back_t,
    section_window = false,
    board_t = multiboard_board_t_assumed,
    proxy_hole_d = multiboard_proxy_hole_d
) {
    board_front_y =
        -plate_t - multiboard_standoff;
    board_rear_y =
        board_front_y -
        board_t;

    difference() {
        translate([x, 0, 0])
            rounded_prism_y(
                width,
                board_t,
                height,
                min(3, height / 4),
                board_rear_y,
                z - height / 2
            );

        translate([
            x,
            board_front_y + 0.2,
            z
        ])
            rotate([90, 0, 0])
                cylinder(
                    d = proxy_hole_d,
                    h =
                        board_t +
                        0.4,
                    $fn = round_fn
                );

        if (section_window)
            translate([
                x - 0.05,
                board_rear_y - 0.2,
                z - 0.60
            ])
                cube([
                    width / 2 + 0.35,
                    board_t + 0.4,
                    height / 2 + 0.80
                ]);
    }
}

module multiboard_rear_clearance_stop(
    x,
    z,
    plate_t = back_t,
    width = 14,
    height = 14,
    stop_t = 0.5,
    board_t = multiboard_board_t_assumed,
    rear_clearance =
        multiboard_board_rear_clearance
) {
    board_front_y =
        -plate_t - multiboard_standoff;
    stop_front_y =
        board_front_y -
        board_t -
        rear_clearance;

    translate([
        x - width / 2,
        stop_front_y - stop_t,
        z - height / 2
    ])
        cube([width, stop_t, height]);
}

module multiboard_section_proxy_fixture(
    x,
    z,
    width = 30,
    height = 26,
    plate_t = back_t
) {
    board_front_y =
        -plate_t - multiboard_standoff;
    board_rear_y =
        board_front_y -
        multiboard_board_t_assumed;
    clearance_rear_y =
        board_rear_y -
        multiboard_board_rear_clearance;
    frame_t = 2;
    axial_overlap = 0.2;

    union() {
        multiboard_board_proxy(
            x,
            z,
            width,
            height,
            plate_t,
            true
        );

        translate([
            x - width / 2,
            clearance_rear_y - axial_overlap,
            z - height / 2
        ])
            cube([
                width,
                multiboard_board_rear_clearance +
                    2 * axial_overlap,
                frame_t
            ]);

        translate([
            x - width / 2,
            clearance_rear_y - 0.6,
            z - height / 2
        ])
            cube([
                width,
                0.8,
                2 * frame_t
            ]);
    }
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

module skadis_two_hook_pattern_coupon_assembled() {
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

module skadis_two_hook_pattern_coupon_print() {
    translate([
        back_h,
        skadis_part_depth(fit_coupon_t),
        back_w / 2
    ])
        rotate([0, -90, 0])
            skadis_two_hook_pattern_coupon_assembled();
}

module skadis_single_fit_coupon_assembled(
    marker_count,
    hook_w,
    board_t,
    board_clearance
) {
    coupon_z =
        skadis_tolerance_coupon_plate_h / 2;

    union() {
        rounded_prism_y(
            skadis_tolerance_coupon_plate_w,
            skadis_tolerance_coupon_plate_t,
            skadis_tolerance_coupon_plate_h,
            3,
            -skadis_tolerance_coupon_plate_t,
            0
        );
        skadis_load_hook(
            0,
            coupon_z,
            skadis_tolerance_coupon_plate_t,
            hook_w,
            board_t,
            board_clearance
        );

        for (marker = [0 : marker_count - 1])
            translate([
                -4 + marker * 4,
                -0.4,
                2
            ])
                cube([2, 0.8, 5]);
    }
}

module skadis_single_fit_coupon_print(
    marker_count,
    hook_w,
    board_t,
    board_clearance
) {
    part_depth =
        skadis_tolerance_coupon_plate_t +
        skadis_standoff +
        board_t +
        board_clearance +
        skadis_hook_depth;

    translate([
        skadis_tolerance_coupon_plate_h,
        part_depth,
        skadis_tolerance_coupon_plate_w / 2
    ])
        rotate([0, -90, 0])
            skadis_single_fit_coupon_assembled(
                marker_count,
                hook_w,
                board_t,
                board_clearance
            );
}

module skadis_hook_width_coupon_print() {
    for (index = [
        0 : len(skadis_width_coupon_hook_widths) - 1
    ])
        translate([index * 30, 0, 0])
            skadis_single_fit_coupon_print(
                index + 1,
                skadis_width_coupon_hook_widths[index],
                skadis_width_coupon_board_t,
                skadis_width_coupon_clearance
            );
}

module skadis_board_capture_coupon_print() {
    for (index = [
        0 :
        len(skadis_capture_coupon_board_thicknesses) - 1
    ])
        translate([index * 30, 0, 0])
            skadis_single_fit_coupon_print(
                index + 1,
                skadis_capture_coupon_hook_widths[index],
                skadis_capture_coupon_board_thicknesses[index],
                skadis_capture_coupon_clearances[index]
            );
}

module multiboard_pattern_coupon_assembled() {
    union() {
        rounded_prism_y(
            multiboard_pattern_coupon_w,
            fit_coupon_t,
            back_h,
            3,
            -fit_coupon_t,
            0
        );
        multiboard_connector_set(fit_coupon_t);
    }
}

module multiboard_two_catch_pattern_coupon_print() {
    multiboard_pattern_coupon_assembled();
}

module multiboard_single_catch_coupon_assembled(
    catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth,
    marker_count = 1
) {
    coupon_z =
        multiboard_coupon_male_plate_h / 2;

    union() {
        rounded_prism_y(
            multiboard_coupon_male_plate_w,
            multiboard_coupon_male_plate_t,
            multiboard_coupon_male_plate_h,
            3,
            -multiboard_coupon_male_plate_t,
            0
        );
        multiboard_split_catch(
            0,
            coupon_z,
            multiboard_coupon_male_plate_t,
            catch_span,
            shoulder_depth
        );
        multiboard_bearing_pad(
            0,
            coupon_z,
            multiboard_coupon_male_plate_t
        );

        for (marker = [0 : marker_count - 1])
            translate([
                -5 + marker * 4,
                -0.4,
                2
            ])
                cube([2, 0.8, 5]);
    }
}

module multiboard_single_catch_coupon_print(
    catch_span,
    shoulder_depth =
        multiboard_retention_shoulder_depth,
    marker_count = 1
) {
    multiboard_single_catch_coupon_assembled(
        catch_span,
        shoulder_depth,
        marker_count
    );
}

module rounded_rectangle_2d(
    width,
    height,
    radius
) {
    offset(r = radius)
        square([
            width - 2 * radius,
            height - 2 * radius
        ], center = true);
}

module multiboard_coupon_proxy_print(
    marker_count,
    board_t = multiboard_board_t_assumed
) {
    difference() {
        linear_extrude(
            height = board_t
        )
            difference() {
                rounded_rectangle_2d(
                    multiboard_coupon_proxy_w,
                    multiboard_coupon_proxy_h,
                    3
                );
                circle(
                    d = multiboard_proxy_hole_d,
                    $fn = round_fn
                );
            }

        translate([
            0,
            -multiboard_proxy_hole_d / 4,
            board_t / 2
        ])
            cube([
                multiboard_coupon_proxy_w / 2 +
                    0.3,
                multiboard_proxy_hole_d / 2,
                board_t / 2 +
                    0.2
            ]);
    }

    for (marker = [0 : marker_count - 1])
        translate([
            -5 + marker * 4,
            -multiboard_coupon_proxy_h / 2 + 0.4,
            0
        ])
            cube([2, 1.2, 2]);
}

module multiboard_catch_tolerance_coupon_print() {
    for (index = [
        0 : len(multiboard_coupon_catch_spans) - 1
    ]) {
        translate([
            index * multiboard_coupon_sample_pitch,
            0,
            0
        ])
            multiboard_single_catch_coupon_print(
                multiboard_coupon_catch_spans[index],
                multiboard_retention_shoulder_depth,
                index + 1
            );

        translate([
            index * multiboard_coupon_sample_pitch +
                multiboard_coupon_proxy_w / 2,
            34,
            0
        ])
            multiboard_coupon_proxy_print(
                index + 1,
                multiboard_board_t_assumed
            );
    }
}

module multiboard_retention_depth_coupon_print() {
    for (index = [
        0 :
        len(multiboard_retention_coupon_board_thicknesses) -
        1
    ]) {
        translate([
            index * multiboard_coupon_sample_pitch,
            0,
            0
        ])
            multiboard_single_catch_coupon_print(
                multiboard_retention_coupon_catch_spans[index],
                multiboard_retention_coupon_shoulder_depths[index],
                index + 1
            );

        translate([
            index * multiboard_coupon_sample_pitch +
                multiboard_coupon_proxy_w / 2,
            34,
            0
        ])
            multiboard_coupon_proxy_print(
                index + 1,
                multiboard_retention_coupon_board_thicknesses[index]
            );
    }
}

module three_pocket_racket_coupon_assembled() {
    difference() {
        rounded_prism_y(
            arm_w,
            three_pocket_coupon_projection,
            arm_h,
            arm_corner_r,
            0,
            arm_z0
        );

        for (index = [0 : 2])
            racket_slot_void([
                0,
                three_pocket_coupon_centres[index],
                three_pocket_coupon_openings[index]
            ]);
    }
}

module three_pocket_racket_coupon_print() {
    translate([
        arm_w / 2,
        0,
        heel_top_z
    ])
        rotate([0, 180, 0])
            three_pocket_racket_coupon_assembled();
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

module skadis_proxy_slot(
    x,
    z,
    board_front_y,
    board_t = skadis_board_t
) {
    hull()
        for (slot_z = [
            z -
                (
                    skadis_proxy_slot_h -
                    skadis_proxy_slot_w
                ) / 2,
            z +
                (
                    skadis_proxy_slot_h -
                    skadis_proxy_slot_w
                ) / 2
        ])
            translate([
                x,
                board_front_y + 0.2,
                slot_z
            ])
                rotate([90, 0, 0])
                    cylinder(
                        d = skadis_proxy_slot_w,
                        h = board_t + 0.4,
                        $fn = round_fn
                    );
}

module skadis_board_proxy(
    board_t = skadis_board_t
) {
    board_front_y =
        -back_t - skadis_standoff;
    board_rear_y =
        board_front_y - board_t;

    difference() {
        rounded_prism_y(
            skadis_proxy_board_w,
            board_t,
            skadis_proxy_board_h,
            3,
            board_rear_y,
            skadis_proxy_board_z0
        );

        for (x = skadis_hook_x)
            skadis_proxy_slot(
                x,
                skadis_seated_slot_z,
                board_front_y,
                board_t
            );
    }
}

module preview_assembled_skadis_clean() {
    rotate([0, 0, default_preview_model_rotation_z])
        color(preview_body_colour) {
            screwless_skadis_back_assembled();
            connected_screwless_body(false);
            anti_lift_clip_assembled();
        }
}

module preview_skadis_rear_two_hooks() {
    rotate([0, 0, default_preview_model_rotation_z])
        color(preview_body_colour)
            screwless_skadis_back_assembled();
}

module preview_skadis_engagement_transparent() {
    rotate([0, 0, default_preview_model_rotation_z]) {
        color(preview_body_colour)
            screwless_skadis_back_assembled();
        color(preview_proxy_colour)
            skadis_board_proxy();
    }
}

module preview_assembled_multiboard_clean() {
    rotate([0, 0, default_preview_model_rotation_z])
        color(preview_body_colour) {
            screwless_multiboard_back_assembled();
            connected_screwless_body(false);
            anti_lift_clip_assembled();
        }
}

module preview_multiboard_rear_two_catches() {
    rotate([0, 0, default_preview_model_rotation_z])
        color(preview_body_colour)
            screwless_multiboard_back_assembled();
}

module preview_multiboard_proxy_section() {
    color(preview_body_colour)
        union() {
            rounded_prism_y(
                20,
                back_t,
                22,
                3,
                -back_t,
                -11
            );
            multiboard_split_catch(0, 0, back_t);
        }

    color([0.30, 0.64, 0.90, 0.52])
        multiboard_section_proxy_fixture(
            0,
            0,
            30,
            26,
            back_t
        );
}

module preview_exploded_slide_lock() {
    rotate([0, 0, default_preview_model_rotation_z]) {
        color(preview_back_colour)
            screwless_skadis_back_assembled();
        color(preview_body_colour)
            translate([0, 0, 55])
                connected_screwless_body(false);
        color(preview_clip_colour)
            translate([0, 0, -11])
                anti_lift_clip_assembled();
    }
}

module preview_centred_ten_position_sawtooth() {
    color(preview_body_colour)
        connected_screwless_body(false);
}

module preview_print_orientations() {
    color(preview_body_colour)
        connected_body_print(false);

    color(preview_back_colour)
        translate(preview_print_skadis_translation)
            screwless_skadis_back_print();

    color(preview_back_colour)
        translate(preview_print_multiboard_translation)
            screwless_multiboard_back_print();

    color(preview_clip_colour)
        translate(preview_print_clip_translation)
            anti_lift_clip_print();
}

if (selected_render_mode == "body_start_left")
    connected_body_print(false);
else if (selected_render_mode == "body_start_right")
    connected_body_print(true);
else if (selected_render_mode == "skadis_back")
    screwless_skadis_back_print();
else if (selected_render_mode == "multiboard_back")
    screwless_multiboard_back_print();
else if (selected_render_mode == "anti_lift_clip")
    anti_lift_clip_print();
else if (selected_render_mode ==
         "dovetail_tolerance_coupon")
    dovetail_tolerance_coupon_print();
else if (selected_render_mode ==
         "skadis_hook_width_coupon")
    skadis_hook_width_coupon_print();
else if (selected_render_mode ==
         "skadis_board_capture_coupon")
    skadis_board_capture_coupon_print();
else if (selected_render_mode ==
         "skadis_two_hook_pattern_coupon")
    skadis_two_hook_pattern_coupon_print();
else if (selected_render_mode ==
         "multiboard_catch_tolerance_coupon")
    multiboard_catch_tolerance_coupon_print();
else if (selected_render_mode ==
         "multiboard_retention_depth_coupon")
    multiboard_retention_depth_coupon_print();
else if (selected_render_mode ==
         "multiboard_two_catch_pattern_coupon")
    multiboard_two_catch_pattern_coupon_print();
else if (selected_render_mode ==
         "three_pocket_racket_coupon")
    three_pocket_racket_coupon_print();
else if (selected_render_mode ==
         "preview_assembled_skadis_clean")
    preview_assembled_skadis_clean();
else if (selected_render_mode ==
         "preview_skadis_rear_two_hooks")
    preview_skadis_rear_two_hooks();
else if (selected_render_mode ==
         "preview_skadis_engagement_transparent")
    preview_skadis_engagement_transparent();
else if (selected_render_mode ==
         "preview_assembled_multiboard_clean")
    preview_assembled_multiboard_clean();
else if (selected_render_mode ==
         "preview_multiboard_rear_two_catches")
    preview_multiboard_rear_two_catches();
else if (selected_render_mode ==
         "preview_multiboard_proxy_section")
    preview_multiboard_proxy_section();
else if (selected_render_mode ==
         "preview_exploded_slide_lock")
    preview_exploded_slide_lock();
else if (selected_render_mode ==
         "preview_centred_ten_position_sawtooth")
    preview_centred_ten_position_sawtooth();
else if (selected_render_mode ==
         "preview_print_orientations")
    preview_print_orientations();
else if (selected_render_mode == "none") {
    // Test mode deliberately emits no source geometry.
}
