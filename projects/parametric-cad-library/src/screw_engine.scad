// =============================================================
// screw_engine.scad
// Generic parametric screw generator
// Units: mm / degrees
// =============================================================

$fn = 72;

// -------------------------------------------------------------
// Config helpers
// -------------------------------------------------------------

function cfg(spec, key, default=undef) =
    let(matches = [for (p = spec) if (p[0] == key) p[1]])
    len(matches) > 0 ? matches[0] : default;

function effective_thread_len(spec) =
    let(
        mode      = cfg(spec, "threading", "explicit"),
        total_len = cfg(spec, "total_length"),
        head_h    = cfg(spec, "head_h", 0),
        shank_len = cfg(spec, "shank_len", 0),
        tip_len   = cfg(spec, "tip_len", 0)
    )
    mode == "full"
        ? max(0, total_len - head_h - shank_len - tip_len)
        : cfg(spec, "thread_len", 0);


// -------------------------------------------------------------
// Public API
// -------------------------------------------------------------

module screw(spec) {
    total_length   = cfg(spec, "total_length");

    shank_d        = cfg(spec, "shank_d");
    shank_len      = cfg(spec, "shank_len", 0);

    thread_major_d = cfg(spec, "thread_major_d");
    thread_root_d  = cfg(spec, "thread_root_d", shank_d);
    thread_pitch   = cfg(spec, "thread_pitch");
    thread_angle   = cfg(spec, "thread_angle", 60);
    thread_starts  = cfg(spec, "thread_starts", 1);
    thread_dir     = cfg(spec, "thread_direction", "RH");
    thread_profile_name = cfg(spec, "thread_profile", "wood");
    thread_len     = effective_thread_len(spec);

    head_type      = cfg(spec, "head_type", "flat");
    head_d         = cfg(spec, "head_d");
    head_h         = cfg(spec, "head_h");
    head_angle     = cfg(spec, "head_angle", 82);

    drive_type     = cfg(spec, "drive_type", "none");
    drive_size     = cfg(spec, "drive_size", "");
    drive_radius   = cfg(spec, "drive_radius", 0);
    drive_depth    = cfg(spec, "drive_depth", 0);

    tip_type       = cfg(spec, "tip_type", "gimlet");
    tip_len        = cfg(spec, "tip_len", 0);
    tip_end_d      = cfg(spec, "tip_end_d", 0.3);

    preview_color  = cfg(spec, "color", [0.65, 0.65, 0.65]);

    assert(total_length > 0, "total_length must be > 0");
    assert(shank_d > 0, "shank_d must be > 0");
    assert(thread_major_d >= thread_root_d,
           "thread_major_d must be >= thread_root_d");
    assert(thread_pitch > 0, "thread_pitch must be > 0");
    assert(head_d > 0 && head_h >= 0, "invalid head dimensions");
    assert(thread_len >= 0, "thread length must be >= 0");

    color(preview_color)
    difference() {
        union() {
            screw_head(
                type=head_type,
                d=head_d,
                h=head_h,
                shaft_d=shank_d,
                angle=head_angle
            );

            translate([0, 0, head_h])
            union() {
                if (shank_len > 0)
                    cylinder(d=shank_d, h=shank_len, $fn=$fn);

                translate([0, 0, shank_len])
                cylinder(d=thread_root_d, h=thread_len, $fn=$fn);

                translate([0, 0, shank_len])
                screw_thread(
                    length=thread_len,
                    pitch=thread_pitch,
                    root_d=thread_root_d,
                    major_d=thread_major_d,
                    angle=thread_angle,
                    starts=thread_starts,
                    direction=thread_dir,
                    profile_name=thread_profile_name
                );

                translate([0, 0, shank_len + thread_len])
                screw_tip(
                    type=tip_type,
                    root_d=thread_root_d,
                    major_d=thread_major_d,
                    length=tip_len,
                    end_d=tip_end_d
                );
            }
        }

        translate([0, 0, -0.01])
        drive_recess(
            type=drive_type,
            size=drive_size,
            radius=drive_radius,
            depth=drive_depth + 0.01
        );
    }
}


// -------------------------------------------------------------
// Heads
// -------------------------------------------------------------

module screw_head(type, d, h, shaft_d, angle=82) {
    if (type == "flat")
        flat_head(d=d, h=h, shaft_d=shaft_d, angle=angle);
    else if (type == "pan")
        pan_head(d=d, h=h);
    else if (type == "button")
        button_head(d=d, h=h);
    else if (type == "hex")
        hex_head(d=d, h=h);
    else {
        echo("WARNING: unsupported head type:", type);
        cylinder(d=d, h=h, $fn=$fn);
    }
}

module flat_head(d, h, shaft_d, angle=82) {
    // For catalog-driven geometry, head height is authoritative.
    // angle remains available as metadata / future exact derivation.
    top_land = max(0.05, h * 0.08);

    cylinder(d=d, h=top_land, $fn=$fn);

