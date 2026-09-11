// Dimensional contract for the v2.4 printable full-rack prototype.
//
// Run from the project directory with:
// TERM=dumb NO_COLOR=1 openscad --hardwarnings \
//   -D 'render_mode="none"' \
//   -o /tmp/badminton_v2_4_dimensions.echo \
//   tests/prototypes/v2_4/test_dimensions.scad

include <../../../src/prototypes/v2_4_printable_full_rack.scad>

function close_to(actual, expected, tolerance = 0.001) =
    abs(actual - expected) <= tolerance;

function pairwise_spacings(values) = [
    for (i = [0 : len(values) - 2])
        values[i + 1] - values[i]
];

function all_equal(values, expected) =
    len([for (value = values) if (value == expected) value]) ==
        len(values);

assert(prototype_version == "2.4",
    str("Unexpected prototype version: ", prototype_version));
assert(
    prototype_release_status ==
        "printable_full_rack_prototype_not_released",
    "v2.4 must remain explicitly marked as an unreleased printable prototype"
);
assert(full_body_export_supported,
    "v2.4 must expose a printable ten-position body");
assert(ten_racket_load_verified == false,
    "Ten centred positions must not be reported as a verified ten-racket load");
assert(load_rating_status == "physical_validation_required",
    str("Unexpected load-rating status: ", load_rating_status));

// Centred back and body geometry.
assert(close_to(back_w, 72) &&
       close_to(back_h, 72) &&
       close_to(back_t, 8),
    "Both v2.4 mounting backs must be 72 x 72 x 8 mm");
assert(close_to(arm_centre_x, 0),
    "The racket holder arm must remain centred at X = 0");
assert(close_to(arm_w, 28) &&
       close_to(arm_h, 36),
    "The arm cross-section must remain 28 x 36 mm");

// Two printed SKÅDIS hooks and two external-hardware Multiboard points.
assert(skadis_hook_x == [-20, 20] &&
       close_to(skadis_hook_z, 58),
    "SKÅDIS hooks must remain centred at X +/-20 mm");
assert(skadis_board_connector_positions ==
       [[-20, 58], [20, 58]],
    str("Unexpected SKÅDIS connector positions: ",
        skadis_board_connector_positions));
assert(skadis_board_connector_count == 2,
    "SKÅDIS must have exactly two board-engaging hooks");
assert(skadis_lower_pad_is_connector == false &&
       len(skadis_lower_pad_x) == 2,
    "SKÅDIS lower features must remain bearing pads, not connectors");

assert(multiboard_mount_positions ==
       [[0, 11], [0, 61]],
    str("Unexpected Multiboard mount positions: ",
        multiboard_mount_positions));
assert(multiboard_mount_count == 2,
    "Multiboard must have exactly two centred attachment points");
assert(multiboard_attachment_point_count == 2 &&
       multiboard_attachment_points == multiboard_mount_positions,
    "Multiboard attachment-point metadata must match the two modelled holes");
assert(multiboard_hardware_included == false,
    "The model must not claim to include printed Multiboard board hardware");
assert(
    multiboard_attachment_hardware ==
        "external_m4_compatible_multiboard_hardware",
    str("Unexpected Multiboard hardware status: ",
        multiboard_attachment_hardware)
);
assert(all_equal(
           [for (position = multiboard_mount_positions)
               position[0]],
           0
       ),
    "Both Multiboard positions must be centred at X = 0");
assert(pairwise_spacings(
           [for (position = multiboard_mount_positions)
               position[1]]
       ) == [50],
    "The two Multiboard positions must use 50 mm vertical pitch");
assert(multiboard_edge_margin >= 6.8,
    str("Insufficient Multiboard edge margin: ",
        multiboard_edge_margin));
assert(multiboard_interface_vertical_clearance >= 2.5,
    str("Multiboard counterbores are too close to the body interface: ",
        multiboard_interface_vertical_clearance));
assert(multiboard_insert_cavity_clearance >= 20,
    str("Multiboard mounting holes are too close to body inserts: ",
        multiboard_insert_cavity_clearance));

// Ten centred racket axes at 21 mm pitch.
assert(num_racket_positions == 10,
    "The printable design must provide ten racket positions");
assert(racket_centres == [
        23, 44, 65, 86, 107,
        128, 149, 170, 191, 212
    ],
    str("Unexpected racket centres: ", racket_centres));
assert(pairwise_spacings(racket_centres) ==
       [21, 21, 21, 21, 21, 21, 21, 21, 21],
    "Every racket centre must use 21 mm pitch");
assert(len(racket_axes_x) == 10 &&
       all_equal(racket_axes_x, 0),
    "All ten racket shaft axes must be centred at X = 0");
