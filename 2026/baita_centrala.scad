
//
// PARAMETRIC ELECTRONICS ENCLOSURE
// TWO-PIECE PRINTABLE DESIGN
//
// Parts:
//   "box"      = enclosure only
//   "roof"     = removable ventilated roof
//   "assembly" = assembled enclosure
//
// Roof attachment:
//   2 x M3 screws, diagonally opposite
//
// Units: mm
//

$fn = 64;


// ============================================
// USER PARAMETERS
// ============================================

// Internal dimensions
inner_x = 85;
inner_y = 40;
inner_z = 25;

// Walls and floor
wall = 2.5;
floor_thickness = 2.5;

// Roof
roof_thickness = 3.0;

// Screw mounting
boss_size = 9;
screw_diameter = 3.2;
screw_pilot_diameter = 2.5;
screw_depth = 8;

//// Zip-tie mounting tunnel
zip_tie_enabled = false;
zip_tie_width = 4.5;
zip_tie_thickness = 1.8;
zip_tie_clearance = 0.3;
zip_tie_z = 6;

// Hanging ear
hanging_ear_enabled = true;
ear_width = 16;
ear_projection = 20;
ear_thickness = 5;
ear_hole_diameter = 5;
ear_root_overlap = 8;

// Ventilation
square_size = 4;
square_spacing = 3;
square_border = 4.5;
vent_screw_exclusion = 6.5;

// Output selection
part = "box";


// ============================================
// CALCULATED DIMENSIONS
// ============================================

outer_x = inner_x + 2*wall;
outer_y = inner_y + 2*wall;

box_height = inner_z + floor_thickness;

// Screw positions
screw1_x = wall + boss_size/2;
screw1_y = wall + boss_size/2;

screw2_x = outer_x-wall-boss_size/2;
screw2_y = outer_y-wall-boss_size/2;


// ============================================
// HANGING EAR
// Right-hand short end
// Reinforced integrated mounting tab
// ============================================

module hanging_ear() {

    if (hanging_ear_enabled) {

        difference() {

            union() {

                // Main ear with reinforced root
                hull() {

                    translate([
                        outer_x-ear_root_overlap,
                        outer_y/2-ear_width/2,
                        0
                    ])

                        cube([
                            12,
                            ear_width,
                            ear_thickness
                        ]);

                    // Rounded outer end
                    translate([
                        outer_x+ear_projection-8,
                        outer_y/2,
                        0
                    ])

                        cylinder(
                            d=ear_width,
                            h=ear_thickness
                        );
                }

                // Reinforced triangular shoulders
                linear_extrude(height=ear_thickness)

                    polygon([
                        [outer_x-8, outer_y/2-ear_width/2-4],
                        [outer_x+8, outer_y/2-ear_width/2],
                        [outer_x-8, outer_y/2-ear_width/2]
                    ]);

                linear_extrude(height=ear_thickness)

                    polygon([
                        [outer_x-8, outer_y/2+ear_width/2+4],
                        [outer_x+8, outer_y/2+ear_width/2],
                        [outer_x-8, outer_y/2+ear_width/2]
                    ]);
            }

            // Zip-tie hole
            translate([
                outer_x+ear_projection-8,
                outer_y/2,
                -0.1
            ])

                cylinder(
                    d=ear_hole_diameter,
                    h=ear_thickness+0.2
                );
        }
    }
}


// ============================================
// ZIP-TIE MOUNTING TUNNEL
// ============================================

module zip_tie_slot() {

    if (zip_tie_enabled) {

        translate([
            -0.1,
            wall+boss_size/2
                -(zip_tie_width+zip_tie_clearance)/2,
            floor_thickness+zip_tie_z
        ])

            cube([
                wall+boss_size+0.2,
                zip_tie_width+zip_tie_clearance,
                zip_tie_thickness+zip_tie_clearance
            ]);
    }
}


// ============================================
// VENTILATION HOLES
// Square pattern
// ============================================

module square_holes() {

