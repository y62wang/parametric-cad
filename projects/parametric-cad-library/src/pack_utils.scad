// =============================================================
// pack_utils.scad
// Build-plate packing utilities.
// Depends on: plate_config.scad, screw_engine.scad (for cfg())
//
// Key parameters available on every packer module:
//   gap     (mm)  — space between items; default = PACK_GAP
//   max_n         — max items to place; undef = fill the bed
//                   strip_pack / zone_pack accept a list [n0,n1,…]
//                   (one limit per strip/zone) or a single number
//                   (same limit applied to every strip/zone)
// =============================================================

include <plate_config.scad>
include <screw_engine.scad>   // brings in cfg() helper


// -------------------------------------------------------------
// Footprint helpers
// Returns [x_size, y_size] bounding box of an item as printed.
// Convention: items print in their natural orientation
//   (screws standing upright tip-up → footprint = head circle)
// -------------------------------------------------------------

function screw_footprint(spec) =
    let(d = cfg(spec, "head_d", cfg(spec, "shank_d")))
    [d, d];

function disc_footprint(od)    = [od, od];          // washer, magnet
function rect_footprint(w, d)  = [w, d];            // box, bracket


// -------------------------------------------------------------
// grid_count()  — items that fit (ignoring max_n)
// -------------------------------------------------------------

function grid_count(footprint, gap=PACK_GAP) =
    let(
        xs   = footprint[0] + gap,
        ys   = footprint[1] + gap,
        cols = floor((PLATE_USABLE_X + gap) / xs),
        rows = floor((PLATE_USABLE_Y + gap) / ys)
    )
    cols * rows;


// -------------------------------------------------------------
// grid_pack()
// Fill the bed with one item type.
//
//   footprint  [x,y]   — bounding box of one item
//   gap        mm      — space between items
//   max_n              — cap total; undef = fill bed
//
// Items are placed left-to-right, bottom-to-top; max_n cuts
// the sequence at that count.
//
// Usage:
//   grid_pack(screw_footprint(ws_8), gap=3, max_n=50)
//       screw(ws_8);
// -------------------------------------------------------------

module grid_pack(footprint, gap=PACK_GAP, max_n=undef) {
    xs    = footprint[0] + gap;
    ys    = footprint[1] + gap;
    cols  = floor((PLATE_USABLE_X + gap) / xs);
    rows  = floor((PLATE_USABLE_Y + gap) / ys);
    total = cols * rows;
    limit = (max_n == undef || max_n > total) ? total : max_n;

    echo(str("grid_pack: bed fits ", total,
             " — placing ", limit,
             " (gap=", gap, " mm)"));

    for (r = [0 : rows-1])
        for (c = [0 : cols-1])
            if (r * cols + c < limit)
                translate([
                    PLATE_MARGIN + c * xs + footprint[0]/2,
                    PLATE_MARGIN + r * ys + footprint[1]/2,
                    0
                ])
                children();
}


// -------------------------------------------------------------
// strip_pack()
// Horizontal strips — one item type per strip.
//
//   strips   list of [footprint, gap_override]
//              gap_override = undef → uses the global gap param
//   gap      default gap when strip entry doesn't override
//   max_n    undef  → fill each strip
//            number → each strip limited to that count
//            list   → [n0, n1, …] limit per strip
//
// Usage:
//   strip_pack(
//       strips   = [[screw_footprint(ws_6), undef],
//                   [screw_footprint(ws_8), undef]],
//       gap      = 2,
//       max_n    = [12, 20]   // 12 of ws_6, 20 of ws_8
//   ) {
//       screw(ws_6);          // child 0 → strip 0
//       screw(ws_8);          // child 1 → strip 1
//   }
// -------------------------------------------------------------

