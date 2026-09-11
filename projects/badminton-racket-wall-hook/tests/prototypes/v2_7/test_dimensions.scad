// Dimensional contract for the isolated v2.7 dual-board screwless prototype.
//
// Run from the project directory with:
// TERM=dumb NO_COLOR=1 openscad --hardwarnings \
//   -D 'render_mode="none"' \
//   -o /tmp/badminton_v2_7_dimensions.echo \
//   tests/prototypes/v2_7/test_dimensions.scad

include <../../../src/prototypes/v2_7_dual_board_screwless.scad>

function close_to(actual, expected, tolerance = 0.001) =
    abs(actual - expected) <= tolerance;

function pairwise_spacings(values) = [
    for (i = [0 : len(values) - 2])
        values[i + 1] - values[i]
];

function all_equal(values, expected) =
    len([for (value = values) if (value == expected) value]) ==
        len(values);

function count_equal(values, expected) =
    len([for (value = values) if (value == expected) value]);

assert(prototype_version == "2.7",
    str("Unexpected prototype version: ", prototype_version));
assert(
    prototype_release_status ==
        "dual_board_screwless_parameterised_prototype_not_released",
    "v2.7 must remain explicitly unreleased"
);
assert(supported_board_types == ["skadis", "multiboard"],
    str("Unexpected board variants: ", supported_board_types));
assert(
    threaded_fastener_hole_count == 0 &&
    thermal_insert_pocket_count == 0 &&
    metal_fastener_count == 0 &&
    counterbored_hole_count == 0 &&
    production_board_through_hole_count == 0,
    "Both production backs must be screwless and all-printed"
);
assert(!load_rating_claimed &&
       load_rating_status == "physical_validation_required",
    "The model must not claim a load rating");

// The v2.6 body, slide-lock and anti-lift dimensions are immutable.
assert(close_to(back_w, 72) &&
       close_to(back_h, 72) &&
       close_to(back_t, 10),
    "Both backs must remain 72 x 72 x 10 mm");
assert(rail_centres_x == [-20, 20] &&
       close_to(rail_z0, 18) &&
       close_to(rail_z1, 54) &&
       close_to(rail_engagement, 36),
    "The v2.6 twin rail positions or engagement changed");
assert(close_to(male_rail_projection, 6.0) &&
       close_to(male_rail_neck_w, 8.0) &&
       close_to(male_rail_crown_w, 12.0) &&
       close_to(rail_root_fillet_r, 2.0) &&
       close_to(rail_lead_in, 1.5),
    "The v2.6 male dovetail changed");
assert(close_to(nominal_female_mouth_w, 8.6) &&
       close_to(nominal_female_crown_w, 12.6) &&
       close_to(nominal_female_depth, 6.4) &&
       close_to(rail_side_clearance, 0.30) &&
       close_to(rail_depth_clearance, 0.40),
    "The v2.6 female dovetail changed");
assert(close_to(heel_w, 72) &&
       close_to(heel_t, 14) &&
       close_to(heel_front_wall, 7.6) &&
       close_to(root_flare_w, 52) &&
       close_to(arm_w, 28) &&
       close_to(arm_h, 36) &&
       close_to(full_projection, 221),
    "The v2.6 body envelope changed");
assert(close_to(anti_lift_service_gap, 8) &&
       close_to(anti_lift_clip_height, 8) &&
       close_to(anti_lift_bridge_t, 1.8) &&
       close_to(anti_lift_prong_split, 1.0) &&
       anti_lift_positive_retention &&
       anti_lift_role == "upward_retention_only" &&
       !anti_lift_carries_cantilever_load,
    "The v2.6 anti-lift clip changed");
assert(female_channels_open_bottom &&
       female_channels_closed_top &&
       assembly_direction == "downward" &&
       gravity_seats_interface,
    "The downward slide-lock behaviour changed");
assert(rail_surround_min >= 3 &&
       rail_outer_edge_margin >= 10 &&
       channel_outer_edge_margin >= 9.7,
    "The rail material or edge margin is too small");

