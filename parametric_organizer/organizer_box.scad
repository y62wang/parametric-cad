// =============================================================
// organizer_box.scad
// Parametric container / tray generator.
// Depends on: organizer_config.scad
//
// ── Container geometry depends on insert type ─────────────────
//
//   circle_array / pen
//     → SOLID BLOCK with cylindrical bores from the top.
//       Pens stand in the bores; material between bores holds them
//       upright. No hollow interior.
//
//   cradle
//     → SHALLOW BOX with a thick floor.
//       Horizontal half-cylinder grooves cut into the floor surface
//       so items (pens, brushes) lie flat in cradles.
//       Floor auto-thickens to at least insert_d/2 + 1 mm.
//
//   rectangle_array
//     → BOX with rectangular pockets cut into the floor surface.
//       Items (erasers, USB drives, SD cards) sit in the pockets.
//       Floor auto-thickens to at least insert_depth + 1 mm.
//
//   slot_array
//     → BOX with thin slots cut through the floor.
//       Items (cards, dividers) stand edge-on in the slots.
//
//   (none)
//     → Standard hollow box.
//
// ── Container spec keys ───────────────────────────────────────
//
//   REQUIRED
//   w, l         (mm)  OUTER dimensions  ← "w=20" means the outside is 20mm
//   height       (mm)  total height including floor
//
//   Legacy aliases (still accepted):
//   inner_w, inner_l  → outer = inner + 2×wall  (deprecated, use w/l)
//
//   OPTIONAL — geometry
//   wall          (mm)  side wall thickness        [ORG_WALL]
//   floor         (mm)  floor thickness            [ORG_FLOOR]
//                        auto-adjusted for cradle/rectangle inserts
//   corner_r      (mm)  all-corners radius         [ORG_CORNER_R]
//   corner_r_fl/fr/bl/br (mm) per-corner override
//
//   OPTIONAL — features
//   finger_cut    bool  notch in a wall            [false]
//   finger_r      (mm)  notch radius               [ORG_FINGER_R]
//   finger_wall   str   "front"|"back"|"left"|"right"
//   label         str   embossed text              [false]
//   label_depth   (mm)                             [ORG_LABEL_DEPTH]
//   drain_holes   int   floor drain count          [0]
//   drain_d       (mm)  drain diameter             [ORG_DRAIN_D]
//   color         [r,g,b]
//
// ── Item inserts ──────────────────────────────────────────────
//
//   Single insert:
//     insert_type   "circle_array"|"pen"|"cradle"|"rectangle_array"|"slot_array"
//     insert_*      see per-type keys below
//
//   Multiple inserts (different insert types in one container):
//     inserts  [
//       [["type","circle_array"],
//        ["region_x",0],  ["region_w",50],   // sub-region in inner cavity
//        ["insert_d",12], ...],
//       [["type","slot_array"],
//        ["region_x",53], ...]
//     ]
//     NOTE: all inserts in one container must share the same TYPE
//           (solid-bore vs. hollow-box) or results may be unexpected.
//
//   Per-insert keys (fall back to ORG_INSERT_* if omitted):
//     type            str   required per entry in inserts[]
//     region_x/y      (mm)  offset from inner cavity corner  [0]
//     region_w/l      (mm)  sub-region size                  [full]
//     insert_d        (mm)  item diameter  (circle_array/cradle)
//     insert_w/l      (mm)  pocket size    (rectangle_array)
//     insert_depth    (mm)  bore/pocket depth  [height × ratio]
//     insert_gap      (mm)  spacing between recesses  [ORG_INSERT_GAP]
//     insert_chamfer  (mm)  bevel on rim              [ORG_INSERT_CHAMFER]
//     insert_cols/rows/count  int  override auto count
// =============================================================

include <organizer_config.scad>

function ocfg(spec, key, default=undef) =
    let(m = [for (p=spec) if (p[0]==key) p[1]])
    len(m) > 0 ? m[0] : default;


// =============================================================
// organizer_box(spec)
// =============================================================

module organizer_box(spec) {
    wall = ocfg(spec, "wall",  ORG_WALL);
    // h / height = OUTER height — floor subtracts inward (same rule as w/l)
    h    = ocfg(spec, "h", ocfg(spec, "height", undef));
    cr   = ocfg(spec, "corner_r", ORG_CORNER_R);

    // ── Outer dimensions (w/l = outer; inner_w/inner_l = legacy) ─
    _w_outer  = ocfg(spec, "w",       undef);
    _w_legacy = ocfg(spec, "inner_w", undef);
    ow = _w_outer  != undef ? _w_outer  :
         _w_legacy != undef ? _w_legacy + 2*wall : undef;

    _l_outer  = ocfg(spec, "l",       undef);
    _l_legacy = ocfg(spec, "inner_l", undef);
    ol = _l_outer  != undef ? _l_outer  :
         _l_legacy != undef ? _l_legacy + 2*wall : undef;

