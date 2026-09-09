// =============================================================
// example_desk_tray.scad
// Demo: a few containers matching what MakerWorld shows.
// Uncomment the layout mode you want.
// =============================================================

include <organizer_layout.scad>

// Optional: show the drawer shell for context
// drawer_outline();


// ─────────────────────────────────────────────────────────────
// Container library — define your shapes here
// ─────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────
// INSERT EXAMPLES
// ─────────────────────────────────────────────────────────────

// Pen holder — vertical wells, pens stand upright
pen_holder = [
    ["inner_w",  80],  ["inner_l",  80],  ["height", 95],
    ["wall",  1.5],    ["floor", 1.2],    ["corner_r", 4],
    ["insert_type",  "circle_array"],
    ["insert_d",     12],    // standard pen/marker Ø
    ["insert_depth", 55],    // pen sits ~55mm deep
    ["insert_gap",    3],
    ["color", [0.80, 0.90, 1.00]]
];

// Pencil/brush flat tray — horizontal cradle grooves
brush_tray = [
    ["inner_w", 160],  ["inner_l",  60],  ["height", 25],
    ["wall",  1.5],    ["floor", 1.2],    ["corner_r", 3],
    ["insert_type",  "cradle"],
    ["insert_d",      8],    // pencil Ø ~7–8mm
    ["insert_gap",    3],
    ["color", [1.00, 0.95, 0.75]]
];

// Business card / credit card holder — thin standing slots
card_holder = [
    ["inner_w",  90],  ["inner_l",  60],  ["height", 35],
    ["wall",  1.5],    ["floor", 1.2],    ["corner_r", 2],
    ["insert_type",  "slot_array"],
    ["insert_d",      1],    // card thickness ~0.8mm; 1mm gives easy fit
    ["insert_depth", 25],
    ["insert_gap",    4],
    ["color", [0.95, 0.88, 1.00]]
];

// Eraser / USB / small item tray — rectangular pockets
eraser_tray = [
    ["inner_w",  90],  ["inner_l",  90],  ["height", 25],
    ["wall",  1.5],    ["floor", 1.2],    ["corner_r", 3],
    ["insert_type",    "rectangle_array"],
    ["insert_w",        16],   // eraser width
    ["insert_l",        40],   // eraser length
    ["insert_depth",    15],
    ["insert_gap",       3],
    ["color", [0.90, 1.00, 0.88]]
];


// ─────────────────────────────────────────────────────────────
// Plain containers (no insert) — original examples
// ─────────────────────────────────────────────────────────────

// Tall pen/pencil cup
pen_cup = [
    ["inner_w",  50],
    ["inner_l",  50],
    ["height",   95],
    ["wall",      1.5],
    ["floor",     1.2],
    ["corner_r",  5],
    ["finger_cut",  false],
    ["drain_holes", 0],
    ["color", [0.85, 0.92, 1.00]]
];

// Wide shallow tray (pens lying flat)
wide_tray = [
    ["inner_w",  107],
    ["inner_l",   67],
    ["height",    30],
    ["wall",       1.5],
    ["floor",      1.2],
    ["corner_r",   2],
    ["finger_cut",  true],
    ["finger_wall", "front"],
    ["finger_r",    10],
    ["color", [1.00, 0.95, 0.80]]
];

// Small clips box
clip_box = [
    ["inner_w",  40],
    ["inner_l",  55],
    ["height",   35],
    ["wall",      1.5],
    ["floor",     1.2],
    ["corner_r",  3],
    ["label",     "CLIPS"],
    ["color", [0.90, 1.00, 0.90]]
];

// Tall narrow (rulers / scissors)
ruler_slot = [
    ["inner_w",  30],
    ["inner_l",  80],
    ["height",   60],
    ["wall",      1.5],
    ["floor",     1.2],
    ["corner_r",  2],
    ["color", [1.00, 0.88, 0.88]]
];

// Small square (erasers / tacks)
small_square = [
    ["inner_w",  35],
    ["inner_l",  35],
    ["height",   25],
    ["wall",      1.5],
    ["floor",     1.2],
    ["corner_r",  4],
    ["color", [0.92, 0.92, 0.92]]
];


// ─────────────────────────────────────────────────────────────
// MODE A — Explicit placement (like MakerWorld)
//
// place_boxes() automatically checks every pair for overlap and
// halts with an error + console message if any are found.
//
// Coordinates = outer bottom-left corner of each container.
// ─────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────
// MODE A — Auto placement (recommended)
//
// Just list the specs in priority order.
// find_position() places each one at the bottom-left-most spot
// that doesn't overlap anything already placed.
// ─────────────────────────────────────────────────────────────

auto_place([
    pen_cup,
    wide_tray,
    ruler_slot,
    clip_box,
    small_square,
    small_square
]);


// ─────────────────────────────────────────────────────────────
// MODE B — Explicit placement with auto collision guard
//
// Set your own x/y; place_boxes() asserts if anything overlaps.
// If it overlaps, switch to auto_place or adjust coordinates.
// ─────────────────────────────────────────────────────────────

/*
place_boxes([
    [  0,   0,  pen_cup     ],
    [ 56,   0,  wide_tray   ],
    [  0,  56,  ruler_slot  ],
    [ 56,  73,  clip_box    ],
    [145,   0,  small_square],
    [145,  40,  small_square]
]);
*/


// ─────────────────────────────────────────────────────────────
// Debug: show AABB footprints for any item list
// ─────────────────────────────────────────────────────────────

// show_footprints(_pack_all([pen_cup, wide_tray, ruler_slot,
//                            clip_box, small_square, small_square],
//                           [DRAWER_W, DRAWER_L], ORG_GAP));


// ─────────────────────────────────────────────────────────────
// MODE B — Auto row packing
//
// Just list the containers; they pack left-to-right,
// wrapping to a new row when the width runs out.
// ─────────────────────────────────────────────────────────────

/*
row_layout(
    specs  = [pen_cup, wide_tray, clip_box, ruler_slot,
              small_square, small_square],
    region = [DRAWER_W, DRAWER_L],
    gap    = ORG_GAP
);
*/