// One connected ten-position alternating body, in both starting directions.
expected_centres = [
    23, 44, 65, 86, 107,
    128, 149, 170, 191, 212
];
expected_start_left = [
    "left", "right", "left", "right", "left",
    "right", "left", "right", "left", "right"
];
expected_start_right = [
    "right", "left", "right", "left", "right",
    "left", "right", "left", "right", "left"
];

assert(num_racket_positions == 10 &&
       racket_centres == expected_centres &&
       pairwise_spacings(racket_centres) ==
           [21, 21, 21, 21, 21, 21, 21, 21, 21],
    "The ten centred racket positions changed");
assert(all_equal(racket_axes_x, 0) &&
       opening_sides_for(false) == expected_start_left &&
       opening_sides_for(true) == expected_start_right &&
       count_equal(opening_sides_for(false), "left") == 5 &&
       count_equal(opening_sides_for(false), "right") == 5,
    "The alternating start-left/start-right sequences changed");
assert(close_to(pocket_d, 8.8) &&
       close_to(entry_gap, 6.6) &&
       close_to(opposite_side_ligament, 9.6) &&
       close_to(adjacent_pocket_web, 12.2),
    "The v2.6 pocket geometry changed");
assert(body_component_count == 1 &&
       loose_body_section_count == 0 &&
       collar_part_count == 0 &&
       cradle_part_count == 0,
    "Each rack body must remain one connected component");

// Exactly two printed SKADIS hooks and two non-entering lower pads.
assert(skadis_board_connector_positions ==
       [[-20, 58], [20, 58]] &&
       skadis_board_connector_count == 2 &&
       close_to(skadis_hook_horizontal_pitch, 40),
    "SKADIS requires exactly two hooks at 40 mm pitch");
assert(close_to(skadis_hook_w, 4.2) &&
       close_to(skadis_hook_tongue_h, 12) &&
       close_to(skadis_hook_neck_h, 4) &&
       close_to(skadis_hook_depth, 2.8) &&
       close_to(skadis_board_t, 3.0) &&
       close_to(skadis_board_clearance, 0.4) &&
       close_to(skadis_standoff, 0.8),
    "The production SKADIS hook contract changed");
assert(skadis_lower_pad_positions ==
       [[-20, 11], [20, 11]] &&
       skadis_lower_bearing_pad_count == 2 &&
       !skadis_lower_pad_is_connector,
    "SKADIS lower pads must remain supports, not connectors");
assert(skadis_hook_root_fillet_r >= 1.0 &&
       !skadis_hook_root_fillet_enters_slot &&
       close_to(skadis_slot_entering_width, skadis_hook_w),
    "SKADIS root strengthening must not widen the entering tongue");
assert(skadis_hook_edge_margin >= 8 &&
       skadis_lower_pad_edge_margin >= 3,
    "SKADIS connector or pad edge margin is too small");
assert(close_to(skadis_proxy_slot_w, 5.2) &&
       close_to(skadis_proxy_slot_h, 15.2) &&
       close_to(skadis_proxy_slot_radius, 2.6),
    "The seated SKADIS proxy must use the documented slot capsule");
assert(close_to(skadis_insertion_slot_z, skadis_hook_z) &&
       close_to(skadis_downward_seating_travel, 9.6) &&
       close_to(
           skadis_seated_slot_z,
           skadis_hook_z + skadis_downward_seating_travel
       ) &&
       close_to(skadis_seated_slot_z, 67.6),
    "SKADIS needs an explicit 9.6 mm downward seated pose");
