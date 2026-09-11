// Dimensional contract for the v2.6 SKADIS-only screwless slide-lock.
//
// Run from the project directory with:
// TERM=dumb NO_COLOR=1 openscad --hardwarnings \
//   -D 'render_mode="none"' \
//   -o /tmp/badminton_v2_6_dimensions.echo \
//   tests/prototypes/v2_6/test_dimensions.scad

include <../../../src/prototypes/v2_6_skadis_screwless_slide_lock.scad>

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

assert(prototype_version == "2.6",
    str("Unexpected prototype version: ", prototype_version));
assert(
    prototype_release_status ==
        "skadis_screwless_slide_lock_prototype_not_released",
    "v2.6 must remain explicitly marked as an unreleased prototype"
);
assert(skadis_only,
    "v2.6 must support only the IKEA SKADIS pegboard");
assert(other_board_mode_count == 0,
    "No other pegboard output mode may be exposed");
assert(threaded_fastener_hole_count == 0 &&
       thermal_insert_pocket_count == 0 &&
       metal_fastener_count == 0 &&
       counterbored_hole_count == 0 &&
       legacy_interface_feature_count == 0,
    "The complete v2.6 package must be screwless and all-printed");
assert(visible_front_fastening_opening_count == 0 &&
       visible_rear_fastening_opening_count == 0,
    "The assembled rack must show no fastening openings");
assert(!ten_racket_load_verified &&
       load_rating_status == "physical_validation_required",
    "Ten modelled positions must not imply a verified load rating");

// Exactly two SKADIS board hooks; lower pads only bear against the board.
assert(close_to(back_w, 72) &&
       close_to(back_h, 72) &&
       close_to(back_t, 10),
    "The screwless SKADIS back must be 72 x 72 x 10 mm");
assert(skadis_board_connector_positions ==
       [[-20, 58], [20, 58]],
    str("Unexpected SKADIS hook positions: ",
        skadis_board_connector_positions));
assert(skadis_board_connector_count == 2,
    "The back must have exactly two printed board hooks");
assert(!skadis_lower_pad_is_connector &&
       skadis_lower_bearing_pad_count == 2 &&
       skadis_lower_pad_positions ==
           [[-20, 11], [20, 11]],
    "The two lower features must be bearing supports only");

// Structural downward slide-lock interface.
assert(rail_centres_x == [-20, 20],
    str("Unexpected rail centres: ", rail_centres_x));
assert(close_to(rail_engagement, 36) &&
       close_to(rail_z0, 18) &&
       close_to(rail_z1, 54),
    "The two rails need 36 mm engagement at Z=18..54");
assert(close_to(male_rail_projection, 6.0) &&
       close_to(male_rail_neck_w, 8.0) &&
       close_to(male_rail_crown_w, 12.0),
    "Male dovetail dimensions changed");
assert(close_to(nominal_female_mouth_w, 8.6) &&
       close_to(nominal_female_crown_w, 12.6) &&
       close_to(nominal_female_depth, 6.4),
    "Nominal female dovetail dimensions changed");
assert(close_to(rail_side_clearance, 0.30) &&
       close_to(rail_depth_clearance, 0.40),
    "Nominal rail clearance must remain 0.30 mm per side and 0.40 mm deep");
assert(close_to(heel_t, 14) &&
       close_to(heel_front_wall, 7.6),
    "The body heel must retain a 7.6 mm solid front wall");
assert(rail_surround_min >= 3,
    str("Rail/cavity material is below 3 mm: ",
        rail_surround_min));
assert(close_to(rail_lead_in, 1.5) &&
       rail_root_fillet_r >= 2,
    "Rails need a 1.5 mm lead-in and at least R2 roots");
assert(close_to(rail_lead_in_lower_slice_z, 52.48) &&
       close_to(rail_lead_in_upper_slice_z, 53.98) &&
       close_to(rail_lead_in_upper_end_z, 54.02) &&
       lead_in_containment_sample_z ==
           [52.48, 53.0, 53.5, 53.98, 54.02],
    "The upper lead-in containment samples changed");
assert(female_channels_open_bottom &&
       female_channels_closed_top &&
       close_to(closed_top_stop_t, 4),
    "Channels must open below and close against a rigid 4 mm top stop");
assert(assembly_direction == "downward" &&
       gravity_seats_interface,
    "The body must slide downward and remain gravity-seated");
assert(interface_structural_path ==
       "twin_dovetail_rails_and_closed_top_stops",
    "The dovetails and stops must carry the cantilever load");

// Replaceable underside anti-lift clip.
assert(anti_lift_part_count == 1 &&
       anti_lift_is_separate &&
       anti_lift_positive_retention,
    "Provide one positively retained replaceable anti-lift part");