    // Inner cavity = outer minus walls
    iw = ow - 2*wall;
    il = ol - 2*wall;

    r_fl = ocfg(spec, "corner_r_fl", cr);
    r_fr = ocfg(spec, "corner_r_fr", cr);
    r_bl = ocfg(spec, "corner_r_bl", cr);
    r_br = ocfg(spec, "corner_r_br", cr);

    ir_fl = max(0, r_fl - wall);
    ir_fr = max(0, r_fr - wall);
    ir_bl = max(0, r_bl - wall);
    ir_br = max(0, r_br - wall);

    finger_on   = ocfg(spec, "finger_cut",  ORG_FINGER_CUT);
    finger_r    = ocfg(spec, "finger_r",    ORG_FINGER_R);
    finger_wall = ocfg(spec, "finger_wall", "front");
    label_str   = ocfg(spec, "label",       false);
    label_d     = ocfg(spec, "label_depth", ORG_LABEL_DEPTH);
    drain_n     = ocfg(spec, "drain_holes", ORG_DRAIN_HOLES);
    drain_d     = ocfg(spec, "drain_d",     ORG_DRAIN_D);
    col         = ocfg(spec, "color",       [0.92, 0.92, 0.92]);

    // Detect primary insert type (single or from list)
    insert_type  = ocfg(spec, "insert_type", undef);
    inserts_list = ocfg(spec, "inserts",     undef);
    prim_type    = insert_type != undef ? insert_type :
                   (inserts_list != undef && len(inserts_list) > 0)
                       ? ocfg(inserts_list[0], "type",
                              ocfg(inserts_list[0], "insert_type", undef))
                       : undef;

    assert(ow != undef, "Spec must include 'w' (outer width) or 'inner_w'");
    assert(ol != undef, "Spec must include 'l' (outer length) or 'inner_l'");
    assert(h  != undef, "Spec must include 'h' or 'height' (outer height)");
    assert(iw > 0, str("Wall too thick: w=", ow, " wall=", wall,
                        " → inner=", iw, " (must be > 0)"));
    assert(il > 0, str("Wall too thick: l=", ol, " wall=", wall,
                        " → inner=", il, " (must be > 0)"));

    // ── Dispatch on primary insert type ──────────────────────
    if (prim_type == "circle_array" || prim_type == "pen") {
        // Solid block with top-entry cylindrical bores
        _solid_bore_box(spec, iw, il, h, wall, ow, ol,
                        r_fl, r_fr, r_bl, r_br, col,
                        insert_type, inserts_list);
    }
    else {
        // Auto-thicken floor for floor-pocket inserts
        min_fl = (prim_type == "cradle")
            ? ocfg(spec,"insert_d",ORG_INSERT_D)/2 + 1.0
            : (prim_type == "rectangle_array")
              ? ocfg(spec,"insert_depth",
                     h*ORG_INSERT_DEPTH_RATIO) + 1.0
              : ORG_FLOOR;
        fl = max(ocfg(spec,"floor",ORG_FLOOR), min_fl);

        assert(h > fl, "height must be > floor thickness");

        color(col)
        difference() {
            // outer shell
            linear_extrude(h)
            _rrect(ow, ol, r_fl, r_fr, r_bl, r_br);

            // inner cavity
            translate([wall, wall, fl])
            linear_extrude(h - fl + 0.01)
            _rrect(iw, il, ir_fl, ir_fr, ir_bl, ir_br);

            // standard features
            if (finger_on)
                _finger_notch(ow, ol, h, wall, finger_r, finger_wall);
            if (drain_n > 0)
                _drain_holes(iw, il, ow, ol, wall, fl, drain_n, drain_d);
            if (label_str != false)
                _label_emboss(ow, ol, h, wall, label_str, label_d);

            // floor-pocket inserts (single)
            if (insert_type != undef)
                translate([wall, wall, 0])
                _floor_insert(spec, iw, il, h, fl);

            // floor-pocket inserts (list)
            if (inserts_list != undef)
                for (ins = inserts_list)
                let(
                    rx = ocfg(ins,"region_x", 0),
                    ry = ocfg(ins,"region_y", 0)
                )
                let(
                    rw = ocfg(ins,"region_w", iw-rx),
                    rl = ocfg(ins,"region_l", il-ry)
                )
                translate([wall+rx, wall+ry, 0])
                _floor_insert(ins, rw, rl, h, fl);
        }
    }
}


// =============================================================
// Derived size helpers
// =============================================================

function box_outer_w(spec) =
    let(wall = ocfg(spec,"wall",ORG_WALL),
        w    = ocfg(spec,"w",       undef),
        iw   = ocfg(spec,"inner_w", undef))
    w  != undef ? w  :
    iw != undef ? iw + 2*wall : undef;

