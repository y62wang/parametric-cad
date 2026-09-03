// =============================================================
// example_bed_fill.scad
// Demonstrates grid_pack, strip_pack, zone_pack with
// gap and max_n controls.
// =============================================================

include <pack_utils.scad>
include <screw_database.scad>

// Uncomment show_bed() to see the bed + margin outline
// show_bed();


// ─────────────────────────────────────────────────────────────
// MODE 1 — Fill bed, one item type
//
//   gap    = space between items (mm)
//   max_n  = hard cap on total items placed (undef = fill bed)
// ─────────────────────────────────────────────────────────────

grid_pack(screw_footprint(ws_8), gap=2, max_n=50)
    screw(ws_8);


// ─────────────────────────────────────────────────────────────
// MODE 2 — Horizontal strips, one type per strip
//
//   max_n as a list → [n_per_strip_0, n_per_strip_1, …]
//   max_n as a number → same cap for every strip
// ─────────────────────────────────────────────────────────────

/*
strip_pack(
    strips = [
        [screw_footprint(ws_6),  undef],   // strip 0 — uses global gap
        [screw_footprint(ws_8),  undef],   // strip 1
        [screw_footprint(ws_10), undef]    // strip 2
    ],
    gap   = 2,
    max_n = [12, 20, 8]   // different caps per strip
) {
    screw(ws_6);
    screw(ws_8);
    screw(ws_10);
}
*/


// ─────────────────────────────────────────────────────────────
// MODE 3 — Vertical zones, one type per zone
//
//   x_fraction must sum ≤ 1  (here two equal halves)
//   max_n = 30 → each zone capped at 30 items
// ─────────────────────────────────────────────────────────────

/*
zone_pack(
    zones = [
        [screw_footprint(deck_8x1_25),       0.5],
        [screw_footprint(construction_10x3), 0.5]
    ],
    gap   = 3,
    max_n = 30
) {
    screw(deck_8x1_25);
    screw(construction_10x3);
}
*/


// ─────────────────────────────────────────────────────────────
// Useful: echo item counts for every ANSI gauge at current gap
// ─────────────────────────────────────────────────────────────

/*
for (spec = ansi_wood_screw_catalog) {
    fp = screw_footprint(spec);
    echo(str(cfg(spec,"size"),
             "  fp=", fp,
             "  fits=", grid_count(fp, gap=2)));
}
*/
