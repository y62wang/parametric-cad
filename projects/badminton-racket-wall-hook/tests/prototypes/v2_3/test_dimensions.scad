// Dimensional contract for the v2.3 rotating-collar prototype.
//
// Run from the project directory with:
// TERM=dumb NO_COLOR=1 openscad --hardwarnings \
//   -D 'render_mode="none"' \
//   -o /tmp/badminton_v2_3_dimensions.echo \
//   tests/prototypes/v2_3/test_dimensions.scad

include <../../../src/prototypes/v2_3_rotating_collar.scad>

function close_to(actual, expected, tolerance = 0.001) =
    abs(actual - expected) <= tolerance;

function pairwise_spacings(values) = [
    for (i = [0 : len(values) - 2])
        values[i + 1] - values[i]
];

function distance_2d(a, b) =
    sqrt(pow(a[0] - b[0], 2) + pow(a[1] - b[1], 2));

assert(prototype_version == "2.3",
    str("Unexpected prototype version: ", prototype_version));
assert(prototype_release_status == "prototype_not_released",
    "v2.3 must remain explicitly marked as an unreleased prototype");

// Centred mounting backs and interface.
assert(close_to(back_w, 72) &&
       close_to(back_h, 72) &&
       close_to(back_t, 8),
    "Both prototype backs must be 72 x 72 x 8 mm");
assert(close_to(heel_w, 72) &&
       close_to(heel_h, 36) &&
       close_to(heel_t, 8),
    "The centred heel must be 72 x 36 x 8 mm");
assert(close_to(heel_z0, 18) &&
       close_to(heel_z0 + heel_h, 54),
    "The heel must occupy global Z = 18..54 mm");
assert(close_to(arm_w, 28) &&
       close_to(arm_h, 36) &&
       close_to(arm_z0, 18) &&
       close_to(arm_z0 + arm_h, 54),
    "The arm must be 28 x 36 mm at global Z = 18..54 mm");
assert(close_to(arm_centre_x, 0),
    "The arm must remain centred at X = 0");
assert(close_to(key_w, 40) &&
       close_to(key_h, 20) &&
       close_to(key_depth, 3) &&
       close_to(key_z0, 26) &&
       close_to(key_z0 + key_h / 2, 36),
    "The positive key must be 40 x 20 x 3 mm centred at global Z = 36");
assert(body_bolt_x == [-27, 27] &&
       body_bolt_z == [26, 46],
    "Body M4 positions must be X +/-27 and global Z 26/46");
assert(interface_fastener_count == 4,
    "The centred interface must use four M4 fasteners");

assert(close_to(body_counterbore_side_margin, 4.9) &&
       close_to(body_counterbore_bottom_margin, 3.9) &&
       close_to(body_counterbore_top_margin, 3.9),
    str(
        "Unexpected body counterbore margins: ",
        body_counterbore_side_margin, ", ",
        body_counterbore_bottom_margin, ", ",
        body_counterbore_top_margin
    ));
assert(close_to(insert_to_key_side_wall, 3.8),
    str(
        "Insert-to-key side wall must remain 3.8 mm, got ",
        insert_to_key_side_wall
    ));
assert(close_to(back_t - key_recess_depth, 4.65),
    "The key recess must leave 4.65 mm of back material");
assert(close_to(back_t - insert_depth, 1.8),
    "The heat-set insert pockets must leave 1.8 mm of rear wall");

// Root and concept body.
assert(close_to(root_flare_w, 40),
    "The root flare must be 40 mm wide");
assert(close_to(root_transition_y, 10.5),
    "The root must taper to 28 mm by Y = 10.5 mm");
assert(close_to(root_start_y, heel_t),
    "The root flare must begin at the front of the 8 mm heel");
assert(num_concept_positions == 10,
    "The preview-only concept must contain ten collar positions");
assert(concept_centres == [
        23, 44, 65, 86, 107,
        128, 149, 170, 191, 212
    ],
    str("Unexpected ten-position centres: ", concept_centres));