    pitch = square_size+square_spacing;

    cols = floor(
        (outer_x-2*square_border-square_size)/pitch
    );

    rows = floor(
        (outer_y-2*square_border-square_size)/pitch
    );

    for (row=[0:rows]) {

        for (col=[0:cols]) {

            x = square_border
                + square_size/2
                + col*pitch;

            y = square_border
                + square_size/2
                + row*pitch;

            // Keep ventilation away from screws
            clear_screw1 =
                sqrt(
                    pow(x-screw1_x,2)
                    + pow(y-screw1_y,2)
                ) > vent_screw_exclusion;

            clear_screw2 =
                sqrt(
                    pow(x-screw2_x,2)
                    + pow(y-screw2_y,2)
                ) > vent_screw_exclusion;

            if (clear_screw1 && clear_screw2) {

                translate([
                    x-square_size/2,
                    y-square_size/2,
                    -0.1
                ])

                    cube([
                        square_size,
                        square_size,
                        roof_thickness+0.2
                    ]);
            }
        }
    }
}


// ============================================
// MAIN ENCLOSURE
// Open top
// Open right-hand short end
// ============================================

module enclosure_box() {

    difference() {

        union() {

            // Floor
            cube([
                outer_x,
                outer_y,
                floor_thickness
            ]);

            // Left short wall
            translate([
                0,
                0,
                floor_thickness
            ])

                cube([
                    wall,
                    outer_y,
                    inner_z
                ]);

            // Front long wall
            translate([
                wall,
                0,
                floor_thickness
            ])

                cube([
                    inner_x,
                    wall,
                    inner_z
                ]);

            // Back long wall
            translate([
                wall,
                outer_y-wall,
                floor_thickness
            ])

                cube([
                    inner_x,
                    wall,
                    inner_z
                ]);

            // Reinforced screw boss 1
            translate([
                wall,
                wall,
                floor_thickness
            ])

                cube([
                    boss_size,
                    boss_size,
                    inner_z
                ]);

            // Reinforced screw boss 2
            translate([
                outer_x-wall-boss_size,
                outer_y-wall-boss_size,
                floor_thickness
            ])

                cube([
                    boss_size,
                    boss_size,
                    inner_z
                ]);

            // Hanging ear
            hanging_ear();
        }

        // M3 pilot hole 1
        translate([
            screw1_x,
            screw1_y,
            box_height-screw_depth
        ])

            cylinder(
                d=screw_pilot_diameter,
                h=screw_depth+0.1
            );

        // M3 pilot hole 2
        translate([
            screw2_x,
            screw2_y,
            box_height-screw_depth
        ])

            cylinder(
                d=screw_pilot_diameter,
                h=screw_depth+0.1
            );

        // Zip-tie mounting tunnel
        zip_tie_slot();
    }
}


// ============================================
// SEPARATE ROOF
// 3 mm thick
// Two diagonal M3 screw holes
// ============================================

module enclosure_roof() {

    difference() {

        // Roof plate
        cube([
            outer_x,
            outer_y,
            roof_thickness
        ]);

        // Ventilation holes
        square_holes();

        // Screw clearance hole 1
        translate([
            screw1_x,
            screw1_y,
            -0.1
        ])

            cylinder(
                d=screw_diameter,
                h=roof_thickness+0.2
            );

        // Screw clearance hole 2
        translate([
            screw2_x,
            screw2_y,
            -0.1
        ])

            cylinder(
                d=screw_diameter,
                h=roof_thickness+0.2
            );
    }
}


// ============================================
// ASSEMBLY PREVIEW
// ============================================

module assembled_enclosure() {

    enclosure_box();

    translate([
        0,
        0,
        box_height
    ])

        enclosure_roof();
}


// ============================================
// OUTPUT SELECTION
// ============================================

if (part=="box") {

    enclosure_box();

}
else if (part=="roof") {

    enclosure_roof();

}
else if (part=="assembly") {

    assembled_enclosure();

}
