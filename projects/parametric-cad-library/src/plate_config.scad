// =============================================================
// plate_config.scad
// Single source of truth for print-bed dimensions and packing
// defaults.  Change PLATE_X / PLATE_Y here; everything else
// picks it up automatically.
// =============================================================

// ── Bed dimensions ────────────────────────────────────────────
// Common presets (uncomment yours):
//   Bambu P1S / X1C / A1 : 256 × 256
//   Prusa MK4 / MINI+     : 250 × 210
//   Ender 3 / v2 / Pro    : 220 × 220
//   Voron 2.4 (350)        : 350 × 350

PLATE_X = 256;   // mm — bed usable X
PLATE_Y = 256;   // mm — bed usable Y

// ── Keep-out margin (all four edges) ─────────────────────────
PLATE_MARGIN = 8;   // mm — stay this far from any edge

// ── Derived usable area ───────────────────────────────────────
PLATE_USABLE_X = PLATE_X - 2 * PLATE_MARGIN;   // 240 mm @ default
PLATE_USABLE_Y = PLATE_Y - 2 * PLATE_MARGIN;   // 240 mm @ default

// ── Default gap between items ─────────────────────────────────
PACK_GAP = 2;   // mm — minimum clearance between adjacent items
