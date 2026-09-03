// =============================================================
// organizer_layout.scad
// Arrange multiple organizer_box containers into a layout.
// Depends on: organizer_box.scad
//
// ── Placement modes ───────────────────────────────────────────
//   auto_place(specs)            auto bottom-left pack, no overlap
//   place_boxes(items)           explicit [x,y,spec,rot?] with assert
//   row_layout(specs)            auto row-wrap inside a region
//
// ── Collision API ─────────────────────────────────────────────
//   find_position(placed, spec)  → [x,y] or undef (core primitive)
//   overlap_in(items)            → [i,j] or undef
//   groups_overlap(a, b)         → [ia,ib] or undef
//   assert_no_overlap(items)     halt + echo on overlap
//
// ── Connectivity API ──────────────────────────────────────────
//   is_connected_set(items)      → true/false
//   assert_connected(items)      halt + echo if layout splits into islands
//   validate_layout(items)       overlap check + connectivity check
//
// Connectivity rules:
//   Two items are "adjacent" when their bounding boxes share an edge
//   of length >= threshold (default 0.001 mm).
//   Corner-only contact is NOT considered connected.
//   Requires gap ≈ 0 (wall-to-wall fit) to pass — containers placed
//   with gap > 0 will always be disconnected.
//
// ── Debug ─────────────────────────────────────────────────────
//   show_footprints(items)       AABB overlay
//   drawer_outline()             translucent drawer shell
// =============================================================

include <organizer_box.scad>


// =============================================================
// AABB helpers
// =============================================================

// AABB = [x_min, y_min, x_max, y_max]
// item format: [x, y, spec]  or  [x, y, spec, rot_deg]
function _item_aabb(item) =
    let(
        x   = item[0],
        y   = item[1],
        sp  = item[2],
        rot = (len(item) > 3 ? item[3] : 0) % 360,
        ow  = box_outer_w(sp),
        ol  = box_outer_l(sp)
    )
    (rot == 0)   ? [x,    y,    x+ow, y+ol] :
    (rot == 90)  ? [x-ol, y,    x,    y+ow] :
    (rot == 180) ? [x-ow, y-ol, x,    y   ] :
    (rot == 270) ? [x,    y-ow, x+ol, y   ] :
    let(bw = abs(ow*cos(rot)) + abs(ol*sin(rot)),
        bl = abs(ow*sin(rot)) + abs(ol*cos(rot)))
    [x, y, x+bw, y+bl];

// True when two AABBs overlap
function _aabbs_overlap(a, b, eps=0.001) =
    !(a[2] <= b[0]+eps || b[2] <= a[0]+eps ||
      a[3] <= b[1]+eps || b[3] <= a[1]+eps);


// =============================================================
// find_position()
// Given a list of already-placed items, find the bottom-left-most
// position where new_spec fits without any overlap.
//
// Algorithm: Bottom-Left Fill on "interesting" positions only.
//   Candidate X values = {0} ∪ {right edge of every placed item + gap}
//   Candidate Y values = {0} ∪ {top  edge of every placed item + gap}
//   Check all (x,y) pairs; return the bottom-left valid one.
//   O(n²) candidates for n placed items — fast even for 20+ items.
//
// Returns [x, y]  — or undef if no position fits in region.
//
//   placed   list of [x, y, spec] already on the bed
//   spec     new container spec to place
//   region   [w, l] available area (default = DRAWER_W × DRAWER_L)
//   gap      clearance between items
// =============================================================

function find_position(placed, spec,
                       region = [PRINT_USABLE_W, PRINT_USABLE_L],
                       gap    = ORG_GAP) =
    let(
        xs = concat([0], [for (p=placed) _item_aabb(p)[2] + gap]),
        ys = concat([0], [for (p=placed) _item_aabb(p)[3] + gap]),
        ow = box_outer_w(spec),
        ol = box_outer_l(spec),

        // All valid candidate positions
        valid = [
            for (y = ys) for (x = xs)
            if (x >= 0 && y >= 0 &&
                x + ow <= region[0] &&
                y + ol <= region[1] &&
                len([for (p=placed)
                     if (_aabbs_overlap(_item_aabb(p),
                                        [x, y, spec]))
                     1]) == 0)
            [x, y]
        ]
    )
    len(valid) > 0 ? _bottom_left(valid) : undef;

