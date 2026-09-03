// =============================================================
// screw_database.scad
// Data-only screw definitions.
// Add new screws here without changing screw_engine.scad.
// =============================================================

// -------------------------------------------------------------
// #8 x 1-1/4" deck screw
// Flat head / T25 / full thread
// -------------------------------------------------------------

deck_8x1_25 = [
    ["id", "deck_8x1_25"],
    ["family", "deck"],
    ["size", "#8"],

    ["total_length", 31.75],

    ["shank_d", 4.17],
    ["shank_len", 0],

    ["thread_major_d", 4.27],
    ["thread_root_d", 3.20],
    ["thread_pitch", 1.693],
    ["thread_angle", 60],
    ["thread_profile", "deck"],
    ["threading", "full"],
    ["thread_starts", 1],
    ["thread_direction", "RH"],

    ["head_type", "flat"],
    ["head_d", 8.43],
    ["head_h", 2.54],
    ["head_angle", 82],

    ["drive_type", "torx"],
    ["drive_size", "T25"],
    ["drive_radius", 1.80],
    ["drive_depth", 1.65],

    ["tip_type", "gimlet"],
    ["tip_len", 3.20],
    ["tip_end_d", 0.35],

    ["color", [0.62, 0.46, 0.22]]
];


// -------------------------------------------------------------
// #10 x 3" construction screw
// Example second screw
// -------------------------------------------------------------

construction_10x3 = [
    ["id", "construction_10x3"],
    ["family", "construction"],
    ["size", "#10"],

    ["total_length", 76.20],

    ["shank_d", 4.83],
    ["shank_len", 15.00],

    ["thread_major_d", 5.10],
    ["thread_root_d", 3.65],
    ["thread_pitch", 2.00],
    ["thread_angle", 60],
    ["thread_profile", "wood"],
    ["threading", "explicit"],
    ["thread_len", 53.20],
    ["thread_starts", 1],
    ["thread_direction", "RH"],

    ["head_type", "flat"],
    ["head_d", 9.50],
    ["head_h", 3.00],
    ["head_angle", 82],

    ["drive_type", "torx"],
    ["drive_size", "T25"],
    ["drive_radius", 1.80],
    ["drive_depth", 1.80],

    ["tip_type", "gimlet"],
    ["tip_len", 5.00],
    ["tip_end_d", 0.35],

    ["color", [0.45, 0.45, 0.45]]
];


// =============================================================
// ANSI B18.6.1  flat-head wood screw templates  (#0 – #24)
// Source: wood_screws_ANSI_B18.6.1.csv (same folder)
// Drive: slotted (standard ANSI); swap drive_type to "phillips"
//        or "torx" for modern variants.
// threading: "full" — override shank_len for partial-thread use.
// total_length is a representative stocked length; override freely.
// =============================================================

ws_0 = [
    ["id","ws_0"], ["family","wood_screw"], ["size","#0"],
    ["total_length", 9.53],
    ["shank_d", 1.524], ["shank_len", 0],
    ["thread_major_d", 1.524], ["thread_root_d", 1.016],
    ["thread_pitch", 0.794], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 3.02], ["head_h", 0.889], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.13], ["drive_depth", 0.40],
    ["tip_type", "gimlet"], ["tip_len", 1.19], ["tip_end_d", 0.15],
    ["color", [0.70, 0.70, 0.70]]
];

ws_1 = [
    ["id","ws_1"], ["family","wood_screw"], ["size","#1"],
    ["total_length", 9.53],
    ["shank_d", 1.854], ["shank_len", 0],
    ["thread_major_d", 1.854], ["thread_root_d", 1.245],
    ["thread_pitch", 0.907], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 3.71], ["head_h", 1.092], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.16], ["drive_depth", 0.49],
    ["tip_type", "gimlet"], ["tip_len", 1.36], ["tip_end_d", 0.18],
    ["color", [0.70, 0.70, 0.70]]
];

ws_2 = [
    ["id","ws_2"], ["family","wood_screw"], ["size","#2"],
    ["total_length", 9.53],
    ["shank_d", 2.184], ["shank_len", 0],
    ["thread_major_d", 2.184], ["thread_root_d", 1.448],
    ["thread_pitch", 0.977], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 4.37], ["head_h", 1.295], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.19], ["drive_depth", 0.58],
    ["tip_type", "gimlet"], ["tip_len", 1.47], ["tip_end_d", 0.22],
    ["color", [0.70, 0.70, 0.70]]
];

