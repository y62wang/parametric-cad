// =============================================================
// test_inserts.scad
// Visual tests — open in OpenSCAD, press F5/F6.
// Containers are spread out for side-by-side comparison.
// =============================================================

include <organizer_layout.scad>

$fn = 48;

// ─────────────────────────────────────────────────────────────
// TEST 1 — circle_array  (pen/pencil/marker holder)
//
// Geometry: SOLID BLOCK with cylindrical bores from top.
// Pens drop in from above; material between bores holds them
// upright. floor = material left at base below the bores.
// ─────────────────────────────────────────────────────────────
organizer_box([
    ["inner_w",  80],   ["inner_l",  80],   ["height", 90],
    ["wall",    1.5],   ["floor",   1.2],   ["corner_r", 4],
    ["insert_type",  "circle_array"],
    ["insert_d",      12],    // standard pen/marker Ø ≈ 10–14 mm
    ["insert_gap",     3],    // material between bores
    ["insert_chamfer", 2],    // funnel at top so pen slides in
    // floor = 1.2 mm left at base (solid base, not full bore)
    ["color", [0.75, 0.88, 1.00]]
]);


// ─────────────────────────────────────────────────────────────
// TEST 2 — circle_array, fine pencils  (narrower bores)
// ─────────────────────────────────────────────────────────────
translate([90, 0, 0])
organizer_box([
    ["inner_w",  70],   ["inner_l",  70],   ["height", 80],
    ["wall",    1.5],   ["floor",   1.2],   ["corner_r", 4],
    ["insert_type",  "pen"],   // "pen" is alias for "circle_array"
    ["insert_d",      8],      // pencil Ø ≈ 7–8 mm
    ["insert_gap",    2],
    ["insert_chamfer",1.5],
    ["color", [0.88, 1.00, 0.80]]
]);


// ─────────────────────────────────────────────────────────────
// TEST 3 — cradle  (pens / brushes lying flat)
//
// Geometry: SHALLOW BOX with thick floor.
// Floor is auto-thickened to ≥ insert_d/2 + 1 mm.
// Horizontal half-cylinder grooves cut into floor surface.
// ─────────────────────────────────────────────────────────────
translate([0, 100, 0])
organizer_box([
    ["inner_w", 160],   ["inner_l",  60],   ["height", 22],
    ["wall",    1.5],   // floor auto-thickened by module
    ["corner_r",  3],
    ["insert_type",  "cradle"],
    ["insert_d",      8],   // pen Ø ≈ 8 mm → floor auto-set to ≥ 5 mm
    ["insert_gap",    3],
    ["color", [1.00, 0.95, 0.72]]
]);


// ─────────────────────────────────────────────────────────────
// TEST 4 — rectangle_array  (erasers / USB drives)
//
// Geometry: BOX with rectangular pockets cut DOWN into floor.
// Floor auto-thickened to ≥ depth + 1 mm.
// ─────────────────────────────────────────────────────────────
translate([0, 170, 0])
organizer_box([
    ["inner_w",  90],   ["inner_l",  90],   ["height", 25],
    ["wall",    1.5],   ["corner_r",  3],
    ["insert_type",    "rectangle_array"],
    ["insert_w",        16],   // eraser width
    ["insert_l",        40],   // eraser length
    ["insert_depth",    12],   // pocket depth (floor auto ≥ 13 mm)
    ["insert_gap",       3],
    ["color", [0.88, 1.00, 0.85]]
]);


// ─────────────────────────────────────────────────────────────
// TEST 5 — slot_array  (business / credit cards edge-on)
//
// Geometry: BOX with thin slots CUT THROUGH the floor.
// Cards drop down through the slots from above.
// ─────────────────────────────────────────────────────────────
translate([100, 170, 0])
organizer_box([
    ["inner_w",  90],   ["inner_l",  60],   ["height", 40],
    ["wall",    1.5],   ["floor",   2.0],   ["corner_r", 2],
    ["insert_type",  "slot_array"],
    ["insert_d",      1.0],   // card thickness ≈ 0.8 mm; 1.0 gives easy fit
    ["insert_gap",    4],
    ["color", [0.96, 0.86, 1.00]]
]);


// ─────────────────────────────────────────────────────────────
// TEST 6 — MULTIPLE INSERTS (pen wells left, card slots right)
//
// Left zone (circle_array): pen bores
// Right zone (slot_array) : card slots
// Detected primary type = circle_array → SOLID BLOCK is used.
// ─────────────────────────────────────────────────────────────
translate([0, 280, 0])
organizer_box([
    ["inner_w", 110],  ["inner_l",  80],  ["height", 70],
    ["wall",    1.5],  ["corner_r",  4],
    ["inserts", [
        // Left 52 mm: pen bores
        [["type",    "circle_array"],
         ["region_x",  0],  ["region_w", 52],
         ["insert_d",  12],
         ["insert_gap",  3],
         ["insert_chamfer", 2]],
        // Right 55 mm: card slots
        // NOTE: mixed solid/floor inserts in one box are experimental.
        // For best results keep all inserts the same type.
        [["type",      "slot_array"],
         ["region_x",  55],  ["region_w", 55],
         ["insert_d",   1],
         ["insert_gap",  4]]
    ]],
    ["color", [1.00, 0.92, 0.80]]
]);


// ─────────────────────────────────────────────────────────────
// TEST 7 — chamfer comparison  (left=0, mid=default, right=3 mm)
// Rotate the model to see the bevel at the bore openings.
// ─────────────────────────────────────────────────────────────
for (i = [0:2]) {
    cv = [0, ORG_INSERT_CHAMFER, 3][i];
    translate([200 + i*55, 0, 0])
    organizer_box([
        ["inner_w", 40],  ["inner_l", 40],  ["height", 50],
        ["wall", 1.5],    ["floor", 1.2],   ["corner_r", 3],
        ["insert_type",   "circle_array"],
        ["insert_d",      14],
        ["insert_chamfer", cv],
        ["label", str("C=",cv)],
        ["color", [0.90, 0.90, 0.90]]
    ]);
}