assert(anti_lift_role == "upward_retention_only" &&
       !anti_lift_carries_cantilever_load,
    "The clip must not carry the normal cantilever load");
assert(anti_lift_release_direction == "below" &&
       !anti_lift_visible_from_front &&
       !anti_lift_visible_from_rear,
    "The clip must be hidden and removable from below");
assert(close_to(anti_lift_service_gap, 8) &&
       close_to(anti_lift_clip_height, 8),
    "The clip must fill the 8 mm space below the seated rails");
assert(anti_lift_detent_interference > 0 &&
       anti_lift_detent_interference <= 0.35,
    "Clip detents need controlled positive interference");

// One continuous ten-position alternating zigzag.
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

assert(one_piece_body_export_supported &&
       body_component_count == 1,
    "Each body must contain one continuous heel, root and arm");
assert(loose_body_section_count == 0 &&
       collar_part_count == 0 &&
       cradle_part_count == 0,
    "No section, collar or cradle mechanism may return");
assert(num_racket_positions == 10 &&
       racket_centres == expected_centres,
    str("Unexpected racket centres: ", racket_centres));
assert(pairwise_spacings(racket_centres) ==
       [21, 21, 21, 21, 21, 21, 21, 21, 21],
    "All racket positions need 21 mm pitch");
assert(all_equal(racket_axes_x, 0),
    "Every racket shaft must remain centred at X=0");
assert(opening_sides_for(false) == expected_start_left &&
       opening_sides_for(true) == expected_start_right,
    "The two bodies need exact opposite alternating sequences");
assert(count_equal(opening_sides_for(false), "left") == 5 &&
       count_equal(opening_sides_for(false), "right") == 5 &&
       all_equal(opening_count_per_pocket, 1) &&
       !slot_cut_crosses_full_arm,
    "Each pocket must have one alternating side entry");
assert(close_to(pocket_d, 8.8) &&
       close_to(entry_gap, 6.6) &&
       close_to(arm_w, 28) &&
       close_to(arm_h, 36) &&
       close_to(full_projection, 221),
    "The proven zigzag envelope changed");
assert(close_to(root_flare_w, 52),
    "The root flare must widen to 52 mm");
assert(close_to(opposite_side_ligament, 9.6) &&
       close_to(adjacent_pocket_web, 12.2),
    "Critical zigzag ligaments changed");
assert(heel_root_overlap >= 1 &&
       root_arm_overlap >= 1 &&
       tip_margin >= 4,
    "The connected body needs positive overlaps and tip material");

// Export package.
documented_printable_modes = [
    "body_start_left",
    "body_start_right",
    "screwless_skadis_back",
    "anti_lift_clip",
    "skadis_fit_coupon",
    "dovetail_tolerance_coupon"
];
documented_preview_modes = [
    "preview_assembled_front_iso",
    "preview_rear_two_hooks",
    "preview_exploded_slide",
    "preview_dovetail_closeup",
    "preview_connected_zigzag",
    "preview_print_orientations"
];

assert(printable_modes() == documented_printable_modes,
    str("Unexpected printable package: ", printable_modes()));
assert(preview_modes() == documented_preview_modes,
    str("Unexpected preview package: ", preview_modes()));
assert(all_equal(
           [for (mode = documented_printable_modes)
               mode_is_printable(mode)],
           true
       ),
    "Every documented v2.6 printable mode must exist");
assert(!mode_is_supported("multiboard_back") &&
       !mode_is_supported("screw_back") &&
       !mode_is_supported("body_with_fastener_holes"),
    "No legacy or other-board output mode may be supported");
assert(expected_component_count("body_start_left") == 1 &&
       expected_component_count("body_start_right") == 1 &&
       expected_component_count("screwless_skadis_back") == 1 &&
       expected_component_count("anti_lift_clip") == 1 &&
       expected_component_count("skadis_fit_coupon") == 1 &&
       expected_component_count("dovetail_tolerance_coupon") == 4,
    "Production parts must be single components; the tolerance matrix has four");
assert(tolerance_coupon_side_clearances ==
       [0.20, 0.30, 0.40],
    "The tolerance matrix must test 0.20/0.30/0.40 mm per side");
assert(body_print_bounds[0] <= print_bed_xy[0] &&
       body_print_bounds[1] <= print_bed_xy[1],
    str("The body exceeds the print bed: ", body_print_bounds));

echo("V2_6_SKADIS_SCREWLESS_DIMENSION_TESTS_PASSED");

// Keep a tiny object in the evaluation so --hardwarnings exits cleanly.
cube([0.1, 0.1, 0.1]);