assert(num_racket_positions == 10 &&
       ten_racket_load_verified == false &&
       load_rating_status == "physical_validation_required",
    "Ten centred positions must remain distinct from physical load validation");
assert(close_to(full_projection, 226),
    str("Full body projection changed: ", full_projection));
assert(final_track_tip_margin >= 4.4,
    str("Final track-to-tip margin must be at least 4.4 mm, got ",
        final_track_tip_margin));
assert(full_body_print_bounds[0] <= print_bed_xy[0] &&
       full_body_print_bounds[1] <= print_bed_xy[1],
    str("Full body exceeds the declared print bed: ",
        full_body_print_bounds));

// Eleven body sections, ten collars and one indexed assembly cradle.
assert(len(full_section_ranges) == 11,
    "Ten bilateral corridors must create eleven printable body sections");
assert(full_section_ranges == [
        [-3, 19],
        [27, 40],
        [48, 61],
        [69, 82],
        [90, 103],
        [111, 124],
        [132, 145],
        [153, 166],
        [174, 187],
        [195, 208],
        [216, 226]
    ],
    str("Unexpected full-body section ranges: ",
        full_section_ranges));
assert(full_section_labels == [
        "ROOT", "S2", "S3", "S4", "S5", "S6",
        "S7", "S8", "S9", "S10", "TIP"
    ],
    str("Unexpected section labels: ", full_section_labels));
assert(collar_labels == [
        "R1", "R2", "R3", "R4", "R5",
        "R6", "R7", "R8", "R9", "R10"
    ],
    str("Unexpected collar labels: ", collar_labels));
assert(len(full_cradle_pocket_records) == 11,
    "The cradle must locate all eleven loose body sections");
assert(full_cradle_hole_centres ==
       [for (centre_y = racket_centres) [0, centre_y]],
    "The cradle needs one lower-lip access hole below every collar");
assert(len(full_cradle_hole_centres) == 10 &&
       close_to(full_cradle_hole_d, 22),
    "The cradle must have ten 22 mm lower-lip access holes");
assert(full_cradle_bounds[0] <= print_bed_xy[0] &&
       full_cradle_bounds[1] <= print_bed_xy[1],
    str("The one-piece cradle exceeds the declared print bed: ",
        full_cradle_bounds));
assert(full_cradle_lip_bottom_z > 0,
    "The cradle through-holes must leave each lower snap lip unobstructed");

// Preserve the reviewed bilateral collar mechanism.
assert(close_to(nominal_shaft_d, 7.2) &&
       close_to(collar_bore_d, 9.0) &&
       close_to(nominal_cavity_d, 16.5) &&
       close_to(nominal_throat_w, 7.1),
    "Nominal racket and collar fit dimensions changed unexpectedly");
assert(close_to(track_travel_deg, 180) &&
       close_to(hard_stop_travel_deg, 180),
    "Each collar must retain true 180-degree left/right travel");
assert(close_to(right_throat_pose_deg, 0) &&
       close_to(left_throat_pose_deg, 180),
    "Collar endpoint openings must face right and left");
assert(right_detent_centre_mismatch <= 0.05 &&
       left_detent_centre_mismatch <= 0.05,
    "Collar endpoint detents must remain coincident with their pockets");

// Printable and preview mode contract.
printable_modes = [
    "full_body_sections",
    "full_rack_collars",
    "full_rack_cradle",
    "skadis_back",
    "multiboard_back",
    "skadis_fit_coupon",
    "multiboard_fit_coupon"
];
preview_modes = [
    "preview_complete_skadis",
    "preview_complete_multiboard",
    "preview_skadis_rear",
    "preview_multiboard_rear",
    "preview_bilateral_operation",
    "preview_full_cradle_assembly"
];

assert(all_equal(
           [for (mode = printable_modes)
               mode_is_printable(mode)],
           true
       ),
    "Every documented v2.4 print mode must be available");
assert(all_equal(
           [for (mode = preview_modes)
               mode_is_printable(mode)],
           false
       ),
    "Preview modes must not be treated as printable exports");
assert(expected_component_count("full_body_sections") == 11,
    "The body export must contain eleven closed components");
assert(expected_component_count("full_rack_collars") == 10,
    "The collar export must contain ten closed components");
assert(expected_component_count("full_rack_cradle") == 1,
    "The cradle export must remain one closed component");
assert(expected_component_count("skadis_back") == 1 &&
       expected_component_count("multiboard_back") == 1 &&
       expected_component_count("skadis_fit_coupon") == 1 &&
       expected_component_count("multiboard_fit_coupon") == 1,
    "Every mounting back and fit coupon must export as one component");

echo("V2_4_PRINTABLE_FULL_RACK_DIMENSION_TESTS_PASSED");

// Keep a tiny object in the test evaluation so --hardwarnings exits cleanly.
cube([0.1, 0.1, 0.1]);
