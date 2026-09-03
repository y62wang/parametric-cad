// =============================================================
// organizer_config.scad
// Global defaults for the parametric organizer system.
// Override per-container in the spec; override globally here.
// =============================================================

// ── Container wall defaults ───────────────────────────────────
ORG_WALL      = 1.5;   // mm — side wall thickness
ORG_FLOOR     = 1.2;   // mm — bottom floor thickness
ORG_CORNER_R  = 2.0;   // mm — corner radius (all 4, unless overridden)

// ── Layout spacing ────────────────────────────────────────────
// Gap between adjacent containers (the "breathing room").
// Practical range:
//   0.2–0.5 mm  tight fit / shared-wall style
//   1–3   mm    comfortable — easy to lift individual boxes   ← default
//   5–10  mm    loose / decorative spacing
//   30    mm    3 cm — very open; good for wide shallow trays
ORG_GAP       = 3.0;   // mm

// ── Optional features (global defaults, override per spec) ────
ORG_FINGER_CUT   = false;  // semicircle notch on long wall to grab items
ORG_FINGER_R     = 8.0;   // mm — finger-notch radius
ORG_LABEL        = false;  // emboss label string on front wall
ORG_LABEL_DEPTH  = 0.4;   // mm — label emboss depth
ORG_DRAIN_HOLES  = 0;     // number of drain holes in floor (0 = none)
ORG_DRAIN_D      = 4.0;   // mm — drain hole diameter

// ── Item-shaped insert recesses ───────────────────────────────
// Defaults for all insert types.
// Override globally here, or per-spec using the same key names
// (insert_d, insert_gap, etc.)
//
// circle_array / pen  — vertical wells (items stand upright)
ORG_INSERT_D           = 12.0;  // mm  item diameter  (pen 10–13, marker 14)
ORG_INSERT_DEPTH_RATIO = 0.55;  //     depth = container height × this
//
// rectangle_array     — rectangular pockets
ORG_INSERT_W           = 20.0;  // mm  pocket width
ORG_INSERT_L           = 40.0;  // mm  pocket length
//
// slot_array          — thin standing slots (cards, USB)
ORG_INSERT_SLOT_T      =  1.0;  // mm  slot thickness (card ~0.8, USB ~4)
//
// all types
ORG_INSERT_GAP         =  3.0;  // mm  spacing between recesses
ORG_INSERT_CHAMFER     =  1.5;  // mm  bevel on top rim of every recess
                                 //     so items slide in; set 0 to disable

// ── Print bed ─────────────────────────────────────────────────
// auto_place() uses the usable bed area as its default region.
// Change PRINT_W / PRINT_L to match your printer.
// Common sizes:
//   Bambu P1S / X1C / A1  : 256 × 256
//   Prusa MK4 / MINI+      : 250 × 210
//   Ender 3 / v2           : 220 × 220
PRINT_W         = 256;   // mm — full bed width
PRINT_L         = 256;   // mm — full bed length
PRINT_MARGIN    =   8;   // mm — keep-out border (all edges)
PRINT_USABLE_W  = PRINT_W - 2 * PRINT_MARGIN;   // 240 mm
PRINT_USABLE_L  = PRINT_L - 2 * PRINT_MARGIN;   // 240 mm

// ── Drawer dimensions (for row_layout / drawer_outline) ───────
// Set these to your actual drawer interior dimensions.
DRAWER_W      = 300;   // mm — drawer interior width
DRAWER_L      = 450;   // mm — drawer interior length (depth)
DRAWER_H      = 60;    // mm — drawer interior height (usable depth)
