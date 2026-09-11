// Boolean interference harness for the assembled v2.6 slide-lock.
//
// This file is driven by validate_interference.py. Empty or zero-thickness
// results are acceptable where noted by that validator; any positive-volume
// result is a failure.

interference_case = "rails_vs_channelled_heel";
sample_z = 53.0;
sample_thickness = 0.008;

include <../../../src/prototypes/v2_6_skadis_screwless_slide_lock.scad>

module sample_slab(z, thickness = sample_thickness) {
    translate([
        -back_w,
        -back_t,
        z - thickness / 2
    ])
        cube([
            2 * back_w,
            back_t + heel_t + male_rail_projection,
            thickness
        ]);
}

module sampled_rail_outside_channel(z) {
    difference() {
        intersection() {
            male_dovetail_rail(rail_centres_x[0]);
            sample_slab(z);
        }
        intersection() {
            female_dovetail_channel_void(
                rail_centres_x[0],
                include_clip_detents = false
            );
            sample_slab(z);
        }
    }
}

if (interference_case == "rails_vs_channelled_heel")
    intersection() {
        twin_dovetail_rails();
        body_heel_with_channels();
    }
else if (interference_case == "clip_vs_body")
    intersection() {
        anti_lift_clip_assembled();
        connected_screwless_body(false);
    }
else if (interference_case == "clip_vs_rails")
    intersection() {
        anti_lift_clip_assembled();
        twin_dovetail_rails();
    }
else if (interference_case == "lead_in_containment")
    sampled_rail_outside_channel(sample_z);
