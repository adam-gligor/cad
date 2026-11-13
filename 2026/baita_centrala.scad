
//
// PARAMETRIC ELECTRONICS ENCLOSURE
// OPEN END + INTEGRATED ROOF
//
// Parts:
//   "box"      = complete enclosure
//   "assembly" = complete enclosure
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

// Integrated roof
lid_thickness = 2.0;
roof_overlap = 0.3;

// Ventilation
square_size = 4;
square_spacing = 3.0;
square_border = 4.5;

// Zip-tie mounting tunnel
zip_tie_enabled = true;

zip_tie_width = 4.5;
zip_tie_thickness = 1.8;
zip_tie_clearance = 0.3;

zip_tie_z = 6;


// ============================================
// HANGING EAR
// ============================================

hanging_ear_enabled = true;

ear_width = 12;
ear_length = 16;

ear_thickness = floor_thickness;

ear_hole_diameter = 4.5;
ear_overlap = 1.5;


// ============================================
// OUTPUT SELECTION
// ============================================

part = "box";


// ============================================
// CALCULATED DIMENSIONS
// ============================================

outer_x = inner_x + 2*wall;
outer_y = inner_y + 2*wall;

box_height = inner_z + floor_thickness;


// ============================================
// HANGING EAR
// Right-hand short end
// Integrated into floor
// ============================================

module hanging_ear() {

    if (hanging_ear_enabled) {

        difference() {

            hull() {

                // Reinforced root
                translate([
                    outer_x-ear_overlap,
                    outer_y/2-ear_width/2,
                    0
                ])

                    cube([
                        6,
                        ear_width,
                        ear_thickness
                    ]);

                // Rounded outer end
                translate([
                    outer_x+ear_length-6,
                    outer_y/2,
                    0
                ])

                    cylinder(
                        d=ear_width,
                        h=ear_thickness
                    );
            }

            // Zip-tie hole
            translate([
                outer_x+ear_length-6,
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
            wall + 9/2
                - (zip_tie_width+zip_tie_clearance)/2,
            floor_thickness+zip_tie_z
        ])

            cube([
                wall+9+0.2,
                zip_tie_width+zip_tie_clearance,
                zip_tie_thickness+zip_tie_clearance
            ]);
    }
}


// ============================================
// ROOF VENTILATION
// Square holes through entire roof
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

            translate([
                x-square_size/2,
                y-square_size/2,
                -0.2
            ])

                cube([
                    square_size,
                    square_size,
                    lid_thickness+roof_overlap+0.4
                ]);
        }
    }
}


// ============================================
// INTEGRATED ROOF
// ============================================

module integrated_roof() {

    translate([
        0,
        0,
        box_height-roof_overlap
    ])

        difference() {

            cube([
                outer_x,
                outer_y,
                lid_thickness+roof_overlap
            ]);

            square_holes();
        }
}


// ============================================
// ENCLOSURE
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


            // LEFT SHORT WALL
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


            // FRONT LONG WALL
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


            // BACK LONG WALL
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


            // INTEGRATED ROOF
            integrated_roof();


            // HANGING EAR
            hanging_ear();
        }


        // ZIP-TIE TUNNEL
        zip_tie_slot();
    }
}


// ============================================
// OUTPUT
// ============================================

if (part=="box") {

    enclosure_box();

}
else if (part=="assembly") {

    enclosure_box();

}
