
//
// PARAMETRIC ELECTRONICS ENCLOSURE
// OpenSCAD
//
// Parts:
//   "box"      = enclosure only
//   "lid"      = lid only
//   "assembly" = assembled enclosure
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

// Wall and floor
wall = 2.5;
floor_thickness = 2.5;

// Lid
lid_thickness = 2.0;

// Closing pins
pin_diameter = 4.0;
pin_length = 6.0;
pin_clearance = 0.25;

// Corner reinforcement
boss_size = 9;
socket_depth = 8;

// Pin exclusion zone
pin_exclusion = 6.5;

// Select part
part = "assembly";


// ============================================
// ZIP-TIE MOUNTING TUNNEL
// ============================================

zip_tie_enabled = true;

zip_tie_width = 4.5;
zip_tie_thickness = 1.8;
zip_tie_clearance = 0.3;

zip_tie_z = 6;


// ============================================
// CABLE OPENING
// ============================================

cable_opening_size = 12.5;


// ============================================
// HANGING EAR
// ============================================

hanging_ear_enabled = true;

ear_width = 15;
ear_length = 15;
ear_thickness = 5;

ear_hole_diameter = 6;
ear_overlap = 5;


// ============================================
// VENTILATION
// ============================================

square_size = 4;
square_spacing = 3.0;
square_border = 4.5;


// ============================================
// CALCULATED DIMENSIONS
// ============================================

outer_x = inner_x + 2*wall;
outer_y = inner_y + 2*wall;

box_height = inner_z + floor_thickness;

socket_diameter =
    pin_diameter + 2*pin_clearance;


// ============================================
// PIN POSITIONS
// ============================================

pin1_x = wall + boss_size/2;
pin1_y = wall + boss_size/2;

pin2_x = outer_x - wall - boss_size/2;
pin2_y = outer_y - wall - boss_size/2;


// ============================================
// CABLE OPENING
// Centered on short end wall
// Open from top edge
// ============================================

module cable_opening() {

    translate([
        outer_x - wall - 0.2,
        (outer_y-cable_opening_size)/2,
        floor_thickness + inner_z - cable_opening_size -5 
    ])

        cube([
            wall+0.4,
            cable_opening_size,
            cable_opening_size+0.2
        ]);
}


// ============================================
// REINFORCED HANGING EAR
// Opposite short end
// Integrated into enclosure floor
// ============================================

module hanging_ear() {

    if (hanging_ear_enabled) {

        difference() {

            // Main ear with reinforced root

            hull() {

                // Root overlapping enclosure floor
                translate([
                    outer_x-ear_overlap,
                    outer_y/2-ear_width/2,
                    -ear_thickness+ear_overlap 
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
                    -ear_thickness+ear_overlap
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
                -ear_thickness+ear_overlap-0.1
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
            wall + boss_size/2
                - (zip_tie_width + zip_tie_clearance)/2,
            floor_thickness + zip_tie_z
        ])

            cube([
                wall + boss_size + 0.2,
                zip_tie_width + zip_tie_clearance,
                zip_tie_thickness + zip_tie_clearance
            ]);
    }
}


// ============================================
// ENCLOSURE BOX
// ============================================

module enclosure_box() {

    difference() {

        union() {

            // Bottom plate
            cube([
                outer_x,
                outer_y,
                floor_thickness
            ]);

            // Left wall
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

            // Right wall
            translate([
                outer_x-wall,
                0,
                floor_thickness
            ])

                cube([
                    wall,
                    outer_y,
                    inner_z
                ]);

            // Front wall
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

            // Back wall
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

            // Reinforced corner boss 1
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

            // Reinforced corner boss 2
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

            // Existing zip-tie mounting feature
            zip_tie_slot();

            // Reinforced underside hanging ear
            hanging_ear();
        }


        // Closing socket 1
        translate([
            pin1_x,
            pin1_y,
            box_height-socket_depth
        ])

            cylinder(
                d=socket_diameter,
                h=socket_depth+0.1
            );


        // Closing socket 2
        translate([
            pin2_x,
            pin2_y,
            box_height-socket_depth
        ])

            cylinder(
                d=socket_diameter,
                h=socket_depth+0.1
            );


        // Centered cable opening
        cable_opening();
    }
}


// ============================================
// SQUARE VENTILATION PATTERN
// ============================================

module square_holes(
    surface_x,
    surface_y,
    offset_x=0,
    offset_y=0,
    border=square_border
) {

    pitch = square_size + square_spacing;

    cols = floor(
        (surface_x-2*border)/pitch
    );

    rows = floor(
        (surface_y-2*border)/pitch
    );

    for (row=[0:rows]) {

        for (col=[0:cols]) {

            x = offset_x + border
                + square_size/2 + col*pitch;

            y = offset_y + border
                + square_size/2 + row*pitch;

            // Avoid closing pin positions
            clear_pin1 =
                sqrt(
                    pow(x-pin1_x,2)
                    + pow(y-pin1_y,2)
                ) > pin_exclusion;

            clear_pin2 =
                sqrt(
                    pow(x-pin2_x,2)
                    + pow(y-pin2_y,2)
                ) > pin_exclusion;

            if (clear_pin1 && clear_pin2) {

                translate([
                    x-square_size/2,
                    y-square_size/2,
                    -0.1
                ])

                    cube([
                        square_size,
                        square_size,
                        lid_thickness+0.2
                    ]);
            }
        }
    }
}


// ============================================
// LID
// ============================================

module enclosure_lid() {

    union() {

        difference() {

            // Flat lid plate
            cube([
                outer_x,
                outer_y,
                lid_thickness
            ]);

            // Square ventilation holes
            square_holes(
                outer_x,
                outer_y
            );
        }


        // Closing pin 1
        translate([
            pin1_x,
            pin1_y,
            -pin_length
        ])

            cylinder(
                d=pin_diameter,
                h=pin_length
            );


        // Closing pin 2
        translate([
            pin2_x,
            pin2_y,
            -pin_length
        ])

            cylinder(
                d=pin_diameter,
                h=pin_length
            );
    }
}


// ============================================
// ASSEMBLY
// ============================================

module assembled_enclosure() {

    enclosure_box();

    // Lid positioned on top
    translate([
        0,
        0,
        box_height
    ])

        enclosure_lid();
}


// ============================================
// OUTPUT SELECTION
// ============================================

if (part=="box") {

    enclosure_box();

}
else if (part=="lid") {

    enclosure_lid();

}
else if (part=="assembly") {

    assembled_enclosure();

}