assert(pairwise_spacings(concept_centres) ==
       [21, 21, 21, 21, 21, 21, 21, 21, 21],
    "The concept collar pitch must be 21 mm");
assert(close_to(concept_projection, 223),
    str("Concept projection must be about 223 mm, got ",
        concept_projection));
assert(close_to(concept_tip_margin, 1.4),
    str("Unexpected track-to-tip margin: ", concept_tip_margin));
assert(structural_centres == [23, 44, 65],
    "The structural coupon must use three positions at 21 mm pitch");

// Racket fit, collar and body sockets.
assert(close_to(nominal_shaft_d, 7.2),
    "Nominal racket shaft diameter must be 7.2 mm");
assert(close_to(collar_bore_d, 9.0),
    "Collar bore must be 9.0 mm");
assert(cavity_diameters == [16.4, 16.5, 16.6],
    "Tolerance matrix cavity diameters must be 16.4/16.5/16.6 mm");
assert(throat_widths == [6.9, 7.1, 7.3],
    "Tolerance matrix throat widths must be 6.9/7.1/7.3 mm");
assert(len(tolerance_matrix_records) == 9,
    "The tolerance matrix must contain all nine diameter/throat pairs");
assert(tolerance_matrix_records == [
        [16.4, 6.9, "A1"], [16.5, 6.9, "A2"],
        [16.6, 6.9, "A3"], [16.4, 7.1, "B1"],
        [16.5, 7.1, "B2"], [16.6, 7.1, "B3"],
        [16.4, 7.3, "C1"], [16.5, 7.3, "C2"],
        [16.6, 7.3, "C3"]
    ],
    "Tolerance matrix labels must map deterministically to all nine pairs");
assert(close_to(collar_barrel_d, 16.0),
    "Collar barrel must be 16.0 mm");
assert(close_to(collar_flange_d, 17.2) &&
       close_to(collar_flange_h, 2.0),
    "Collar top flange must be 17.2 x 2.0 mm");
assert(close_to(body_top_recess_d, 17.6) &&
       close_to(body_top_recess_depth, 2.2),
    "Body top recess must be 17.6 x 2.2 mm");
assert(close_to(captured_body_thickness, 33.8),
    "Captured body thickness below the recess must be 33.8 mm");
assert(close_to(collar_capture_span, 34.0) &&
       close_to(collar_axial_movement, 0.2),
    "The collar must retain 0.2 mm nominal axial movement");
assert(close_to(fixed_corridor_w, 8.0),
    "Fixed-body bilateral corridors must be 8.0 mm");
assert(close_to(lip_extra_d, 0.6) &&
       close_to(lip_retaining_shoulder, 0.3) &&
       close_to(lip_insertion_chamfer_deg, 45),
    "The C-shaped snap lip must retain its reviewed OD and chamfer");
assert(close_to(collar_lip_od(16.4), 17.0) &&
       close_to(collar_lip_od(16.5), 17.1) &&
       close_to(collar_lip_od(16.6), 17.2),
    "Each collar lip OD must equal its cavity diameter plus 0.6 mm");
assert(close_to(collar_flex_root_r, 1.5),
    "Collar flex roots must remain rounded to 1.5 mm");
assert(close_to(throat_lead_extra, 1.0),
    "The collar throat must retain its 1.0 mm lead widening");

// Fixed body material around the moving parts.
assert(close_to(min_cavity_web, 4.4),
    str("Minimum cavity-to-cavity web must be 4.4 mm, got ",
        min_cavity_web));
assert(close_to(min_corridor_web, 13.0),
    str("Minimum corridor-to-corridor web must be 13.0 mm, got ",
        min_corridor_web));
assert(close_to(min_cavity_side_wall, 5.7),
    str("Minimum cavity side wall must be 5.7 mm, got ",
        min_cavity_side_wall));