    if (h > top_land)
        translate([0, 0, top_land])
        cylinder(
            d1=d,
            d2=shaft_d,
            h=h-top_land,
            $fn=$fn
        );
}

module pan_head(d, h) {
    intersection() {
        translate([0, 0, h-d/2])
            sphere(d=d, $fn=$fn);
        cylinder(d=d, h=h, $fn=$fn);
    }
}

module button_head(d, h) {
    intersection() {
        translate([0, 0, h-d/2])
            sphere(d=d, $fn=$fn);
        cylinder(d=d, h=h, $fn=$fn);
    }
}

module hex_head(d, h) {
    cylinder(d=d, h=h, $fn=6);
}


// -------------------------------------------------------------
// Thread engine
// -------------------------------------------------------------

module screw_thread(
    length,
    pitch,
    root_d,
    major_d,
    angle=60,
    starts=1,
    direction="RH",
    profile_name="wood"
) {
    if (length > 0 && major_d > root_d) {
        twist_sign = direction == "LH" ? 1 : -1;
        turns = length / pitch;
        tooth_h = (major_d - root_d) / 2;

        for (start = [0 : starts - 1]) {
            rotate([0, 0, start * 360 / starts])
            linear_extrude(
                height=length,
                twist=twist_sign * 360 * turns,
                slices=max(12, ceil(turns * 36)),
                convexity=10
            )
            translate([root_d/2, 0])
            thread_profile(
                profile_name=profile_name,
                height=tooth_h,
                pitch=pitch / starts,
                angle=angle
            );
        }
    }
}

module thread_profile(profile_name, height, pitch, angle=60) {
    if (profile_name == "wood")
        wood_thread_profile(height=height, pitch=pitch, angle=angle);
    else if (profile_name == "machine")
        machine_thread_profile(height=height, pitch=pitch, angle=angle);
    else if (profile_name == "deck")
        deck_thread_profile(height=height, pitch=pitch, angle=angle);
    else {
        echo("WARNING: unsupported thread profile:", profile_name);
        wood_thread_profile(height=height, pitch=pitch, angle=angle);
    }
}

module wood_thread_profile(height, pitch, angle=60) {
    flank = min(pitch * 0.35, height / max(0.001, tan(angle/2)));

    polygon([
        [0,      0],
        [height, flank],
        [height, pitch - flank],
        [0,      pitch]
    ]);
}

module deck_thread_profile(height, pitch, angle=60) {
    // Slightly broader crest than generic wood thread.
    rise = min(pitch * 0.28, height / max(0.001, tan(angle/2)));
    crest = pitch * 0.18;

    polygon([
        [0,      0],
        [height, rise],
        [height, min(pitch-rise, rise+crest)],
        [0,      pitch]
    ]);
}

module machine_thread_profile(height, pitch, angle=60) {
    flank = min(pitch * 0.30, height / max(0.001, tan(angle/2)));

    polygon([
        [0,      0],
        [height, flank],
        [height, pitch - flank],
        [0,      pitch]
    ]);
}


// -------------------------------------------------------------
// Tips
// -------------------------------------------------------------

module screw_tip(type, root_d, major_d, length, end_d=0.3) {
    if (length <= 0) {
        // no tip
    }
    else if (type == "gimlet" || type == "cone") {
        cylinder(
            d1=major_d,
            d2=max(0.01, end_d),
            h=length,
            $fn=$fn
        );
    }
    else if (type == "flat") {
        cylinder(d=root_d, h=length, $fn=$fn);
    }
    else {
        echo("WARNING: unsupported tip:", type);
        cylinder(
            d1=major_d,
            d2=max(0.01, end_d),
            h=length,
            $fn=$fn
        );
    }
}


// -------------------------------------------------------------
// Drive recesses
// -------------------------------------------------------------

module drive_recess(type, size="", radius=0, depth=0) {
    if (depth <= 0 || type == "none") {
        // no drive recess
    }
    else if (type == "torx")
        torx_drive(r=radius, depth=depth);
    else if (type == "phillips")
        phillips_drive(r=radius, depth=depth);
    else if (type == "slot")
        slot_drive(r=radius, depth=depth);
    else if (type == "hex")
        hex_drive(r=radius, depth=depth);
    else
        echo("WARNING: unsupported drive type:", type);
}

module torx_drive(r, depth) {
    linear_extrude(height=depth)
    union() {
        circle(r=r * 0.48, $fn=32);

        for (i = [0:5])
            rotate(i * 60)
            translate([r * 0.52, 0])
            circle(r=r * 0.44, $fn=24);
    }
}

module phillips_drive(r, depth) {
    linear_extrude(height=depth)
    union() {
        square([r*2, r*0.45], center=true);
        square([r*0.45, r*2], center=true);
    }
}

module slot_drive(r, depth) {
    linear_extrude(height=depth)
    square([r*2, r*0.35], center=true);
}

module hex_drive(r, depth) {
    cylinder(r=r, h=depth, $fn=6);
}