function box_outer_l(spec) =
    let(wall = ocfg(spec,"wall",ORG_WALL),
        l    = ocfg(spec,"l",       undef),
        il   = ocfg(spec,"inner_l", undef))
    l  != undef ? l  :
    il != undef ? il + 2*wall : undef;


// =============================================================
// _solid_bore_box  — circle_array / pen
// Solid block from bottom to top; cylindrical bores from the top.
// Material between bores keeps items upright.
// =============================================================

module _solid_bore_box(spec, iw, il, h, wall, ow, ol,
                        r_fl, r_fr, r_bl, r_br, col,
                        insert_type, inserts_list) {
    color(col)
    difference() {
        // solid outer block (no hollow interior)
        linear_extrude(h)
        _rrect(ow, ol, r_fl, r_fr, r_bl, r_br);

        // bore holes (single)
        if (insert_type != undef)
            translate([wall, wall, 0])
            _bore_array(spec, iw, il, h);

        // bore holes (list)
        if (inserts_list != undef)
            for (ins = inserts_list)
            let(
                rx = ocfg(ins,"region_x", 0),
                ry = ocfg(ins,"region_y", 0)
            )
            let(
                rw = ocfg(ins,"region_w", iw-rx),
                rl = ocfg(ins,"region_l", il-ry)
            )
            translate([wall+rx, wall+ry, 0])
            _bore_array(ins, rw, rl, h);
    }
}

module _bore_array(spec, rw, rl, h) {
    type    = ocfg(spec,"insert_type", ocfg(spec,"type",undef));
    d       = ocfg(spec,"insert_d",    ORG_INSERT_D);
    gap     = ocfg(spec,"insert_gap",  ORG_INSERT_GAP);
    fl_keep = ocfg(spec,"floor",       ORG_FLOOR);   // material left at base
    depth   = ocfg(spec,"insert_depth",h - fl_keep);
    chamfer = ocfg(spec,"insert_chamfer",ORG_INSERT_CHAMFER);
    step    = d + gap;
    acols   = floor((rw + gap) / step);
    arows   = floor((rl + gap) / step);
    cols    = ocfg(spec,"insert_cols", acols);
    rows    = ocfg(spec,"insert_rows", arows);
    x0      = (rw - (cols*step - gap)) / 2;
    y0      = (rl - (rows*step - gap)) / 2;

    echo(str("bore_array: ", cols, "×", rows, "=", cols*rows,
             " bores  d=", d, "  depth=", depth,
             "  floor_keep=", fl_keep));

    for (r=[0:rows-1], c=[0:cols-1]) {
        cx = x0 + c*step + d/2;
        cy = y0 + r*step + d/2;
        // main bore (from top down, leaves fl_keep at base)
        translate([cx, cy, h - depth - 0.01])
        cylinder(d=d, h=depth+0.02, $fn=36);
        // chamfer: widens at top opening so item slides in
        if (chamfer > 0)
            translate([cx, cy, h - 0.01])
            cylinder(d1=d, d2=d+2*chamfer, h=chamfer+0.01, $fn=36);
    }
}


// =============================================================
// _floor_insert  — cradle / rectangle_array / slot_array
// Cuts recesses DOWN from the floor surface into the floor material.
// =============================================================

module _floor_insert(spec, rw, rl, h, fl) {
    type    = ocfg(spec,"insert_type", ocfg(spec,"type",undef));
    gap     = ocfg(spec,"insert_gap",  ORG_INSERT_GAP);
    chamfer = ocfg(spec,"insert_chamfer",ORG_INSERT_CHAMFER);

    if (type == "cradle") {
        // ── Horizontal half-cylinder grooves in the floor ─────
        // Items (pens, brushes) lie flat in the grooves.
        // Groove center is at floor surface level (z = fl).
        d      = ocfg(spec,"insert_d", ORG_INSERT_D);
        step   = d + gap;
        auto_n = floor((rl + gap) / step);
        n      = ocfg(spec,"insert_count", auto_n);
        y0     = (rl - (n*step - gap)) / 2;

        echo(str("floor cradle: ", n, " grooves  d=", d,
                 "  floor=", fl, "  (need floor >= ", d/2, ")"));

        for (i=[0:n-1]) {
            cy = y0 + i*step + d/2;
            // groove: cylinder lying on its side, centred at floor surface
            translate([0, cy, fl])
            rotate([0, 90, 0])
            cylinder(d=d, h=rw, $fn=36);
            // chamfer at both open ends
            if (chamfer > 0) {
                translate([-0.01, cy, fl]) rotate([0,90,0])
                cylinder(d1=d+2*chamfer, d2=d, h=chamfer+0.01, $fn=36);
                translate([rw-chamfer-0.01, cy, fl]) rotate([0,90,0])
                cylinder(d1=d, d2=d+2*chamfer, h=chamfer+0.01, $fn=36);
            }
        }
    }