ws_3 = [
    ["id","ws_3"], ["family","wood_screw"], ["size","#3"],
    ["total_length", 12.70],
    ["shank_d", 2.515], ["shank_len", 0],
    ["thread_major_d", 2.515], ["thread_root_d", 1.702],
    ["thread_pitch", 1.058], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 5.05], ["head_h", 1.499], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.21], ["drive_depth", 0.67],
    ["tip_type", "gimlet"], ["tip_len", 1.59], ["tip_end_d", 0.25],
    ["color", [0.70, 0.70, 0.70]]
];

ws_4 = [
    ["id","ws_4"], ["family","wood_screw"], ["size","#4"],
    ["total_length", 12.70],
    ["shank_d", 2.845], ["shank_len", 0],
    ["thread_major_d", 2.845], ["thread_root_d", 1.905],
    ["thread_pitch", 1.155], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 5.72], ["head_h", 1.702], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.24], ["drive_depth", 0.77],
    ["tip_type", "gimlet"], ["tip_len", 1.73], ["tip_end_d", 0.28],
    ["color", [0.70, 0.70, 0.70]]
];

ws_5 = [
    ["id","ws_5"], ["family","wood_screw"], ["size","#5"],
    ["total_length", 15.88],
    ["shank_d", 3.175], ["shank_len", 0],
    ["thread_major_d", 3.175], ["thread_root_d", 2.108],
    ["thread_pitch", 1.270], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 6.40], ["head_h", 1.905], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.27], ["drive_depth", 0.86],
    ["tip_type", "gimlet"], ["tip_len", 1.91], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_6 = [
    ["id","ws_6"], ["family","wood_screw"], ["size","#6"],
    ["total_length", 19.05],
    ["shank_d", 3.505], ["shank_len", 0],
    ["thread_major_d", 3.505], ["thread_root_d", 2.337],
    ["thread_pitch", 1.411], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 7.09], ["head_h", 2.108], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.30], ["drive_depth", 0.95],
    ["tip_type", "gimlet"], ["tip_len", 2.12], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_7 = [
    ["id","ws_7"], ["family","wood_screw"], ["size","#7"],
    ["total_length", 19.05],
    ["shank_d", 3.835], ["shank_len", 0],
    ["thread_major_d", 3.835], ["thread_root_d", 2.515],
    ["thread_pitch", 1.588], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 7.75], ["head_h", 2.311], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.33], ["drive_depth", 1.04],
    ["tip_type", "gimlet"], ["tip_len", 2.38], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_8 = [
    ["id","ws_8"], ["family","wood_screw"], ["size","#8"],
    ["total_length", 25.40],
    ["shank_d", 4.166], ["shank_len", 0],
    ["thread_major_d", 4.166], ["thread_root_d", 2.743],
    ["thread_pitch", 1.693], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 8.43], ["head_h", 2.540], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.35], ["drive_depth", 1.14],
    ["tip_type", "gimlet"], ["tip_len", 2.54], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_9 = [
    ["id","ws_9"], ["family","wood_screw"], ["size","#9"],
    ["total_length", 25.40],
    ["shank_d", 4.496], ["shank_len", 0],
    ["thread_major_d", 4.496], ["thread_root_d", 2.946],
    ["thread_pitch", 1.814], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 9.09], ["head_h", 2.743], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.38], ["drive_depth", 1.23],
    ["tip_type", "gimlet"], ["tip_len", 2.72], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_10 = [
    ["id","ws_10"], ["family","wood_screw"], ["size","#10"],
    ["total_length", 31.75],
    ["shank_d", 4.826], ["shank_len", 0],
    ["thread_major_d", 4.826], ["thread_root_d", 3.150],
    ["thread_pitch", 1.954], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 9.78], ["head_h", 2.946], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.41], ["drive_depth", 1.33],
    ["tip_type", "gimlet"], ["tip_len", 2.93], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_11 = [
    ["id","ws_11"], ["family","wood_screw"], ["size","#11"],
    ["total_length", 31.75],
    ["shank_d", 5.156], ["shank_len", 0],
    ["thread_major_d", 5.156], ["thread_root_d", 3.353],
    ["thread_pitch", 2.117], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 10.44], ["head_h", 3.150], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.44], ["drive_depth", 1.42],
    ["tip_type", "gimlet"], ["tip_len", 3.18], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_12 = [
    ["id","ws_12"], ["family","wood_screw"], ["size","#12"],
    ["total_length", 38.10],
    ["shank_d", 5.486], ["shank_len", 0],
    ["thread_major_d", 5.486], ["thread_root_d", 3.556],
    ["thread_pitch", 2.309], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 11.13], ["head_h", 3.353], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.47], ["drive_depth", 1.51],
    ["tip_type", "gimlet"], ["tip_len", 3.46], ["tip_end_d", 0.30],
    ["color", [0.70, 0.70, 0.70]]
];