assert(
    close_to(
        skadis_downward_seating_travel,
        skadis_proxy_slot_h -
            skadis_proxy_slot_w -
            skadis_seating_vertical_clearance
    ) &&
    close_to(skadis_seating_vertical_clearance, 0.4),
    "SKADIS seating travel must derive from the slot capsule"
);
assert(
    close_to(skadis_neck_slot_clearance_h, 0.15) &&
    skadis_neck_transition_profile ==
        "width_aware_chamfer_to_rounded_slot" &&
    skadis_production_neck_chamfer_heights == [
        for (hook_w = skadis_production_hook_widths)
            skadis_neck_seating_chamfer_height(hook_w)
    ] &&
    len(skadis_production_neck_chamfer_heights) == 3 &&
    skadis_production_neck_chamfer_heights[0] <
        skadis_production_neck_chamfer_heights[1] &&
    skadis_production_neck_chamfer_heights[1] <
        skadis_production_neck_chamfer_heights[2] &&
    skadis_production_neck_chamfer_heights[2] <
        skadis_hook_neck_h &&
    len(skadis_production_full_width_neck_heights) == 3 &&
    min(skadis_production_full_width_neck_heights) >
        2.5 &&
    max(skadis_production_hook_widths) <
        skadis_proxy_slot_w &&
    close_to(
        skadis_neck_seating_chamfer_h,
        skadis_neck_seating_chamfer_height(
            skadis_hook_w
        )
    ),
    "Every supplied hook width needs its own rounded-slot neck chamfer"
);
assert(skadis_proxy_board_component_count == 1 &&
       skadis_proxy_board_z0 <=
           skadis_lower_pad_z - skadis_lower_pad_h / 2 &&
       skadis_proxy_board_z1 >=
           skadis_seated_slot_z + skadis_proxy_slot_h / 2,
    "The seated SKADIS proxy must be one board spanning slots and pads");
assert(close_to(
           skadis_board_contact_plane_y,
           skadis_lower_pad_contact_plane_y
       ) &&
       skadis_lower_pads_share_board_plane,
    "Both SKADIS lower pads must contact the same board plane");

// Independent, parameterised Multiboard split catches.
assert(
    multiboard_interface_status ==
        "parameterised_unreleased_physical_coupon_required" &&
    !multiboard_official_profile_used &&
    !multiboard_copied_snap_mesh_used,
    "Multiboard geometry must remain an independent unreleased proxy"
);
assert(multiboard_connector_positions ==
       [[0, 11], [0, 61]] &&
       multiboard_connector_count == 2 &&
       close_to(multiboard_vertical_pitch, 50) &&
       close_to(multiboard_cell_pitch, 25),
    "Multiboard requires exactly two catches over two 25 mm cells");
assert(multiboard_connector_x == [0] &&
       multiboard_connector_z == [11, 61],
    "Multiboard catches must remain centred");
assert(close_to(multiboard_proxy_hole_d, 7.2) &&
       multiboard_proxy_hole_d >= 7.2 &&
       close_to(multiboard_core_d, 6.6) &&
       close_to(multiboard_catch_span, 7.60) &&
       close_to(multiboard_split_w, 1.2) &&
       close_to(multiboard_flex_length, 7.0) &&
       close_to(multiboard_unsplit_root_web, 1.5) &&
       close_to(multiboard_projection, 8.5) &&
       close_to(multiboard_lead_in_tip_d, 5.8),
    "The production Multiboard split-catch dimensions changed");
assert(close_to(multiboard_board_t_assumed, 6.0) &&
       close_to(multiboard_board_rear_clearance, 3.0) &&
       close_to(multiboard_retention_shoulder_behind_board, 0.35) &&
       close_to(multiboard_retention_shoulder_depth, 6.35) &&
       close_to(multiboard_shoulder_ramp_length, 0.30),
    "The documented Multiboard board proxy assumptions changed");
assert(multiboard_retention_shoulder_depth >
       multiboard_board_t_assumed &&
       multiboard_retention_shoulder_depth <
       multiboard_projection,
    "The retention shoulder must sit behind the assumed board");
assert(close_to(multiboard_insertion_travel, 6.35) &&
       close_to(multiboard_lead_in_length, 2.15) &&
       close_to(multiboard_core_radial_clearance, 0.30) &&
       close_to(multiboard_nominal_catch_compression_per_side, 0.20),
    "Multiboard insertion travel or catch interference changed");
assert(multiboard_positive_retention &&
       !multiboard_friction_ribs_only &&
       close_to(multiboard_retention_shoulder_per_side, 0.50),
    "Multiboard needs a split positive-retention shoulder");
assert(close_to(multiboard_split_crack_stop_d, 1.8) &&
       multiboard_split_has_rounded_crack_stop &&
       close_to(multiboard_root_fillet_r, 2.0),
    "The split crack-stop or root fillet changed");