// Pick the bottom-left-most [x,y] from a list of candidates
function _bottom_left(pts, i=0, best=undef) =
    i >= len(pts) ? best :
    (best == undef ||
     pts[i][1] < best[1] ||
     (pts[i][1] == best[1] && pts[i][0] < best[0]))
        ? _bottom_left(pts, i+1, pts[i])
        : _bottom_left(pts, i+1, best);


// =============================================================
// auto_place()
// Place every spec automatically using find_position().
// Items are packed in the order given; earlier specs get priority
// for the bottom-left corner.
//
// Usage:
//   auto_place([pen_cup, wide_tray, clip_box, ruler_slot]);
//   auto_place([pen_cup, wide_tray], region=[200, 300], gap=1);
// =============================================================

module auto_place(specs,
                  region = [PRINT_USABLE_W, PRINT_USABLE_L],
                  gap    = ORG_GAP) {

    items = _pack_all(specs, region, gap);

    if (len(items) < len(specs))
        echo(str("auto_place: only ", len(items), "/", len(specs),
                 " items fit in region ", region));

    for (item = items)
        translate([item[0], item[1], 0])
        organizer_box(item[2]);
}

// Recursively compute positions for each spec in order
function _pack_all(specs, region, gap, placed=[], i=0) =
    i >= len(specs) ? placed :
    let(
        pos      = find_position(placed, specs[i], region, gap),
        new_item = (pos != undef) ? [pos[0], pos[1], specs[i]] : undef,
        placed2  = (new_item != undef)
                   ? concat(placed, [new_item])
                   : placed   // skip if no room
    )
    _pack_all(specs, region, gap, placed2, i+1);


// =============================================================
// Connectivity checks
// Two items are "adjacent" if they share a wall segment of
// length >= threshold.  Determines if the full set is one piece.
// =============================================================

// True when AABBs a and b are adjacent (share an edge ≥ threshold)
// or actually overlap.
//   ox > 0 && oy > 0  → interior intersection (definitely connected)
//   ox ≈ 0 && oy ≥ t  → flush X walls, shared Y segment ≥ threshold
//   oy ≈ 0 && ox ≥ t  → flush Y walls, shared X segment ≥ threshold
function _aabbs_adjacent(a, b, threshold=0.001) =
    let(
        tol = threshold / 2,
        ox  = min(a[2],b[2]) - max(a[0],b[0]),  // + overlap, 0 touch, - gap
        oy  = min(a[3],b[3]) - max(a[1],b[1])
    )
    (ox > 0 && oy > 0)                      ||  // interior overlap
    (abs(ox) <= tol && oy >= threshold)      ||  // flush left/right walls
    (abs(oy) <= tol && ox >= threshold);         // flush front/back walls

// Build NxN boolean adjacency matrix
function _adj_matrix(items, threshold=0.001) =
    [for (i = [0:len(items)-1])
     [for (j = [0:len(items)-1])
      i != j &&
      _aabbs_adjacent(_item_aabb(items[i]), _item_aabb(items[j]), threshold)
     ]];

// Is value x in list?
function _in_list(x, lst) =
    len([for (v=lst) if (v==x) true]) > 0;

// BFS: expand queue, accumulating visited set
function _bfs(adj, n, queue, visited) =
    len(queue) == 0 ? visited :
    let(
        node     = queue[0],
        rest     = len(queue) > 1
                   ? [for (i=[1:len(queue)-1]) queue[i]]
                   : [],
        new_nbrs = [for (j=[0:n-1])
                    if (adj[node][j] && !_in_list(j, visited)) j],
        new_vis  = concat(visited, new_nbrs),
        new_q    = concat(rest, new_nbrs)
    )
    _bfs(adj, n, new_q, new_vis);

// is_connected_set(items, threshold=0.001)
// Returns true when all items form one connected component.
function is_connected_set(items, threshold=0.001) =
    let(
        n       = len(items),
        adj     = _adj_matrix(items, threshold),
        reached = _bfs(adj, n, [0], [0])
    )
    len(reached) == n;

// assert_connected(items, threshold=0.001)
// Halts + echoes disconnected item indices if layout splits into islands.
// Does NOT modify any container dimensions.
module assert_connected(items, threshold=0.001) {
    n       = len(items);
    adj     = _adj_matrix(items, threshold);
    reached = _bfs(adj, n, [0], [0]);

