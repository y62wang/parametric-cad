// Boolean interference harness for the assembled v2.7 interfaces.
//
// This file is driven by validate_interference.py. Empty or zero-thickness
// results are acceptable where noted by that validator.

interference_case = "rails_vs_channelled_heel";
sample_z = 53.0;
sample_thickness = 0.008;
coupon_index = 0;

include <../../../src/prototypes/v2_7_dual_board_screwless.scad>

skadis_test_hook_w = selected_skadis_hook_w;
skadis_test_board_t = selected_skadis_board_t;
skadis_test_board_clearance =
    selected_skadis_board_clearance;

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

module lower_multiboard_proxy() {
    multiboard_board_proxy(
        0,
        multiboard_connector_z[0],
        26,
        24,
        back_t,
        false
    );
}

module lower_multiboard_catch() {
    multiboard_split_catch(
        0,
        multiboard_connector_z[0],
        back_t
    );
}

module lower_multiboard_pad() {
    multiboard_bearing_pad(
        0,
        multiboard_connector_z[0],
        back_t
    );
}

module lower_multiboard_stop() {
    multiboard_rear_clearance_stop(
        0,
        multiboard_connector_z[0],
        back_t,
        14,
        12,
        0.5
    );
}

module depth_coupon_multiboard_proxy(index) {
    multiboard_board_proxy(
        0,
        multiboard_connector_z[0],
        26,
        24,
        back_t,
        false,
        multiboard_retention_coupon_board_thicknesses[index]
    );
}

module depth_coupon_multiboard_catch(index) {
    multiboard_split_catch(
        0,
        multiboard_connector_z[0],
        back_t,
        multiboard_retention_coupon_catch_spans[index],
        multiboard_retention_coupon_shoulder_depths[index]
    );
}

module depth_coupon_multiboard_stop(index) {
    multiboard_rear_clearance_stop(
        0,
        multiboard_connector_z[0],
        back_t,
        14,
        12,
        0.5,
        multiboard_retention_coupon_board_thicknesses[index],
        multiboard_retention_coupon_rear_clearances[index]
    );
}

module depth_coupon_multiboard_shoulder_region(index) {
    board_front_y =
        -back_t - multiboard_standoff;
    board_rear_y =
        board_front_y -
        multiboard_retention_coupon_board_thicknesses[index];
    shoulder_excess =
        (
            multiboard_retention_coupon_catch_spans[index] -
            multiboard_proxy_hole_d
        ) / 2;

    translate([
        multiboard_proxy_hole_d / 2 + 0.01,
        board_rear_y - 0.50,
        multiboard_connector_z[0] + 0.20
    ])
        cube([
            shoulder_excess - 0.02,
            0.30,
            0.60
        ]);
}

module skadis_load_hooks_only() {
    for (x = skadis_hook_x)
        skadis_load_hook(
            x,
            skadis_hook_z,
            back_t,
            skadis_test_hook_w,
            skadis_test_board_t,
            skadis_test_board_clearance
        );
}

module skadis_lower_pads_only() {
    for (x = skadis_lower_pad_x)
        skadis_lower_bearing_pad(
            x,
            skadis_lower_pad_z,
            back_t
        );
}

module skadis_capture_region(index) {
    board_rear_y =
        skadis_board_contact_plane_y -
        skadis_test_board_t;

    translate([
        skadis_hook_x[index] -
            skadis_test_hook_w / 2 -
            0.2,
        board_rear_y -
            skadis_test_board_clearance -
            skadis_hook_depth -
            0.2,
        skadis_hook_z -
            skadis_hook_tongue_h / 2 -
            0.2
    ])
        cube([
            skadis_test_hook_w + 0.4,
            skadis_test_board_clearance +
                skadis_hook_depth +
                0.4,
            skadis_hook_tongue_h + 0.4
        ]);
}

module one_skadis_root_fillet() {
    plate_t = back_t;
    x = skadis_hook_x[0];
    z = skadis_hook_z;
    board_front_y = -plate_t - skadis_standoff;
    board_rear_y = board_front_y - skadis_board_t;
    tongue_front_y =
        board_rear_y - skadis_board_clearance;
    tongue_z0 =
        z - skadis_hook_tongue_h / 2;
    neck_z0 =
        tongue_z0 +
        skadis_hook_tongue_h -
        skadis_hook_neck_h;

    skadis_hook_root_fillets(
        x,
        plate_t,
        board_front_y,
        neck_z0,
        skadis_hook_w
    );
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
else if (interference_case ==
         "multiboard_connector_vs_proxy")
    intersection() {
        lower_multiboard_catch();
        lower_multiboard_proxy();
    }
else if (interference_case ==
         "multiboard_pads_vs_proxy")
    intersection() {
        lower_multiboard_pad();
        lower_multiboard_proxy();
    }
else if (interference_case ==
         "multiboard_tip_vs_rear_stop")
    intersection() {
        lower_multiboard_catch();
        lower_multiboard_stop();
    }
else if (interference_case ==
         "multiboard_plug_vs_bearing_pad")
    intersection() {
        lower_multiboard_catch();
        lower_multiboard_pad();
    }
else if (interference_case ==
         "multiboard_depth_connector_vs_proxy")
    intersection() {
        depth_coupon_multiboard_catch(coupon_index);
        depth_coupon_multiboard_proxy(coupon_index);
    }
else if (interference_case ==
         "multiboard_depth_pads_vs_proxy")
    intersection() {
        lower_multiboard_pad();
        depth_coupon_multiboard_proxy(coupon_index);
    }
else if (interference_case ==
         "multiboard_depth_tip_vs_rear_stop")
    intersection() {
        depth_coupon_multiboard_catch(coupon_index);
        depth_coupon_multiboard_stop(coupon_index);
    }
else if (interference_case ==
         "multiboard_depth_shoulder_behind_board")
    intersection() {
        depth_coupon_multiboard_catch(coupon_index);
        depth_coupon_multiboard_shoulder_region(
            coupon_index
        );
    }
else if (interference_case ==
         "skadis_hooks_vs_seated_proxy")
    intersection() {
        skadis_load_hooks_only();
        skadis_board_proxy(skadis_test_board_t);
    }
else if (interference_case ==
         "skadis_lower_pads_vs_seated_proxy")
    intersection() {
        skadis_lower_pads_only();
        skadis_board_proxy();
    }
else if (interference_case ==
         "skadis_left_capture_behind_board")
    intersection() {
        skadis_load_hook(
            skadis_hook_x[0],
            skadis_hook_z,
            back_t,
            skadis_test_hook_w,
            skadis_test_board_t,
            skadis_test_board_clearance
        );
        skadis_capture_region(0);
    }
else if (interference_case ==
         "skadis_right_capture_behind_board")
    intersection() {
        skadis_load_hook(
            skadis_hook_x[1],
            skadis_hook_z,
            back_t,
            skadis_test_hook_w,
            skadis_test_board_t,
            skadis_test_board_clearance
        );
        skadis_capture_region(1);
    }
else if (interference_case ==
         "skadis_root_fillet_slot_intrusion")
    intersection() {
        one_skadis_root_fillet();
        translate([
            -back_w,
            -back_t -
                skadis_standoff -
                skadis_board_t -
                skadis_board_clearance -
                skadis_hook_depth -
                1,
            0
        ])
            cube([
                2 * back_w,
                skadis_board_t +
                    skadis_board_clearance +
                    skadis_hook_depth +
                    1,
                back_h
            ]);
    }