assert(close_to(top_recess_side_wall, 5.2),
    str("Top recess side wall must be 5.2 mm, got ",
        top_recess_side_wall));
assert(close_to(track_outer_r, 9.6) &&
       close_to(track_side_clearance, 0.25) &&
       close_to(track_to_arm_edge, 4.4) &&
       close_to(track_to_next_track, 1.8),
    "The 180-degree stop tracks must fit within the 21 mm body pitch");
assert(close_to(track_travel_deg, 180),
    "The collar stop track must provide 180 degrees of travel");
assert(close_to(endpoint_detent_engagement, 0.18),
    "Endpoint detent engagement must be 0.18 mm");
assert(flexible_detent_location == "collar",
    "The flexible detent must be on the replaceable collar");
assert(fixed_web_has_flexible_feature == false,
    "Fixed body webs must not contain flexible features");
assert(close_to(tool_slot_depth, 1.0),
    "The collar must include a 1.0 mm recessed top tool slot");

// Exact assembled stop poses and detent coincidence.
assert(close_to(right_throat_pose_deg, 0) &&
       close_to(midpoint_throat_pose_deg, 90) &&
       close_to(left_throat_pose_deg, 180),
    "The analysed throat poses must be right/midpoint/left at 0/90/180 degrees");
assert(close_to(stop_tab_base_angle, 90),
    "The stop tab must remain 90 degrees ahead of the throat");
assert(close_to(right_stop_tab_angle, 90) &&
       close_to(midpoint_stop_tab_angle, 180) &&
       close_to(left_stop_tab_angle, 270),
    "The stop tab poses must follow 90/180/270 degrees");
assert(close_to(track_start_angle, right_stop_tab_angle) &&
       close_to(track_end_angle, left_stop_tab_angle) &&
       close_to(track_travel_deg, 180),
    "The tab track must run from 90 to 270 degrees over exactly 180 degrees");
assert(
    track_endpoint_overrun_deg >= 10 ||
    (
        endpoint_detent_strategy == "coincident_centres" &&
        right_detent_centre_mismatch <= 0.05 &&
        left_detent_centre_mismatch <= 0.05
    ),
    "Endpoints need at least 10 degrees overrun or coincident detent centres");
assert(close_to(
           track_tab_envelope_start_angle,
           track_start_angle - stop_tab_half_angle_deg
       ) &&
       close_to(
           track_tab_envelope_end_angle,
           track_end_angle + stop_tab_half_angle_deg
       ) &&
       close_to(
           track_tab_envelope_sweep_deg,
           track_travel_deg + 2 * stop_tab_half_angle_deg
       ),
    "The direct track sector must cover the complete moving-tab envelope");
assert(close_to(hard_stop_travel_deg, 180),
    str("Hard-stop travel changed: ", hard_stop_travel_deg));
assert(right_throat_alignment_error_deg <= 2 &&
       left_throat_alignment_error_deg <= 2,
    str(
        "Left/right throat alignment exceeds +/-2 degrees: ",
        right_throat_alignment_error_deg, "/",
        left_throat_alignment_error_deg
    ));
assert(right_pose_inside_track &&
       midpoint_pose_inside_track &&
       left_pose_inside_track,
    "Right, midpoint and left tab poses must all remain inside the track path");
assert(min_track_radial_clearance >= 0.25 &&
       track_vertical_clearance >= 0.2,
    str(
        "Stop tab lacks track clearance: radial ",
        min_track_radial_clearance,
        ", vertical ", track_vertical_clearance
    ));
assert(right_detent_centre_mismatch <= 0.05 &&
       left_detent_centre_mismatch <= 0.05,
    str(
        "Detent/pocket centre mismatch exceeds 0.05 mm: ",
        right_detent_centre_mismatch, "/",
        left_detent_centre_mismatch
    ));
assert(close_to(right_detent_centre_mismatch, 0) &&
       close_to(left_detent_centre_mismatch, 0),
    "The redesigned detent centres must coincide analytically at both stops");
