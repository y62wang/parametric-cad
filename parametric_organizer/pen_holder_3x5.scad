// =============================================================
// pen_holder_3x5.scad
// 3 × 5 pen / toothbrush / marker holder.
//
// Uses organizer_box with circle_array insert:
//   → solid block outer shell WITH walls by default
//   → cylindrical bores drilled from the top
//
// Bore Ø 15 mm — fits pens ≤ 14 mm, markers ≤ 14 mm,
//                      toothbrush handles ≤ 13 mm
// 3 cols × 5 rows = 15 slots  |  height = 50 mm
// Outer: 52 × 86 × 50 mm
// Slicer tip: 2–3 perimeters, 15 % infill, 0.2 mm layers
// =============================================================

include <organizer_box.scad>

$fn = $preview ? 72 : 36;

BORE_D  = 15;    // bore diameter
GAP     =  2;    // wall between adjacent bores
COLS    =  3;    // columns
ROWS    =  5;    // rows
H       = 50;    // height (mm)
WALL    =  1.5;  // outer wall thickness
FLOOR   =  1.5;  // solid base below bores
CHAMFER =  2.0;  // entry bevel

STEP = BORE_D + GAP;         // 17 mm
IW   = COLS * STEP - GAP;    // 49 mm
IL   = ROWS * STEP - GAP;    // 83 mm

echo(str("Outer: ", IW+2*WALL, " × ", IL+2*WALL, " × ", H, " mm"));
echo(str("Slots: ", COLS, "×", ROWS, " = ", COLS*ROWS,
         "  bore Ø ", BORE_D, " mm"));

organizer_box([
    ["inner_w",       IW],
    ["inner_l",       IL],
    ["height",         H],
    ["wall",        WALL],
    ["floor",      FLOOR],
    ["corner_r",     3.0],

    ["insert_type",  "circle_array"],
    ["insert_d",     BORE_D],
    ["insert_gap",      GAP],
    ["insert_cols",    COLS],
    ["insert_rows",    ROWS],
    ["insert_chamfer", CHAMFER],

    ["color", [0.85, 0.93, 1.00]]
]);
