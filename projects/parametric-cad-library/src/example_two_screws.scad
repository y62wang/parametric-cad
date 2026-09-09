// =============================================================
// example_two_screws.scad
// Render two different screws using the same geometry engine.
// =============================================================

include <screw_engine.scad>
include <screw_database.scad>

spacing = 18;

// First screw
screw(deck_8x1_25);

// Second screw
translate([spacing, 0, 0])
    screw(construction_10x3);


// -------------------------------------------------------------
// Alternative: render every screw in screw_catalog automatically
// -------------------------------------------------------------
//
// for (i = [0 : len(screw_catalog)-1])
//     translate([i * spacing, 0, 0])
//         screw(screw_catalog[i]);
