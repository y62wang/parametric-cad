// Dimensional contract for the v2.5 connected alternating-sawtooth prototype.
//
// Run from the project directory with:
// TERM=dumb NO_COLOR=1 openscad --hardwarnings \
//   -D 'render_mode="none"' \
//   -o /tmp/badminton_v2_5_dimensions.echo \
//   tests/prototypes/v2_5/test_dimensions.scad

include <../../../src/prototypes/v2_5_connected_zigzag.scad>

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

assert(prototype_version == "2.5",
    str("Unexpected prototype version: ", prototype_version));
assert(
    prototype_release_status ==
        "connected_zigzag_prototype_not_released",
    "v2.5 must remain explicitly marked as an unreleased prototype"
);
assert(one_piece_body_export_supported,
    "v2.5 must expose a printable one-piece body");
assert(ten_racket_load_verified == false,
    "Ten modelled positions must not imply a verified ten-racket load");
assert(load_rating_status == "physical_validation_required",
    str("Unexpected load status: ", load_rating_status));

// One connected load path with no segmented mechanism.
assert(body_component_count == 1,
    "The heel, root and full arm must form one body component");
assert(collar_part_count == 0 &&
       cradle_part_count == 0 &&
       loose_body_section_count == 0 &&
       assembly_joint_count == 0,
    "v2.5 must not contain collars, cradles, loose sections or joints");
assert(!has_collar_modes && !has_cradle_modes,
    "v2.5 must expose no collar or cradle modes");
assert(!mode_is_supported("full_body_sections") &&
       !mode_is_supported("full_rack_collars") &&
       !mode_is_supported("full_rack_cradle"),
    "Segmented v2.4 modes must not leak into v2.5");

// Ten centred positions and exact alternating directions.
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

assert(num_racket_positions == 10,
    "The connected body must provide ten racket positions");
assert(racket_centres == expected_centres,
    str("Unexpected racket centres: ", racket_centres));
assert(pairwise_spacings(racket_centres) ==
       [21, 21, 21, 21, 21, 21, 21, 21, 21],
    "Every racket centre must use 21 mm pitch");
assert(all_equal(racket_axes_x, 0),
    "Every racket shaft axis must remain centred at X = 0");
assert(opening_sides_for(false) == expected_start_left,
    str("Incorrect start-left sequence: ",
        opening_sides_for(false)));
assert(opening_sides_for(true) == expected_start_right,
    str("Incorrect start-right sequence: ",
        opening_sides_for(true)));
assert(count_equal(opening_sides_for(false), "left") == 5 &&
       count_equal(opening_sides_for(false), "right") == 5,
    "The start-left body needs five left and five right openings");
assert(count_equal(opening_sides_for(true), "left") == 5 &&
       count_equal(opening_sides_for(true), "right") == 5,
    "The start-right body needs five left and five right openings");
assert(all_equal(opening_count_per_pocket, 1),
    "Every pocket must have exactly one side opening");
assert(!slot_cut_crosses_full_arm,
    "No racket entry may cross the complete arm width");

// Sawtooth and continuous-body dimensions.
assert(close_to(pocket_d, 8.8) &&
       close_to(entry_gap, 6.6),
    "Pocket and entry dimensions must remain 8.8 and 6.6 mm");
assert(close_to(arm_w, 28) &&
       close_to(arm_h, 36),
    "The arm envelope must remain 28 x 36 mm");
assert(close_to(opposite_side_ligament, 9.6),
    str("Unexpected opposite-side ligament: ",
        opposite_side_ligament));
assert(close_to(adjacent_pocket_web, 12.2),
    str("Unexpected adjacent-pocket web: ",
        adjacent_pocket_web));
assert(close_to(full_projection, 221),
    str("Unexpected projection: ", full_projection));
assert(tip_margin >= 4,
    str("Tip margin is too small: ", tip_margin));
assert(close_to(root_flare_w, 40) ||
       root_flare_w > 40,
    "Root flare must be at least 40 mm wide");
