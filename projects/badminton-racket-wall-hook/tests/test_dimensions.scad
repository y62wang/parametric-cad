// Dimensional contract for the compact v2.2 badminton rack.
// Run with:
// openscad --hardwarnings -D 'render_mode="none"' \
//   -o /tmp/badminton_dimensions.stl tests/test_dimensions.scad

include <../src/badminton_hook.scad>

function close_to(actual, expected, tolerance = 0.001) =
    abs(actual - expected) <= tolerance;

function opening_count_at(records, centre) =
    len([
        for (record = records)
            if (record[0] == centre[0] && record[1] == centre[1])
                1
    ]);

function side_count(records, side) =
    len([for (record = records) if (record[2] == side) 1]);

function pairwise_spacings(values) = [
    for (i = [0 : len(values) - 2])
        values[i + 1] - values[i]
];

function distance_2d(a, b) =
    sqrt(pow(a[0] - b[0], 2) + pow(a[1] - b[1], 2));

expected_slot_y = [
    for (i = [0 : num_slots - 1])
        17 + i * 20
];
expected_alternating_sides = [
    "left", "right", "left", "right", "left",
    "right", "left", "right", "left", "right"
];
expected_reverse_sides = [
    "right", "left", "right", "left", "right",
    "left", "right", "left", "right", "left"
];

slot_centres = slot_centres_for();
alternating_openings =
    slot_opening_records_for("alternating", false);
reverse_openings =
    slot_opening_records_for("alternating", true);
left_openings = slot_opening_records_for("left", false);
right_openings = slot_opening_records_for("right", false);

assert(valid_entry_pattern("alternating") &&
       valid_entry_pattern("left") &&
       valid_entry_pattern("right"),
    "Alternating, all-left and all-right must be valid entry patterns");
assert(!valid_entry_pattern("both"),
    "True bilateral openings must remain invalid");
assert(len(slot_centres) == 10,
    "The v2.2 body must expose ten shared pocket centres");
assert([for (centre = slot_centres) centre[0]] ==
       [for (i = [0 : num_slots - 1]) 0],
    "Every pocket centre must have X = 0");
assert([for (centre = slot_centres) centre[1]] == expected_slot_y,
    "Pocket Y centres must remain 17 + i * 20");

assert(len(alternating_openings) == len(slot_centres) &&
       len(reverse_openings) == len(slot_centres) &&
       len(left_openings) == len(slot_centres) &&
       len(right_openings) == len(slot_centres),
    "Every body pattern must create one opening record per pocket");
assert(min([
           for (centre = slot_centres)
               opening_count_at(alternating_openings, centre)
       ]) == 1 &&
       max([
           for (centre = slot_centres)
               opening_count_at(alternating_openings, centre)
       ]) == 1,
    "Every alternating pocket must have exactly one opening");
assert(side_count(alternating_openings, "left") == 5 &&
       side_count(alternating_openings, "right") == 5,
    "Default alternating mode must have five left and five right openings");
assert(side_count(reverse_openings, "left") == 5 &&
       side_count(reverse_openings, "right") == 5,
    "Reverse alternating mode must have five openings on each side");
assert([for (record = alternating_openings) record[2]] ==
       expected_alternating_sides,
    "Default alternating mode must begin on the left");
assert([for (record = reverse_openings) record[2]] ==
       expected_reverse_sides,
    "Reverse alternating mode must begin on the right");
assert([for (record = left_openings) record[2]] ==
       [for (i = [0 : num_slots - 1]) "left"],
    "All-left mode must open every pocket on the left");
assert([for (record = right_openings) record[2]] ==
       [for (i = [0 : num_slots - 1]) "right"],
    "All-right mode must open every pocket on the right");

assert(num_slots == 10,
    str("Expected 10 racket slots, got ", num_slots));
assert(close_to(shaft_d, 7.2),
    str("Expected a 7.2 mm nominal shaft, got ", shaft_d));
assert(close_to(pocket_d, 8.8),
    str("Expected an 8.8 mm pocket, got ", pocket_d));
assert(close_to(entry_gap, 6.6),
    str("Expected a 6.6 mm entry, got ", entry_gap));
assert(close_to(slot_pitch, 20),
    str("Expected 20 mm racket pitch, got ", slot_pitch));
assert(close_to(first_slot_y, 17),
    str("Expected first pocket at Y = 17 mm, got ", first_slot_y));
assert(close_to(wall_t, 6.6),
    str("Expected a 6.6 mm opposite-side ligament, got ", wall_t));
