// =============================================================
// test_dimensions.scad
// Dimension-grid tests — all containers must have outer w, l,
// and height that are multiples of 10 mm.
//
// Run: openscad --export /tmp/test_dimensions.stl test_dimensions.scad
//   → exits 0 (pass) or aborts with assertion message (fail)
//
// Press F5 / F6 to run interactively.
// =============================================================

include <organizer_box.scad>

$fn = 32;

// ── Guard module ──────────────────────────────────────────────
// Wraps organizer_box() with dimension assertions.
// All outer dimensions must be exact multiples of 10 mm.

module box10(spec, label="box") {
    ow = box_outer_w(spec);
    ol = box_outer_l(spec);
    oh = ocfg(spec, "h", ocfg(spec, "height", 0));

    assert(abs(ow % 10) < 0.001,
           str("[", label, "] outer w=", ow, " is not a multiple of 10"));
    assert(abs(ol % 10) < 0.001,
           str("[", label, "] outer l=", ol, " is not a multiple of 10"));
    assert(abs(oh % 10) < 0.001,
           str("[", label, "] height=", oh, " is not a multiple of 10"));

    echo(str("PASS: ", label,
             "  outer=", ow, "×", ol, "×", oh));
    organizer_box(spec);
}


// ─────────────────────────────────────────────────────────────
// TEST 1 — plain box, 60×50×30
// ─────────────────────────────────────────────────────────────
box10([
    ["w",  60], ["l",  50], ["height", 30],
    ["wall", 1.5], ["corner_r", 3],
    ["color", [0.75, 0.88, 1.00]]
], "60×50×30 plain box");


// ─────────────────────────────────────────────────────────────
// TEST 2 — pen holder, circle_array, 80×80×90
// ─────────────────────────────────────────────────────────────
translate([70, 0, 0])
box10([
    ["w",  80], ["l",  80], ["height", 90],
    ["wall", 1.5], ["corner_r", 4],
    ["insert_type",    "circle_array"],
    ["insert_d",       12],
    ["insert_gap",      3],
    ["insert_chamfer",  2],
    ["color", [0.88, 1.00, 0.80]]
], "80×80×90 pen holder");


// ─────────────────────────────────────────────────────────────
// TEST 3 — cradle tray, 160×60×20
// ─────────────────────────────────────────────────────────────
translate([0, 60, 0])
box10([
    ["w", 160], ["l",  60], ["height", 20],
    ["wall", 1.5], ["corner_r", 3],
    ["insert_type", "cradle"],
    ["insert_d",     8],
    ["insert_gap",   3],
    ["color", [1.00, 0.95, 0.72]]
], "160×60×20 cradle");


// ─────────────────────────────────────────────────────────────
// TEST 4 — rectangle pockets (erasers/USB), 90×90×30
// ─────────────────────────────────────────────────────────────
translate([0, 130, 0])
box10([
    ["w",  90], ["l",  90], ["height", 30],
    ["wall", 1.5], ["corner_r", 3],
    ["insert_type",   "rectangle_array"],
    ["insert_w",       16],
    ["insert_l",       40],
    ["insert_depth",   12],
    ["insert_gap",      3],
    ["color", [0.88, 1.00, 0.85]]
], "90×90×30 rectangle array");


// ─────────────────────────────────────────────────────────────
// TEST 5 — card slots, 90×60×40
// ─────────────────────────────────────────────────────────────
translate([100, 130, 0])
box10([
    ["w",  90], ["l",  60], ["height", 40],
    ["wall", 1.5], ["floor", 2.0], ["corner_r", 2],
    ["insert_type", "slot_array"],
    ["insert_d",     1.0],
    ["insert_gap",   4],
    ["color", [0.96, 0.86, 1.00]]
], "90×60×40 card slots");


// ─────────────────────────────────────────────────────────────
// TEST 6 — big combo organizer, 120×80×70
// ─────────────────────────────────────────────────────────────
translate([0, 240, 0])
box10([
    ["w", 120], ["l",  80], ["height", 70],
    ["wall", 1.5], ["corner_r", 4],
    ["inserts", [
        [["type", "circle_array"],
         ["region_x",  0], ["region_w", 60],
         ["insert_d",  12], ["insert_gap", 3], ["insert_chamfer", 2]],
        [["type", "slot_array"],
         ["region_x", 63], ["region_w", 54],
         ["insert_d",  1],  ["insert_gap", 4]]
    ]],
    ["color", [1.00, 0.92, 0.80]]
], "120×80×70 combo");


// ─────────────────────────────────────────────────────────────
// FAIL EXAMPLE (commented out — un-comment to test error output)
// This uses inner_w=80 with wall=1.5 → outer=83 → NOT a multiple of 10
//
// translate([0, 340, 0])
// box10([
//     ["inner_w", 80], ["inner_l", 80], ["height", 90],
//     ["wall", 1.5], ["corner_r", 4],
//     ["color", [1.0, 0.5, 0.5]]
// ], "SHOULD FAIL: inner_w=80 → outer=83");
// ─────────────────────────────────────────────────────────────