assert(heel_root_overlap >= 1 &&
       root_arm_overlap >= 1,
    str("Heel/root/arm require positive overlap; got ",
        heel_root_overlap, " and ", root_arm_overlap));

// Compact centred body-to-back interface.
assert(close_to(back_w, 72) &&
       close_to(back_h, 72) &&
       close_to(back_t, 8),
    "Both mounting backs must remain 72 x 72 x 8 mm");
assert(close_to(heel_w, 72) &&
       close_to(heel_h, 36) &&
       close_to(heel_t, 8) &&
       close_to(heel_z0, 18),
    "The centred heel must remain 72 x 36 x 8 mm at Z=18..54");
assert(close_to(arm_centre_x, 0) &&
       close_to(arm_z0, 18),
    "The arm must remain centred at X=0 and Z=18..54");
assert(close_to(key_w, 40) &&
       close_to(key_h, 20) &&
       close_to(key_depth, 3) &&
       close_to(key_z0, 26),
    "The centred positive key must remain 40 x 20 x 3 mm");
assert(body_bolt_x == [-27, 27] &&
       body_bolt_z == [26, 46],
    "The body fasteners must remain at X +/-27 and Z 26/46");

// Exactly two actual board connections or attachment points.
assert(skadis_board_connector_positions ==
       [[-20, 58], [20, 58]],
    str("Unexpected SKÅDIS hook positions: ",
        skadis_board_connector_positions));
assert(skadis_board_connector_count == 2,
    "SKÅDIS must have exactly two printed board hooks");
assert(!skadis_lower_pad_is_connector &&
       skadis_lower_bearing_pad_count == 2,
    "The lower SKÅDIS features must be bearing supports");
assert(multiboard_attachment_points ==
       [[0, 11], [0, 61]],
    str("Unexpected Multiboard attachment points: ",
        multiboard_attachment_points));
assert(multiboard_attachment_point_count == 2,
    "Multiboard must have exactly two centred attachment points");
assert(pairwise_spacings(
           [for (point = multiboard_attachment_points)
               point[1]]
       ) == [50],
    "Multiboard attachment points must use 50 mm vertical pitch");
assert(!multiboard_hardware_included &&
       multiboard_attachment_hardware ==
           "external_m4_compatible_multiboard_hardware",
    "External Multiboard M4-compatible hardware must be documented");

// Printable package and build-volume contract.
printable_modes = [
    "body_start_left",
    "body_start_right",
    "skadis_back",
    "multiboard_back",
    "skadis_fit_coupon",
    "multiboard_fit_coupon",
    "spacing_coupon"
];
preview_modes = [
    "preview_assembled_skadis",
    "preview_assembled_multiboard",
    "preview_zigzag_spine",
    "preview_skadis_rear",
    "preview_multiboard_rear",
    "preview_print_orientation"
];

assert(all_equal(
           [for (mode = printable_modes)
               mode_is_printable(mode)],
           true
       ),
    "Every documented v2.5 printable mode must be available");
assert(all_equal(
           [for (mode = preview_modes)
               mode_is_printable(mode)],
           false
       ),
    "Preview modes must not be marked printable");
assert(all_equal(
           [for (mode = printable_modes)
               expected_component_count(mode)],
           1
       ),
    "Every v2.5 printable output must be one component");
assert(body_print_bounds[0] <= print_bed_xy[0] &&
       body_print_bounds[1] <= print_bed_xy[1],
    str("Body exceeds the declared print bed: ",
        body_print_bounds));
assert(spacing_coupon_centres == [9, 30, 51] &&
       spacing_coupon_opening_sides ==
           ["left", "right", "left"],
    "The short coupon must reproduce three alternating 21 mm slots");

echo("V2_5_CONNECTED_ZIGZAG_DIMENSION_TESTS_PASSED");

// Keep a tiny object in the test evaluation so --hardwarnings exits cleanly.
cube([0.1, 0.1, 0.1]);