assert(
    multiboard_profile_kind == "transverse_kite" &&
    multiboard_transverse_kite_profile_retained &&
    close_to(multiboard_core_vertical_span, 6.6) &&
    close_to(multiboard_catch_vertical_span, 6.6) &&
    close_to(multiboard_tip_vertical_span, 5.8),
    "The transverse kite profile must retain the reviewed fit envelope"
);
assert(multiboard_axial_underside_support_required &&
       multiboard_support_required &&
       multiboard_support_strategy ==
           "painted_organic_axial_undersides_only" &&
       multiboard_support_type == "organic_tree" &&
       multiboard_support_build_plate_only &&
       close_to(multiboard_support_interface_gap, 0.20) &&
       close_to(multiboard_support_xy_gap, 0.35) &&
       multiboard_support_interface_layers == 2 &&
       close_to(multiboard_support_density_percent, 12) &&
       multiboard_support_regions_per_full_back == 2 &&
       multiboard_support_avoids_split &&
       multiboard_support_avoids_shoulder_side_faces,
    "Multiboard needs precise targeted support under axial undersides");
assert(close_to(multiboard_plug_to_pad_overlap, 0.60) &&
       close_to(multiboard_plug_to_pad_radial_overlap, 0.30) &&
       multiboard_plug_to_pad_overlap > 0 &&
       multiboard_plug_to_pad_radial_overlap > 0,
    "The Multiboard plug must positively overlap its root support");
assert(close_to(multiboard_tip_beyond_board, 2.50) &&
       close_to(multiboard_seating_margin, 0.50) &&
       multiboard_seating_margin > 0,
    "Bearing lands must seat before the connector can bottom out");

// Wide Multiboard bearing lands resist rocking without entering more holes.
assert(multiboard_bearing_pad_positions ==
       [[0, 11], [0, 61]] &&
       multiboard_bearing_pad_count == 2 &&
       multiboard_bearing_land_count == 4 &&
       !multiboard_bearing_pad_is_connector,
    "Multiboard needs two pad assemblies and four non-connector lands");
assert(close_to(multiboard_bearing_pad_outer_w, 42) &&
       close_to(multiboard_bearing_pad_h, 16) &&
       close_to(multiboard_bearing_centre_gap, 6),
    "Multiboard bearing-land dimensions changed");
assert(multiboard_pad_side_edge_margin >= 15 &&
       multiboard_pad_vertical_edge_margin >= 3 &&
       multiboard_connector_vertical_edge_margin >= 7,
    "Multiboard connector or bearing-land edge margin is too small");

// Coupon coverage.
assert(tolerance_coupon_side_clearances ==
       [0.20, 0.30, 0.40],
    "Dovetail matrix must retain 0.20/0.30/0.40 mm side clearances");
assert(skadis_width_coupon_hook_widths == [4.0, 4.2, 4.4] &&
       close_to(skadis_width_coupon_board_t, 3.0) &&
       close_to(skadis_width_coupon_clearance, 0.4) &&
       close_to(skadis_width_coupon_capture_depth, 3.4),
    "The SKADIS width coupon must vary width only");
assert(skadis_capture_coupon_hook_widths ==
       [4.2, 4.2, 4.2, 4.2] &&
       skadis_capture_coupon_board_thicknesses ==
       [2.6, 3.0, 4.0, 5.0] &&
       skadis_capture_coupon_clearances ==
       [0.4, 0.4, 0.4, 0.4] &&
       close_to(skadis_capture_coupon_capture_depths[0], 3.0) &&
       close_to(skadis_capture_coupon_capture_depths[1], 3.4) &&
       close_to(skadis_capture_coupon_capture_depths[2], 4.4) &&
       close_to(skadis_capture_coupon_capture_depths[3], 5.4),
    "The SKADIS capture coupon must vary board capture only");
assert(skadis_pattern_coupon_connector_count == 2 &&
       close_to(skadis_pattern_coupon_pitch, 40),
    "The full SKADIS coupon must retain the two-hook pattern");
assert(multiboard_coupon_catch_spans == [7.35, 7.60, 7.85] &&
       close_to(multiboard_coupon_max_span, 7.85) &&
       close_to(multiboard_max_production_catch_span, 7.85),
    "The Multiboard matrix needs 7.35/7.60/7.85 mm catches");