module strip_pack(strips, gap=PACK_GAP, max_n=undef) {
    for (i = [0 : len(strips)-1]) {
        fp  = strips[i][0];
        g   = (strips[i][1] == undef) ? gap : strips[i][1];
        xs  = fp[0] + g;
        ys  = fp[1] + g;
        cols_fit = floor((PLATE_USABLE_X + g) / xs);

        strip_limit =
            (max_n == undef)         ? cols_fit :
            is_list(max_n)           ?
                (i < len(max_n) ? min(cols_fit, max_n[i]) : cols_fit) :
            min(cols_fit, max_n);

        y_off = PLATE_MARGIN + _strip_y_offset(strips, i, gap);

        if (y_off + fp[1] <= PLATE_Y - PLATE_MARGIN) {
            echo(str("strip_pack[", i, "]: placing ",
                     strip_limit, " items @ y=", y_off,
                     " (gap=", g, ")"));
            for (c = [0 : strip_limit-1])
                translate([
                    PLATE_MARGIN + c * xs + fp[0]/2,
                    y_off + fp[1]/2,
                    0
                ])
                children(i);
        } else {
            echo(str("strip_pack[", i, "]: strip does not fit — skipped"));
        }
    }
}

function _strip_y_offset(strips, n, gap) =
    n <= 0 ? 0 :
    let(g = (strips[n-1][1] == undef) ? gap : strips[n-1][1])
    strips[n-1][0][1] + g + _strip_y_offset(strips, n-1, gap);


// -------------------------------------------------------------
// zone_pack()
// Vertical zones — one item type per zone.
//
//   zones   list of [footprint, x_fraction]
//             x_fraction shares must sum ≤ 1
//   gap     default gap
//   max_n   undef / number / list  (same semantics as strip_pack)
//
// Usage:
//   zone_pack(
//       zones = [[screw_footprint(ws_8),  0.5],
//                [screw_footprint(ws_10), 0.5]],
//       gap   = 2,
//       max_n = 30           // cap each zone at 30 items
//   ) {
//       screw(ws_8);
//       screw(ws_10);
//   }
// -------------------------------------------------------------

module zone_pack(zones, gap=PACK_GAP, max_n=undef) {
    for (i = [0 : len(zones)-1]) {
        fp     = zones[i][0];
        frac   = zones[i][1];
        zone_w = PLATE_USABLE_X * frac;
        xs     = fp[0] + gap;
        ys     = fp[1] + gap;
        cols_fit = floor((zone_w + gap) / xs);
        rows_fit = floor((PLATE_USABLE_Y + gap) / ys);
        total_fit = cols_fit * rows_fit;

        zone_limit =
            (max_n == undef)   ? total_fit :
            is_list(max_n)     ?
                (i < len(max_n) ? min(total_fit, max_n[i]) : total_fit) :
            min(total_fit, max_n);

        x_start = PLATE_MARGIN + _zone_x_offset(zones, i);

        echo(str("zone_pack[", i, "]: bed fits ", total_fit,
                 " — placing ", zone_limit,
                 " @ x=", x_start, " (gap=", gap, ")"));

        for (r = [0 : rows_fit-1])
            for (c = [0 : cols_fit-1])
                if (r * cols_fit + c < zone_limit)
                    translate([
                        x_start + c * xs + fp[0]/2,
                        PLATE_MARGIN + r * ys + fp[1]/2,
                        0
                    ])
                    children(i);
    }
}

function _zone_x_offset(zones, n) =
    n <= 0 ? 0 :
    PLATE_USABLE_X * zones[n-1][1] + _zone_x_offset(zones, n-1);


// -------------------------------------------------------------
// show_bed()  — debug overlay
// -------------------------------------------------------------

module show_bed(margin=true) {
    color("LightBlue", 0.15) square([PLATE_X, PLATE_Y]);
    if (margin)
        color("Salmon", 0.25)
        difference() {
            square([PLATE_X, PLATE_Y]);
            translate([PLATE_MARGIN, PLATE_MARGIN])
            square([PLATE_USABLE_X, PLATE_USABLE_Y]);
        }
}