assert(endpoint_detent_engagement >= 0.15 &&
       endpoint_detent_engagement <= 0.20,
    "Detent engagement must remain within 0.15..0.20 mm");
assert(close_to(
           detent_centre_r + detent_r - track_outer_r,
           endpoint_detent_engagement
       ),
    "The radial detent interference must equal the specified engagement");
assert(flexible_detent_location == "collar",
    "The radial detent must remain on the replaceable collar");

// Assembly cradles and indexed loose-component locations.
assert(close_to(matrix_cradle_hole_d, 22) &&
       matrix_cradle_hole_d >= 18,
    "The tolerance cradle needs a 22 mm through-hole under every collar");
assert(close_to(structural_cradle_hole_d, 22) &&
       structural_cradle_hole_d >= 18,
    "The structural cradle needs a 22 mm through-hole under every collar");
assert(close_to(matrix_cradle_pocket_depth, 1.2) &&
       close_to(structural_cradle_pocket_depth, 1.2),
    "Both cradles must use 1.2 mm shallow locating pockets");
assert(len(matrix_cradle_hole_centres) == 9 &&
       matrix_cradle_hole_centres == [
           [-36, -48], [0, -48], [36, -48],
           [-36, 0], [0, 0], [36, 0],
           [-36, 48], [0, 48], [36, 48]
       ],
    str("Unexpected tolerance-cradle hole centres: ",
        matrix_cradle_hole_centres));
assert(len(matrix_cradle_pocket_centres) == 18,
    "The tolerance cradle must locate all 18 socket halves");
assert(matrix_cradle_pocket_centres[0] == [-36, -60] &&
       matrix_cradle_pocket_centres[1] == [-36, -36] &&
       matrix_cradle_pocket_centres[16] == [36, 36] &&
       matrix_cradle_pocket_centres[17] == [36, 60],
    str("Tolerance-cradle pocket indexing changed: ",
        matrix_cradle_pocket_centres));
assert(matrix_half_labels == [
        ["A1-S", "A1-N"], ["A2-S", "A2-N"],
        ["A3-S", "A3-N"], ["B1-S", "B1-N"],
        ["B2-S", "B2-N"], ["B3-S", "B3-N"],
        ["C1-S", "C1-N"], ["C2-S", "C2-N"],
        ["C3-S", "C3-N"]
    ],
    "Both halves of every tolerance station need matching, unambiguous IDs");
assert(close_to(matrix_cradle_lip_radial_clearance, 2.4),
    str(
        "Tolerance cradle lip clearance must be 2.4 mm, got ",
        matrix_cradle_lip_radial_clearance
    ));
assert(matrix_cradle_lip_bottom_z > 0,
    "The installed lower lip must remain unobstructed inside the cradle through-hole");
assert(structural_cradle_hole_centres == [
        [0, 23], [0, 44], [0, 65]
    ],
    str("Unexpected structural-cradle hole centres: ",
        structural_cradle_hole_centres));
assert(structural_section_ranges == [
        [-3, 19], [27, 40], [48, 61], [69, 76]
    ],
    str("Structural cradle must locate all four loose sections: ",
        structural_section_ranges));
assert(len(structural_cradle_pocket_records) == 4,
    "The structural cradle must contain four indexed section pockets");
assert(close_to(structural_cradle_lip_radial_clearance, 2.45) &&
       structural_cradle_lip_bottom_z > 0,
    "The structural cradle must clear every installed lower snap lip");

// SKÅDIS: exactly two centred load hooks and no centre feature.
assert(skadis_hook_x == [-20, 20] &&
       close_to(skadis_hook_z, 58),
    "SKADIS hooks must be exactly X +/-20 at Z = 58 mm");
assert(len(skadis_hook_x) == 2 &&
       pairwise_spacings(skadis_hook_x) == [40],
    "SKADIS must use exactly two hooks at 40 mm pitch");
assert(skadis_upper_pad_x == [-20, 20],
    "SKADIS upper pads must align to the two hooks");
