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

// Outer dimensions auto-computed from SPACING so all gaps are equal:
//   W = COLS*(BORE_D+SPACING) + SPACING + 2*WALL
//   L = ROWS*(BORE_D+SPACING) + SPACING + 2*WALL
//
// Math check (SPACING=3, D=15, WALL=1.5):
//   W = 3*(15+3) + 3 + 3     = 54 + 6   = 60 mm
//   L = 5*(15+3) + 3 + 3     = 90 + 6   = 96 mm
//   inner_W = 60 - 3         = 57 mm
//   inner_L = 96 - 3         = 93 mm
//   x_border = x_gap = SPACING = 3 mm  ✓ (left=right=between = 3mm)
//   y_border = y_gap = SPACING = 3 mm  ✓ (top=bottom=between = 3mm)
W = COLS*(BORE_D + SPACING) + SPACING + 2*WALL;   // 60 mm
L = ROWS*(BORE_D + SPACING) + SPACING + 2*WALL;   // 96 mm
// H = 50 is set above; floor subtracts inward

echo(str("Outer   : ", W, " × ", L, " × ", H, " mm"));
echo(str("Inner   : ", W-2*WALL, " × ", L-2*WALL, " mm"));
echo(str("Spacing : ", SPACING, " mm everywhere (border = gap → perfectly even)"));

organizer_box([
    ["w",          W],
    ["l",          L],
    ["h",          H],
    ["wall",    WALL],
    ["floor",  FLOOR],
    ["corner_r", 3.0],

    ["insert_type",    "circle_array"],
    ["insert_d",       BORE_D],
    ["insert_spacing", SPACING],   // ← single value: gap = border = SPACING
    ["insert_cols",    COLS],
    ["insert_rows",    ROWS],
    ["insert_chamfer", CHAMFER],

    ["color", [0.85, 0.93, 1.00]]
]);