ws_14 = [
    ["id","ws_14"], ["family","wood_screw"], ["size","#14"],
    ["total_length", 50.80],
    ["shank_d", 6.147], ["shank_len", 0],
    ["thread_major_d", 6.147], ["thread_root_d", 3.962],
    ["thread_pitch", 2.540], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 12.47], ["head_h", 3.759], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.52], ["drive_depth", 1.69],
    ["tip_type", "gimlet"], ["tip_len", 3.81], ["tip_end_d", 0.35],
    ["color", [0.70, 0.70, 0.70]]
];

ws_16 = [
    ["id","ws_16"], ["family","wood_screw"], ["size","#16"],
    ["total_length", 63.50],
    ["shank_d", 6.807], ["shank_len", 0],
    ["thread_major_d", 6.807], ["thread_root_d", 4.369],
    ["thread_pitch", 2.822], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 13.82], ["head_h", 4.166], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.58], ["drive_depth", 1.87],
    ["tip_type", "gimlet"], ["tip_len", 4.23], ["tip_end_d", 0.35],
    ["color", [0.70, 0.70, 0.70]]
];

ws_18 = [
    ["id","ws_18"], ["family","wood_screw"], ["size","#18"],
    ["total_length", 76.20],
    ["shank_d", 7.468], ["shank_len", 0],
    ["thread_major_d", 7.468], ["thread_root_d", 4.750],
    ["thread_pitch", 3.175], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 15.16], ["head_h", 4.572], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.63], ["drive_depth", 2.06],
    ["tip_type", "gimlet"], ["tip_len", 4.76], ["tip_end_d", 0.40],
    ["color", [0.70, 0.70, 0.70]]
];

ws_20 = [
    ["id","ws_20"], ["family","wood_screw"], ["size","#20"],
    ["total_length", 76.20],
    ["shank_d", 8.128], ["shank_len", 0],
    ["thread_major_d", 8.128], ["thread_root_d", 5.131],
    ["thread_pitch", 3.175], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 16.51], ["head_h", 4.978], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.69], ["drive_depth", 2.24],
    ["tip_type", "gimlet"], ["tip_len", 4.76], ["tip_end_d", 0.40],
    ["color", [0.70, 0.70, 0.70]]
];

ws_24 = [
    ["id","ws_24"], ["family","wood_screw"], ["size","#24"],
    ["total_length", 101.60],
    ["shank_d", 9.449], ["shank_len", 0],
    ["thread_major_d", 9.449], ["thread_root_d", 5.944],
    ["thread_pitch", 3.629], ["thread_angle", 60],
    ["thread_profile", "wood"], ["threading", "full"],
    ["thread_starts", 1], ["thread_direction", "RH"],
    ["head_type", "flat"], ["head_d", 19.20], ["head_h", 5.791], ["head_angle", 82],
    ["drive_type", "slot"], ["drive_size", ""], ["drive_radius", 0.80], ["drive_depth", 2.61],
    ["tip_type", "gimlet"], ["tip_len", 5.44], ["tip_end_d", 0.45],
    ["color", [0.70, 0.70, 0.70]]
];


// Optional catalog list.
// Useful for loops / batch layouts.
screw_catalog = [
    deck_8x1_25,
    construction_10x3
];

// ANSI B18.6.1 standard wood screw catalog (all gauges).
// Source: parametric_screws/wood_screws_ANSI_B18.6.1.csv
// Drive: slotted (ANSI standard); override drive_type for modern variants.
ansi_wood_screw_catalog = [
    ws_0, ws_1, ws_2, ws_3, ws_4, ws_5, ws_6, ws_7,
    ws_8, ws_9, ws_10, ws_11, ws_12,
    ws_14, ws_16, ws_18, ws_20, ws_24
];