assert(skadis_lower_pad_x == [-20, 20] &&
       close_to(skadis_lower_pad_z, 11),
    "SKADIS lower pads must be X +/-20 at Z = 11 mm");
assert(search(0, skadis_hook_x) == [] &&
       search(0, skadis_upper_pad_x) == [] &&
       search(0, skadis_lower_pad_x) == [],
    "SKADIS must not contain a centre hook or centre pad");
assert(close_to(skadis_hook_edge_margin, 13.9),
    str("Unexpected SKADIS hook edge margin: ",
        skadis_hook_edge_margin));
assert(close_to(skadis_lower_pad_edge_margin, 7.0),
    str("Unexpected lower pad edge margin: ",
        skadis_lower_pad_edge_margin));

// Multiboard: four centred 50 x 50 mm positions.
assert(multiboard_mount_x == [-25, 25] &&
       multiboard_mount_z == [11, 61],
    "Multiboard mounts must be X +/-25 and Z 11/61");
assert(multiboard_mount_count == 4,
    "The Multiboard back must contain exactly four mounting positions");
assert(pairwise_spacings(multiboard_mount_x) == [50] &&
       pairwise_spacings(multiboard_mount_z) == [50],
    "Multiboard mounting pattern must be 50 x 50 mm");
assert(close_to(multiboard_edge_margin, 6.8),
    str("Multiboard edge margin must be 6.8 mm, got ",
        multiboard_edge_margin));
assert(multiboard_insert_cavity_clearance > 7.9,
    str("Multiboard-to-insert cavity clearance is too small: ",
        multiboard_insert_cavity_clearance));
assert(multiboard_key_clearance > 10.5,
    str("Multiboard-to-key clearance is too small: ",
        multiboard_key_clearance));

// Export safety and expected mesh topology.
assert(full_body_export_supported == false,
    "The ten-collar body must remain preview-only");
assert(!mode_is_printable("preview_concept_skadis") &&
       !mode_is_printable("preview_concept_multiboard"),
    "Concept preview modes must never be printable export modes");
assert(mode_is_printable("tolerance_matrix_fixture") &&
       mode_is_printable("tolerance_matrix_collars") &&
       mode_is_printable("tolerance_matrix_cradle") &&
       mode_is_printable("structural_coupon_body") &&
       mode_is_printable("structural_coupon_collars") &&
       mode_is_printable("structural_coupon_cradle") &&
       mode_is_printable("skadis_back") &&
       mode_is_printable("multiboard_back") &&
       mode_is_printable("skadis_fit_coupon") &&
       mode_is_printable("multiboard_fit_coupon"),
    "All ten approved prototype exports need printable modes");
assert(expected_component_count("tolerance_matrix_fixture") == 18,
    "The nine bilateral fixture sockets must yield 18 body halves");
assert(expected_component_count("tolerance_matrix_collars") == 9,
    "The tolerance collar plate must contain nine labelled collars");
assert(expected_component_count("tolerance_matrix_cradle") == 1,
    "The tolerance assembly cradle must be one connected mesh");
assert(expected_component_count("structural_coupon_body") == 4,
    "Three bilateral corridors must split the structural body into four parts");
assert(expected_component_count("structural_coupon_collars") == 3,
    "The structural collar plate must contain three collars");
assert(expected_component_count("structural_coupon_cradle") == 1,
    "The structural assembly cradle must be one connected mesh");
assert(expected_component_count("skadis_back") == 1 &&
       expected_component_count("multiboard_back") == 1 &&
       expected_component_count("skadis_fit_coupon") == 1 &&
       expected_component_count("multiboard_fit_coupon") == 1,
    "Each mounting back and fit coupon must remain one connected mesh");

echo("V2_3_PROTOTYPE_DIMENSION_TESTS_PASSED");

// A tiny sentinel gives command-line OpenSCAD a non-empty successful output.
cube([0.1, 0.1, 0.1]);