    else if (type == "rectangle_array") {
        // ── Rectangular pockets in the floor ─────────────────
        // Items (erasers, USB, keys) sit in pockets from the top.
        pw      = ocfg(spec,"insert_w",  ORG_INSERT_W);
        pl      = ocfg(spec,"insert_l",  ORG_INSERT_L);
        depth   = ocfg(spec,"insert_depth", fl * 0.7);
        step_x  = pw + gap;
        step_y  = pl + gap;
        acols   = floor((rw + gap) / step_x);
        arows   = floor((rl + gap) / step_y);
        cols    = ocfg(spec,"insert_cols", acols);
        rows    = ocfg(spec,"insert_rows", arows);
        x0      = (rw - (cols*step_x - gap)) / 2;
        y0      = (rl - (rows*step_y - gap)) / 2;

        echo(str("floor rectangle_array: ", cols, "×", rows,
                 "  pocket=", pw, "×", pl,
                 "  depth=", depth, "  floor=", fl));

        for (r=[0:rows-1], c=[0:cols-1]) {
            px = x0 + c*step_x;
            py = y0 + r*step_y;
            pz = fl - depth;  // pocket top at fl, goes down by depth
            // pocket body
            translate([px, py, pz - 0.01])
            cube([pw, pl, depth - chamfer + 0.02]);
            // chamfer at top opening
            if (chamfer > 0)
                translate([px-chamfer, py-chamfer, fl-chamfer-0.01])
                cube([pw+2*chamfer, pl+2*chamfer, chamfer+0.01]);
        }
    }

    else if (type == "slot_array") {
        // ── Thin slots through the floor ─────────────────────
        // Cards / thin items stand edge-on in slots.
        t      = ocfg(spec,"insert_d", ORG_INSERT_SLOT_T);
        step   = t + gap;
        n      = ocfg(spec,"insert_count", floor((rl+gap)/step));
        y0     = (rl - (n*step - gap)) / 2;

        echo(str("floor slot_array: ", n, " slots  t=", t,
                 "  floor=", fl));

        for (i=[0:n-1]) {
            sy = y0 + i*step;
            // slot through full floor (items thread down from top)
            translate([0, sy, -0.01])
            cube([rw, t, fl + 0.02]);
            // chamfer at top of slot
            if (chamfer > 0)
                translate([-chamfer, sy-chamfer, fl-chamfer-0.01])
                cube([rw+2*chamfer, t+2*chamfer, chamfer+0.01]);
        }
    }

    else if (type != undef) {
        echo(str("WARNING: unknown insert type '", type, "'"));
    }
}


// =============================================================
// Standard feature helpers
// =============================================================

module _rrect(w, l, r_fl=2, r_fr=2, r_bl=2, r_br=2) {
    rfl=max(0.01,r_fl); rfr=max(0.01,r_fr);
    rbl=max(0.01,r_bl); rbr=max(0.01,r_br);
    hull() {
        translate([rfl,   rfl  ]) circle(r=rfl, $fn=32);
        translate([w-rfr, rfr  ]) circle(r=rfr, $fn=32);
        translate([rbl,   l-rbl]) circle(r=rbl, $fn=32);
        translate([w-rbr, l-rbr]) circle(r=rbr, $fn=32);
    }
}

module _finger_notch(ow, ol, h, wall, r, which) {
    mid_h=h*0.55; eps=0.01;
    if      (which=="front") translate([ow/2,-eps,mid_h])       rotate([-90,0,0]) cylinder(r=r,h=wall+2*eps,$fn=48);
    else if (which=="back")  translate([ow/2,ol-wall-eps,mid_h]) rotate([-90,0,0]) cylinder(r=r,h=wall+2*eps,$fn=48);
    else if (which=="left")  translate([-eps,ol/2,mid_h])        rotate([0,90,0])  cylinder(r=r,h=wall+2*eps,$fn=48);
    else if (which=="right") translate([ow-wall-eps,ol/2,mid_h]) rotate([0,90,0])  cylinder(r=r,h=wall+2*eps,$fn=48);
}

module _drain_holes(iw, il, ow, ol, wall, fl, n, d) {
    s=iw/(n+1);
    for (i=[1:n]) translate([wall+s*i,ol/2,-0.01]) cylinder(d=d,h=fl+0.02,$fn=24);
}

module _label_emboss(ow, ol, h, wall, txt, depth) {
    translate([ow/2, depth, h*0.4]) rotate([90,0,0]) linear_extrude(depth+0.01)
    text(txt, size=min(h*0.25,ow*0.5), halign="center", valign="center",
         font="Liberation Sans:style=Bold");
}