assert(close_to(arm_w, 22) && close_to(arm_h, 28),
    str("Expected a 22 x 28 mm arm, got ", arm_w, " x ", arm_h));
assert(close_to(arm_z0, 32) && close_to(arm_z0 + arm_h, 60),
    "The arm must occupy Z = 32..60 mm");
assert(close_to(heel_w, 92) &&
       close_to(heel_h, 60) &&
       close_to(heel_t, 8),
    "The compact heel must be 92 x 60 x 8 mm");
assert(close_to(root_flare_w, 60),
    "The root flare must be 60 mm wide");
assert(close_to(root_transition_end_y, 12) &&
       close_to(gusset_end_y, 12),
    "The root transition and gussets must end at Y = 12 mm");
assert(close_to(body_tip_y, 205.4),
    str("Expected 205.4 mm projection, got ", body_tip_y));
assert(close_to(body_side_print_length, 208.4),
    str("Expected 208.4 mm body print length, got ",
        body_side_print_length));
assert(close_to(body_print_support_gap, 0),
    str("The body export must have no arm support gap, got ",
        body_print_support_gap));
assert(close_to(heel_h, arm_z0 + arm_h),
    "The heel and arm tops must share the support-free print plane");
assert(close_to(body_print_arm_contact_width, 16) &&
       close_to(body_print_heel_contact_width, 84),
    "The inverted body contact widths must remain 16 mm and 84 mm");
assert(close_to(body_print_nominal_coplanar_area, 3814.4),
    str("Unexpected nominal first-layer contact area: ",
        body_print_nominal_coplanar_area));
assert(body_nominal_dimensions_for("alternating", false) ==
       body_nominal_dimensions_for("alternating", true),
    "Alternating direction must not change body dimensions");
assert(body_nominal_dimensions_for("alternating", false) ==
       body_nominal_dimensions_for("left", false) &&
       body_nominal_dimensions_for("alternating", false) ==
       body_nominal_dimensions_for("right", false),
    "All body entry patterns must share dimensions");
assert(first_slot_y - pocket_r - root_transition_end_y >= 0.5 &&
       close_to(
           first_slot_y - pocket_r - root_transition_end_y,
           0.6
       ),
    "The root flare needs 0.6 mm clearance to the first pocket");
assert(first_slot_y - pocket_r - gusset_end_y >= 0.5 &&
       close_to(first_slot_y - pocket_r - gusset_end_y, 0.6),
    "The gussets need 0.6 mm clearance to the first pocket");
assert(close_to(last_slot_y, 197),
    "The last pocket centre must be at Y = 197 mm");
assert(close_to(last_slot_y + pocket_r + tip_margin, body_tip_y),
    "The final pocket must retain the specified tip margin");

assert(close_to(key_w, 48) &&
       close_to(key_h, 30) &&
       close_to(key_depth, 3) &&
       close_to(key_z0, 17),
    "The positive key must be 48 x 30 x 3 mm at Z = 17 mm");
assert(close_to(body_to_back_z, 2),
    "The mounted body-to-back vertical offset must be 2 mm");
assert(body_bolt_x == [-30, 30] && body_bolt_z == [18, 45],
    "The body fasteners must be at X +/-30 and Z 18/45");
assert(interface_fastener_count == 4,
    str("Expected four body fasteners, got ", interface_fastener_count));
assert(close_to(m4_clearance_d, 4.5) &&
       close_to(body_counterbore_d, 8.2) &&
       close_to(body_counterbore_depth, 4.2) &&
       close_to(insert_entry_d, 5.9) &&
       close_to(insert_tip_d, 5.4) &&
       close_to(insert_depth, 6.2),
    "The reviewed M4 clearance, counterbore and insert system must remain");

body_clearance_to_key = min([
    for (x = body_bolt_x)
        abs(x) - m4_clearance_d / 2 - key_w / 2
]);
body_counterbore_side_margin =
    heel_w / 2 - max(body_bolt_x) - body_counterbore_d / 2;
body_counterbore_bottom_margin =
    min(body_bolt_z) - body_counterbore_d / 2;
body_counterbore_top_margin =
    heel_h - max(body_bolt_z) - body_counterbore_d / 2;
insert_to_key_side_wall = min([
    for (x = body_bolt_x)
        abs(x) - insert_entry_d / 2 -
        (key_w / 2 + key_clearance_per_side)
]);

assert(close_to(body_clearance_to_key, 3.75),
    str("Body M4-to-key clearance changed: ", body_clearance_to_key));