assert(multiboard_coupon_proxy_hole_count == 3 &&
       multiboard_coupon_section_window_count == 3 &&
       multiboard_coupon_sample_pitch >
           multiboard_bearing_pad_outer_w &&
       multiboard_pattern_coupon_connector_count == 2 &&
       close_to(multiboard_pattern_coupon_pitch, 50),
    "Multiboard coupons need single-catch proxies and a full pattern");
assert(multiboard_retention_coupon_board_thicknesses ==
       [5.0, 6.0, 7.0] &&
       multiboard_retention_coupon_shoulder_depths ==
       [5.35, 6.35, 7.35] &&
       multiboard_retention_coupon_rear_clearances ==
       [4.0, 3.0, 2.0] &&
       multiboard_retention_coupon_catch_spans ==
       [7.60, 7.60, 7.60] &&
       multiboard_retention_coupon_proxy_hole_count == 3 &&
       multiboard_retention_coupon_section_window_count == 3,
    "The Multiboard depth coupon must vary retention depth only");
assert(close_to(
           multiboard_retention_coupon_shoulder_offsets[0],
           0.35
       ) &&
       close_to(
           multiboard_retention_coupon_shoulder_offsets[1],
           0.35
       ) &&
       close_to(
           multiboard_retention_coupon_shoulder_offsets[2],
           0.35
       ) &&
       close_to(
           multiboard_retention_coupon_seating_margins[0],
           0.50
       ) &&
       close_to(
           multiboard_retention_coupon_seating_margins[1],
           0.50
       ) &&
       close_to(
           multiboard_retention_coupon_seating_margins[2],
           0.50
       ),
    "Every depth coupon pair needs shoulder and bottom-out margin evidence");
assert(skadis_production_hook_widths == [4.0, 4.2, 4.4] &&
       skadis_production_board_thicknesses ==
           [2.6, 3.0, 4.0, 5.0] &&
       close_to(skadis_production_clearance, 0.4) &&
       skadis_production_capture_depths ==
           [3.0, 3.4, 4.4, 5.4] &&
       skadis_production_variant_count == 12 &&
       len(skadis_production_variants) == 12,
    "Every independent SKADIS coupon combination needs a full back");
assert(close_to(selected_skadis_hook_w, 4.2) &&
       close_to(selected_skadis_board_t, 3.0) &&
       close_to(selected_skadis_board_clearance, 0.4) &&
       close_to(selected_skadis_capture_depth, 3.4),
    "The default SKADIS parameters must identify the starting variant");
assert(multiboard_production_catch_spans ==
           [7.35, 7.60, 7.85] &&
       multiboard_production_board_thicknesses ==
           [5.0, 6.0, 7.0] &&
       multiboard_production_shoulder_depths ==
           [5.35, 6.35, 7.35] &&
       multiboard_production_rear_clearances ==
           [4.0, 3.0, 2.0] &&
       multiboard_production_variant_count == 9 &&
       len(multiboard_production_variants) == 9,
    "Every independent Multiboard coupon combination needs a full back");
assert(close_to(selected_multiboard_catch_span, 7.60) &&
       close_to(selected_multiboard_board_t, 6.0) &&
       close_to(selected_multiboard_shoulder_depth, 6.35) &&
       close_to(selected_multiboard_rear_clearance, 3.0),
    "The default Multiboard parameters must identify the starting variant");
assert(v2_7_export_recipe_count == 32 &&
       v2_7_skadis_back_export_count == 12 &&
       v2_7_multiboard_back_export_count == 9,
    "The export inventory must cover every selected full back");
assert(three_pocket_coupon_centres == [23, 44, 65] &&
       pairwise_spacings(three_pocket_coupon_centres) == [21, 21] &&
       three_pocket_coupon_openings == ["left", "right", "left"],
    "The racket coupon must use three exact production pockets");

