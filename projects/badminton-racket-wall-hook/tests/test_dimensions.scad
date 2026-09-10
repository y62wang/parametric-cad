// Dimensional contract for the compact v2.1 badminton rack.
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
        17.5 + i * 24.5
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
    "The v2 body must expose ten shared pocket centres");
assert([for (centre = slot_centres) centre[0]] ==
       [for (i = [0 : num_slots - 1]) 0],
    "Every pocket centre must have X = 0");
assert([for (centre = slot_centres) centre[1]] == expected_slot_y,
    "Pocket Y centres must remain 17.5 + i * 24.5");

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
    "All-left comparison mode must open every pocket on the left");
assert([for (record = right_openings) record[2]] ==
       [for (i = [0 : num_slots - 1]) "right"],
    "All-right comparison mode must open every pocket on the right");

assert(num_slots == 10,
    str("Expected 10 racket slots, got ", num_slots));
assert(close_to(shaft_d, 7.2),
    str("Expected a 7.2 mm nominal shaft, got ", shaft_d));
assert(close_to(pocket_d, 8.8),
    str("Expected an 8.8 mm pocket, got ", pocket_d));
assert(close_to(entry_gap, 6.6),
    str("Expected a 6.6 mm entry, got ", entry_gap));
assert(close_to(slot_pitch, 24.5),
    str("Expected 24.5 mm racket pitch, got ", slot_pitch));
assert(close_to(arm_w, 25.8) && close_to(arm_h, 28),
    str("Expected a 25.8 x 28 mm arm, got ", arm_w, " x ", arm_h));
assert(close_to(arm_z0, 36) && close_to(arm_z0 + arm_h, 64),
    "The arm must occupy Z = 36..64 mm");
assert(close_to(heel_w, 120) &&
       close_to(heel_h, 64) &&
       close_to(heel_t, 8),
    "The support-free compact heel must be 120 x 64 x 8 mm");
assert(close_to(body_print_support_gap, 0),
    str("The body export must have no arm support gap, got ",
        body_print_support_gap));
assert(close_to(heel_h, arm_z0 + arm_h),
    "The broad heel top and arm top must share one print plane");
assert(body_print_arm_contact_width >= 19 &&
       body_print_heel_contact_width >= 110,
    "The supplied body needs broad arm and heel first-layer contact");
assert(body_print_nominal_coplanar_area >= 5000,
    str("Nominal coplanar contact area is too small: ",
        body_print_nominal_coplanar_area));
assert(body_nominal_dimensions_for("alternating", false) ==
       body_nominal_dimensions_for("alternating", true),
    "Alternating direction must not change body dimensions");
assert(body_nominal_dimensions_for("alternating", false) ==
       body_nominal_dimensions_for("left", false) &&
       body_nominal_dimensions_for("alternating", false) ==
       body_nominal_dimensions_for("right", false),
    "All-left, all-right and alternating bodies must share dimensions");
assert(body_side_print_length <= 250,
    str("The body print axis exceeds 250 mm: ", body_side_print_length));
assert(first_slot_y - pocket_r - root_transition_end_y >= 0.5,
    "The root flare needs at least 0.5 mm clearance to the first pocket");
assert(first_slot_y - pocket_r - gusset_end_y >= 0.5,
    "The gussets obstruct the first pocket");
assert(last_slot_y + pocket_r + tip_margin <= body_tip_y + 0.001,
    "The final pocket does not have the specified tip margin");

assert(close_to(key_w, 72) &&
       close_to(key_h, 34) &&
       close_to(key_depth, 3),
    "The compact positive key must be 72 x 34 x 3 mm");
assert(body_bolt_x == [-42, 42] && body_bolt_z == [18, 49],
    "The body fasteners must be at X +/-42 and Z 18/49");
assert(interface_fastener_count == 4,
    str("Expected four body fasteners, got ", interface_fastener_count));
assert(min([
           for (x = body_bolt_x)
               abs(x) - m4_clearance_d / 2 - key_w / 2
       ]) >= 3,
    "Body screw clearances need at least 3 mm beside the positive key");
assert(heel_w / 2 - max(body_bolt_x) - body_counterbore_d / 2 >= 10,
    "Body counterbores need at least 10 mm to the heel edge");
assert(min(body_bolt_z) - body_counterbore_d / 2 >= 10 &&
       heel_h - max(body_bolt_z) - body_counterbore_d / 2 >= 10,
    "Body counterbores need at least 10 mm to the heel top and bottom");
assert(back_t - insert_depth >= 1.5,
    "Heat-set insert pockets need at least 1.5 mm rear wall");
assert(key_depth + key_depth_clearance < back_t,
    "The key recess must leave material behind it");
