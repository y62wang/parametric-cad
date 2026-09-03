// =============================================================
// pen_holder_3x5.scad
// 3 × 5 pen / toothbrush / marker holder.
//
// Bore Ø 15 mm — fits pens ≤ 14 mm, markers ≤ 14 mm,
//                      toothbrush handles ≤ 13 mm
// 3 cols × 5 rows = 15 slots  |  height = 50 mm
// Outer: 60 × 100 × 50 mm  (all multiples of 10)
// Even 3 mm spacing: border = gap = 3 mm → uniform grid appearance
// =============================================================

include <organizer_box.scad>

$fn = $preview ? 72 : 36;

BORE_D   = 15;   // bore diameter (mm)
SPACING  =  3;   // gap between bores AND from wall to first bore (equal → even)
COLS     =  3;   // columns
ROWS     =  5;   // rows
H        = 50;   // outer height (mm)
WALL     =  1.5; // outer wall thickness
FLOOR    =  1.5; // solid base below bores
CHAMFER  =  2.0; // entry bevel

// Outer dimensions — computed from spacing, rounded to multiples of 10
// Formula: cols*(d+spacing) + spacing + 2*wall
// W_raw = 3*(15+3) + 3 + 3 = 60  → already multiple of 10 ✓
// L_raw = 5*(15+3) + 3 + 3 = 96  → round up to 100
W = 60;    // outer width
L = 100;   // outer length
// H = 50 ✓

echo(str("Outer   : ", W, " × ", L, " × ", H, " mm"));
echo(str("Spacing : ", SPACING, " mm  (border = gap = even grid)"));

organizer_box([
    ["w",          W],
    ["l",          L],
    ["h",          H],
    ["wall",    WALL],
    ["floor",  FLOOR],
    ["corner_r", 3.0],

    ["insert_type",    "circle_array"],
    ["insert_d",       BORE_D],
    ["insert_gap",     SPACING],
    ["insert_border",  SPACING],   // ← equal to gap → uniform spacing
    ["insert_cols",    COLS],
    ["insert_rows",    ROWS],
    ["insert_chamfer", CHAMFER],

    ["color", [0.85, 0.93, 1.00]]
]);