// Export and preview inventory.
documented_printable_modes = [
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
documented_preview_modes = [
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

assert(printable_modes() == documented_printable_modes,
    str("Unexpected printable package: ", printable_modes()));
assert(preview_modes() == documented_preview_modes,
    str("Unexpected preview package: ", preview_modes()));
assert(default_render_mode == "preview_assembled_skadis_clean" &&
       default_preview_racket_shaft_count == 0 &&
       default_preview_arrow_count == 0 &&
       default_preview_explanatory_solid_count == 0 &&
       !default_preview_has_opaque_board &&
       !default_preview_is_exploded,
    "The default must be a clean assembled preview");
assert(preview_multiboard_section_axis == "Y" &&
       preview_multiboard_section_proxy_component_count == 1 &&
       preview_multiboard_section_has_positive_shoulder &&
       preview_multiboard_section_has_rear_clearance_frame,
    "The Multiboard section must be one coherent axial cutaway");
assert(preview_print_back_separation_x >= 8,
    "The two print-orientation backs must not overlap");
assert(expected_component_count("body_start_left") == 1 &&
       expected_component_count("body_start_right") == 1 &&
       expected_component_count("skadis_back") == 1 &&
       expected_component_count("multiboard_back") == 1 &&
       expected_component_count("anti_lift_clip") == 1 &&
       expected_component_count("dovetail_tolerance_coupon") == 4 &&
       expected_component_count("skadis_hook_width_coupon") == 3 &&
       expected_component_count("skadis_board_capture_coupon") == 4 &&
       expected_component_count("skadis_two_hook_pattern_coupon") == 1 &&
       expected_component_count("multiboard_catch_tolerance_coupon") == 6 &&
       expected_component_count("multiboard_retention_depth_coupon") == 6 &&
       expected_component_count("multiboard_two_catch_pattern_coupon") == 1 &&
       expected_component_count("three_pocket_racket_coupon") == 1,
    "Production parts and coupon component counts changed");
assert(all_equal(
           [for (mode = documented_printable_modes)
               mode_is_printable(mode)],
           true
       ) &&
       all_equal(
           [for (mode = documented_preview_modes)
               mode_is_preview(mode)],
           true
       ),
    "Every documented v2.7 mode must exist");

// Bed fit, exact back transform and honest targeted support contract.
assert(print_bed_xy == [256, 256] &&
       body_print_bounds[0] <= print_bed_xy[0] &&
       body_print_bounds[1] <= print_bed_xy[1],
    "The v2.7 package must fit the declared print bed");
assert(multiboard_back_print_rotation == [0, 0, 0] &&
       multiboard_back_print_translation == [0, 0, 0] &&
       multiboard_male_coupon_print_rotation == [0, 0, 0] &&
       multiboard_male_coupon_print_translation == [0, 0, 0] &&
       multiboard_print_bed_axes == ["X", "Y"] &&
       multiboard_catch_axis == "Y" &&
       multiboard_split_flex_axis == "X" &&
       multiboard_original_z0_bed_contact &&
       close_to(recommended_back_brim_w, 6.0),
    "The documented back print transform or brim changed");
assert(multiboard_support_required &&
       multiboard_axial_underside_support_required &&
       multiboard_support_strategy ==
           "painted_organic_axial_undersides_only" &&
       multiboard_support_type == "organic_tree" &&
       multiboard_support_build_plate_only &&
       close_to(multiboard_support_interface_gap, 0.20) &&
       close_to(multiboard_support_xy_gap, 0.35) &&
       multiboard_support_interface_layers == 2 &&
       close_to(multiboard_support_density_percent, 12) &&
       multiboard_support_regions_per_full_back == 2 &&
       multiboard_support_avoids_split &&
       multiboard_support_avoids_shoulder_side_faces,
    "The Multiboard print requires the targeted support recipe");

// Conservative static audit only; this is not a load rating.
assert(close_to(audit_tip_mass_kg, 3.0) &&
       close_to(audit_tip_lever_m, 0.221) &&
       close_to(audit_tip_moment_nm, 6.50, 0.01) &&
       close_to(audit_multiboard_couple_reaction_n, 130.0, 0.2) &&
       close_to(audit_skadis_effective_reaction_spacing_m, 0.040) &&
       close_to(audit_skadis_vertical_reaction_n, 162.6, 0.2) &&
       !audit_is_load_rating,
    "The documented 3 kg tip-load audit changed");

echo("V2_7_DUAL_BOARD_SCREWLESS_DIMENSION_TESTS_PASSED");

// Keep a tiny object in the evaluation so --hardwarnings exits cleanly.
cube([0.1, 0.1, 0.1]);