assert(min([
           for (x = body_bolt_x)
               abs(x) - insert_entry_d / 2 -
               (key_w / 2 + key_clearance_per_side)
       ]) >= 2.5,
    "Back inserts need at least 2.5 mm beside the key recess");

assert(close_to(skadis_back_w, 140) &&
       close_to(skadis_back_h, 72),
    "The compact SKADIS back must be 140 x 72 mm");
assert(close_to(skadis_slot_w, 5) &&
       close_to(skadis_slot_h, 15),
    "SKADIS nominal slots must remain 5 x 15 mm");
assert(skadis_hook_x == [-60, -20, 20, 60],
    "SKADIS must use four horizontally aligned hooks");
assert(pairwise_spacings(skadis_hook_x) == [40, 40, 40],
    "SKADIS hooks must use 40 mm aligned pitch");
assert(max(skadis_hook_x) - min(skadis_hook_x) == 120,
    "SKADIS hooks must reproduce the full 120 mm span");
assert(close_to(skadis_hook_z, 58),
    "SKADIS hook row must sit at about Z = 58 mm");
assert(skadis_hook_w <= skadis_slot_w - 0.6,
    "SKADIS hooks need at least 0.3 mm clearance on each slot side");
assert(skadis_hook_tongue_h <= skadis_slot_h - 2,
    "SKADIS tongues need insertion clearance within a nominal slot");
assert(skadis_hook_neck_h == 4 &&
       skadis_hook_tongue_h == 12,
    "SKADIS latch must use a 4 mm neck and 12 mm tongue");
assert(skadis_lower_locator_x == [],
    "The compact SKADIS back must not use a rigid lower locator row");
assert(skadis_upper_pad_x == skadis_hook_x,
    "Every SKADIS hook needs an upper bearing pad");
assert(skadis_lower_pad_x == [-45, 0, 45] &&
       close_to(skadis_lower_pad_z, 10),
    "SKADIS must use three lower compression pads near Z = 10 mm");
assert(skadis_back_w / 2 - max(skadis_hook_x) -
       skadis_hook_w / 2 >= 7,
    "Outer SKADIS hooks need at least 7 mm edge material");
assert(skadis_coupon_x == skadis_hook_x &&
       skadis_coupon_hook_z == skadis_hook_z,
    "The SKADIS coupon must reproduce all four hook positions");
assert(skadis_coupon_lower_pad_x == skadis_lower_pad_x &&
       skadis_coupon_lower_pad_z == skadis_lower_pad_z,
    "The SKADIS coupon must reproduce all lower compression pads");
assert(skadis_coupon_w == skadis_back_w &&
       skadis_coupon_h == skadis_back_h,
    "The SKADIS coupon must reproduce the full 120 mm accumulated span");

assert(close_to(multiboard_back_w, 130) &&
       close_to(multiboard_back_h, 72),
    "The compact Multiboard back must be 130 x 72 mm");
assert(close_to(multiboard_cell_pitch, 25),
    "Multiboard base grid must remain 25 mm");
assert(multiboard_mount_x == [-50, 0, 50] &&
       multiboard_mount_z == [11, 61],
    "Multiboard must use X -50/0/50 and Z 11/61");
assert(pairwise_spacings(multiboard_mount_x) == [50, 50] &&
       pairwise_spacings(multiboard_mount_z) == [50],
    "Multiboard mounting positions must form a 50 x 50 pattern");
assert(multiboard_coupon_mount_x == multiboard_mount_x &&
       multiboard_coupon_mount_z == multiboard_mount_z,
    "The Multiboard coupon must reproduce all six mounting positions");
assert(multiboard_back_w / 2 - max(multiboard_mount_x) -
       multiboard_counterbore_d / 2 >= 10,
    "Multiboard outer counterbores need at least 10 mm edge material");
assert(min(multiboard_mount_z) -
       multiboard_counterbore_d / 2 >= 6.5 &&
       multiboard_back_h - max(multiboard_mount_z) -
       multiboard_counterbore_d / 2 >= 6.5,
    "Multiboard counterbores need at least 6.5 mm vertical edge material");

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
assert(minimum_hardware_insert_distance >=
       multiboard_counterbore_d / 2 + insert_entry_d / 2 + 2,
    "Multiboard hardware and body inserts need at least 2 mm separation");
assert(back_key_z0 - key_clearance_per_side -
       (min(multiboard_mount_z) + multiboard_counterbore_d / 2) >= 3,
    "Lower Multiboard counterbores overlap the key recess keep-out");
assert((max(multiboard_mount_z) - multiboard_counterbore_d / 2) -
       (back_key_z0 + key_h + key_clearance_per_side) >= 3,
    "Upper Multiboard counterbores overlap the key recess keep-out");

echo("V2_1_DIMENSION_TESTS_PASSED");

// A tiny sentinel gives command-line OpenSCAD a non-empty successful output.
cube([0.1, 0.1, 0.1]);