    if (len(reached) < n) {
        unreach = [for (i=[0:n-1]) if (!_in_list(i, reached)) i];
        echo("─────────────────────────────────────────────────");
        echo(str("CONNECTIVITY ERROR: ", len(unreach), " of ", n,
                 " items are not connected to the layout"));
        echo(str("  Disconnected item indices : ", unreach));
        echo(str("  Connected  from item [0]  : ", reached));
        echo(str("  Tip: use gap=0 for wall-to-wall tiling,"));
        echo(str("  or check that all items touch a neighbour."));
        echo("─────────────────────────────────────────────────");
        assert(false, "Layout not connected — see console");
    }
}

// validate_layout(items)
// Full sanity check: no overlaps AND all items connected.
module validate_layout(items, threshold=0.001) {
    assert_no_overlap(items);
    assert_connected(items, threshold);
    echo(str("validate_layout: ", len(items),
             " items — no overlaps, fully connected ✓"));
}


// =============================================================
// Overlap checks
// =============================================================

function overlap_in(items, i=0, j=1) =
    i >= len(items)-1 ? undef :
    j >= len(items)   ? overlap_in(items, i+1, i+2) :
    _aabbs_overlap(_item_aabb(items[i]), _item_aabb(items[j]))
        ? [i, j]
        : overlap_in(items, i, j+1);

function groups_overlap(a, b, ia=0, ib=0) =
    ia >= len(a) ? undef :
    ib >= len(b) ? groups_overlap(a, b, ia+1, 0) :
    _aabbs_overlap(_item_aabb(a[ia]), _item_aabb(b[ib]))
        ? [ia, ib]
        : groups_overlap(a, b, ia, ib+1);

module assert_no_overlap(items_a, items_b=undef) {
    ov = (items_b == undef)
            ? overlap_in(items_a)
            : groups_overlap(items_a, items_b);

    if (ov != undef) {
        echo("─────────────────────────────────────────");
        echo(str("OVERLAP: items [", ov[0], "] and [", ov[1], "]"));
        src = (items_b == undef) ? items_a : items_a;
        echo(str("  [", ov[0], "] outer w=",
                 box_outer_w(src[ov[0]][2]), " l=",
                 box_outer_l(src[ov[0]][2]),
                 " @ x=", src[ov[0]][0], " y=", src[ov[0]][1]));
        echo("─────────────────────────────────────────");
        assert(false, "Overlap — see console");
    }
}


// =============================================================
// place_boxes()
// Explicit placement; asserts on overlap.
// =============================================================

module place_boxes(items) {
    assert_no_overlap(items);
    for (item = items) {
        translate([item[0], item[1], 0])
        rotate([0, 0, len(item) > 3 ? item[3] : 0])
        organizer_box(item[2]);
    }
}


// =============================================================
// row_layout()
// Auto row-wrap (no overlap by construction).
// =============================================================

module row_layout(specs,
                  region = [DRAWER_W, DRAWER_L],
                  gap    = ORG_GAP,
                  origin = [0, 0]) {
    ows = [for (s=specs) box_outer_w(s)];
    ols = [for (s=specs) box_outer_l(s)];
    _row_pack(specs, ows, ols, origin[0], origin[1], 0, region[0], gap);
}

module _row_pack(specs, ows, ols, x, y, row_h, max_w, gap, idx=0) {
    if (idx < len(specs)) {
        ow = ows[idx]; ol = ols[idx];
        if (x + ow <= max_w) {
            translate([x, y, 0]) organizer_box(specs[idx]);
            _row_pack(specs, ows, ols,
                      x+ow+gap, y, max(row_h, ol), max_w, gap, idx+1);
        } else {
            _row_pack(specs, ows, ols,
                      0, y+row_h+gap, 0, max_w, gap, idx);
        }
    }
}


// =============================================================
// Debug helpers
// =============================================================

module show_footprints(items, col="DodgerBlue") {
    for (item = items) {
        bb = _item_aabb(item);
        w = bb[2]-bb[0]; l = bb[3]-bb[1];
        color(col, 0.25) translate([bb[0], bb[1], -0.1]) cube([w, l, 0.2]);
        color(col, 0.80) translate([bb[0], bb[1], 0])
        linear_extrude(0.4)
        difference() { square([w,l]); translate([0.5,0.5]) square([w-1,l-1]); }
    }
}

module drawer_outline(w=DRAWER_W, l=DRAWER_L, h=DRAWER_H, wall=2) {
    color("DarkSlateGray", 0.10)
    difference() {
        cube([w, l, h]);
        translate([wall, wall, wall]) cube([w-2*wall, l-2*wall, h]);
    }
}