assert(close_to(body_counterbore_side_margin, 11.9) &&
       close_to(body_counterbore_bottom_margin, 13.9) &&
       close_to(body_counterbore_top_margin, 10.9),
    "Body counterbore edge margins must remain 11.9/13.9/10.9 mm");
assert(close_to(back_t - insert_depth, 1.8),
    "Heat-set insert pockets need a 1.8 mm rear wall");
assert(key_depth + key_depth_clearance < back_t,
    "The key recess must leave material behind it");
assert(close_to(insert_to_key_side_wall, 2.8),
    str("Insert-to-key side wall must be 2.8 mm, got ",
        insert_to_key_side_wall));

assert(close_to(skadis_back_w, 100) &&
       close_to(skadis_back_h, 72) &&
       close_to(back_t, 8),
    "The SKADIS back must be 100 x 72 x 8 mm");
assert(close_to(skadis_slot_w, 5) &&
       close_to(skadis_slot_h, 15),
    "SKADIS nominal slots must remain 5 x 15 mm");
assert(skadis_hook_x == [-40, 0, 40],
    "SKADIS must use three horizontally aligned hooks");
assert(pairwise_spacings(skadis_hook_x) == [40, 40] &&
       max(skadis_hook_x) - min(skadis_hook_x) == 80,
    "SKADIS hooks must use 40 mm pitch over an 80 mm span");
assert(close_to(skadis_hook_z, 58),
    "SKADIS hook row must sit at Z = 58 mm");
assert(skadis_hook_w <= skadis_slot_w - 0.6,
    "SKADIS hooks need at least 0.3 mm clearance on each slot side");
assert(skadis_hook_tongue_h <= skadis_slot_h - 2,
    "SKADIS tongues need insertion clearance within a nominal slot");
assert(skadis_hook_neck_h == 4 &&
       skadis_hook_tongue_h == 12,
    "SKADIS latch must retain its 4 mm neck and 12 mm tongue");
assert(skadis_lower_locator_x == [],
    "The compact SKADIS back must not use a rigid lower locator row");
assert(skadis_upper_pad_x == skadis_hook_x,
    "Every SKADIS hook needs an aligned upper bearing pad");
assert(skadis_lower_pad_x == [-30, 0, 30] &&
       close_to(skadis_lower_pad_z, 10),
    "SKADIS must use three lower compression pads near Z = 10 mm");

skadis_hook_edge_margin =
    skadis_back_w / 2 - max(skadis_hook_x) - skadis_hook_w / 2;
skadis_upper_pad_edge_margin =
    skadis_back_w / 2 - max(skadis_upper_pad_x) -
    skadis_upper_pad_w / 2;
skadis_lower_pad_edge_margin =
    skadis_back_w / 2 - max(skadis_lower_pad_x) -
    skadis_lower_pad_w / 2;

assert(close_to(skadis_hook_edge_margin, 7.9),
    str("Outer SKADIS hook edge margin must be 7.9 mm, got ",
        skadis_hook_edge_margin));
assert(close_to(skadis_upper_pad_edge_margin, 4),
    str("Upper SKADIS pad edge margin must be 4 mm, got ",
        skadis_upper_pad_edge_margin));
assert(close_to(skadis_lower_pad_edge_margin, 8),
    str("Lower SKADIS pad edge margin must be 8 mm, got ",
        skadis_lower_pad_edge_margin));
assert(skadis_coupon_x == skadis_hook_x &&
       skadis_coupon_hook_z == skadis_hook_z,
    "The SKADIS coupon must reproduce all three hook positions");
assert(skadis_coupon_lower_pad_x == skadis_lower_pad_x &&
       skadis_coupon_lower_pad_z == skadis_lower_pad_z,
    "The SKADIS coupon must reproduce all lower compression pads");
assert(skadis_coupon_w == skadis_back_w &&
       skadis_coupon_h == skadis_back_h,
    "The SKADIS coupon must reproduce the full 80 mm hook span");

assert(close_to(multiboard_back_w, 100) &&
       close_to(multiboard_back_h, 72) &&
       close_to(back_t, 8),
    "The Multiboard back must be 100 x 72 x 8 mm");
assert(close_to(multiboard_cell_pitch, 25),
    "Multiboard base grid must remain 25 mm");
assert(multiboard_mount_x == [-25, 25] &&
       multiboard_mount_z == [11, 61],
    "Multiboard must use X +/-25 and Z 11/61");
assert(pairwise_spacings(multiboard_mount_x) == [50] &&
       pairwise_spacings(multiboard_mount_z) == [50],
    "Multiboard mounting positions must form a 50 x 50 mm pattern");
assert(len(multiboard_mount_x) * len(multiboard_mount_z) == 4,
    "The Multiboard back must expose four mounting positions");
assert(multiboard_coupon_mount_x == multiboard_mount_x &&
       multiboard_coupon_mount_z == multiboard_mount_z,
    "The Multiboard coupon must reproduce all four positions");

multiboard_side_margin =
    multiboard_back_w / 2 - max(multiboard_mount_x) -
    multiboard_counterbore_d / 2;
multiboard_bottom_margin =
    min(multiboard_mount_z) - multiboard_counterbore_d / 2;
multiboard_top_margin =
    multiboard_back_h - max(multiboard_mount_z) -
    multiboard_counterbore_d / 2;

assert(close_to(multiboard_side_margin, 20.8) &&
       close_to(multiboard_bottom_margin, 6.8) &&
       close_to(multiboard_top_margin, 6.8),
    "Multiboard counterbore edge margins must be 20.8/6.8/6.8 mm");

interface_insert_positions = [
    for (x = body_bolt_x)
        for (z = body_bolt_global_z)
            [x, z]
];
multiboard_hardware_positions = [
    for (x = multiboard_mount_x)
        for (z = multiboard_mount_z)
            [x, z]
];
minimum_hardware_insert_distance = min([
    for (mount = multiboard_hardware_positions)
        for (insert = interface_insert_positions)
            distance_2d(mount, insert)
]);
minimum_hardware_insert_wall =
    minimum_hardware_insert_distance -
    multiboard_counterbore_d / 2 -
    insert_entry_d / 2;
lower_multiboard_to_key_margin =
    back_key_z0 - key_clearance_per_side -
    (min(multiboard_mount_z) + multiboard_counterbore_d / 2);
upper_multiboard_to_key_margin =
    (max(multiboard_mount_z) - multiboard_counterbore_d / 2) -
    (back_key_z0 + key_h + key_clearance_per_side);

assert(minimum_hardware_insert_wall >= 3.14 &&
       close_to(minimum_hardware_insert_wall, 3.14563, 0.001),
    str("Multiboard-to-insert cavity wall must be about 3.15 mm, got ",
        minimum_hardware_insert_wall));
assert(close_to(lower_multiboard_to_key_margin, 3.55),
    str("Lower Multiboard-to-key margin must be 3.55 mm, got ",
        lower_multiboard_to_key_margin));
assert(close_to(upper_multiboard_to_key_margin, 7.55),
    str("Upper Multiboard-to-key margin must be 7.55 mm, got ",
        upper_multiboard_to_key_margin));

assert(spacing_coupon_num_slots == 3,
    "The racket spacing coupon must contain three slots");
assert(close_to(spacing_coupon_pitch, slot_pitch) &&
       close_to(spacing_coupon_pitch, 20),
    "The racket spacing coupon must reproduce the exact 20 mm pitch");
assert(spacing_coupon_centres == [
           [0, spacing_coupon_first_y],
           [0, spacing_coupon_first_y + 20],
           [0, spacing_coupon_first_y + 40]
       ],
    "The spacing coupon centres must remain aligned at X = 0");
assert(pairwise_spacings(
           [for (centre = spacing_coupon_centres) centre[1]]
       ) == [20, 20],
    "The spacing coupon must have two exact 20 mm intervals");
assert(close_to(spacing_coupon_pocket_d, pocket_d) &&
       close_to(spacing_coupon_entry_gap, entry_gap) &&
       close_to(spacing_coupon_arm_w, arm_w) &&
       close_to(spacing_coupon_arm_h, arm_h),
    "The spacing coupon must use the full rack pocket and arm geometry");
assert(spacing_coupon_opening_records == [
           [0, spacing_coupon_first_y, "left"],
           [0, spacing_coupon_first_y + 20, "right"],
           [0, spacing_coupon_first_y + 40, "left"]
       ],
    "The spacing coupon must provide left/right/left insertion");
assert(close_to(spacing_coupon_length, 56.8),
    str("Expected a 56.8 mm spacing coupon, got ",
        spacing_coupon_length));
assert(close_to(spacing_coupon_print_support_gap, 0),
    "The racket spacing coupon must print support-free");

echo("V2_2_DIMENSION_TESTS_PASSED");

// A tiny sentinel gives command-line OpenSCAD a non-empty successful output.
cube([0.1, 0.1, 0.1]);
