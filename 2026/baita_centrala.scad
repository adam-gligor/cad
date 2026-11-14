
//
// ELECTRONICS ENCLOSURE - REVISION 3
// Bottom lid with mounting ears
// Cable opening on short edge
//
// Units: mm
//

$fn = 64;


// ==========================================
// CONFIGURATION
// ==========================================

// Internal dimensions
inner_x = 85;
inner_y = 40;
inner_z = 25;

// Wall thickness
wall = 2.5;
floor_thickness = 2.5;
roof_thickness = 3;

// External dimensions
outer_x = inner_x + 2*wall;
outer_y = inner_y + 2*wall;
outer_z = inner_z + roof_thickness;


// ==========================================
// LID CONFIGURATION
// ==========================================

lid_thickness = floor_thickness;

lid_guide_height = 4;
lid_guide_thickness = 1.2;
guide_clearance = 0.25;


// ==========================================
// MOUNTING EARS
// ==========================================

ear_length = 9;
ear_width = 12;
ear_hole_diameter = 3.2;


// ==========================================
// LID SCREWS
// ==========================================

screw_clearance = 3.2;
boss_diameter = 7;
boss_hole = 2.7;

screw_inset = 7;


// ==========================================
// VENTILATION
// ==========================================

vent_enabled = true;

vent_diameter = 5;
vent_spacing = 8;
vent_margin = 7;


// ==========================================
// CABLE OPENING
// ==========================================

cable_opening_enabled = true;

cable_opening_width = 20;
cable_opening_height = 10;


// ==========================================
// DISPLAY OPTIONS
// ==========================================

show_box = true;
show_lid = true;

assembly_gap = 8;


// ==========================================
// SCREW POSITIONS
// ==========================================

// Two diagonal enclosure/lid screws

screw_positions = [
    [screw_inset, screw_inset],
    [outer_x-screw_inset, outer_y-screw_inset]
];


// ==========================================
// MAIN ENCLOSURE
// ==========================================

module enclosure()
{
    difference()
    {
        union()
        {
            // External shell with hollow interior
            difference()
            {
                cube([
                    outer_x,
                    outer_y,
                    outer_z
                ]);

                translate([
                    wall,
                    wall,
                    0
                ])
                    cube([
                        inner_x,
                        inner_y,
                        inner_z
                    ]);
            }

            // Internal screw bosses
            for (p = screw_positions)
            {
                translate([
                    p[0],
                    p[1],
                    0
                ])
                    cylinder(
                        h = inner_z,
                        d = boss_diameter
                    );
            }
        }


        // ==================================
        // ROOF VENTILATION HOLES
        // ==================================

        if (vent_enabled)
        {
            for (
                x = [
                    vent_margin:
                    vent_spacing:
                    outer_x-vent_margin
                ]
            )
            {
                for (
                    y = [
                        vent_margin:
                        vent_spacing:
                        outer_y-vent_margin
                    ]
                )
                {
                    translate([
                        x,
                        y,
                        inner_z
                    ])
                        cylinder(
                            h = roof_thickness+1,
                            d = vent_diameter
                        );
                }
            }
        }


        // ==================================
        // CABLE OPENING
        // SHORT EDGE: Y = outer_y
        // ==================================

        if (cable_opening_enabled)
        {
            translate([
                -0.5,
                (outer_y-cable_opening_width)/2,
                0
            ])
                cube([
                    wall+1,
                    cable_opening_width,
                    cable_opening_height
                ]);
        }


        // ==================================
        // SCREW HOLES IN BOSSES
        // ==================================

        for (p = screw_positions)
        {
            translate([
                p[0],
                p[1],
                -0.1
            ])
                cylinder(
                    h = inner_z+0.2,
                    d = boss_hole
                );
        }
    }
}


// ==========================================
// BOTTOM LID
// ==========================================

module lid()
{
    difference()
    {
        union()
        {
            // Main lid plate
            cube([
                outer_x,
                outer_y,
                lid_thickness
            ]);


            // ==================================
            // TWO MOUNTING EARS
            // SAME SHORT EDGE: Y = outer_y
            // ==================================

            // Two mounting ears on SHORT EDGE (X = 0)

            // First ear
            translate([
                -ear_length,
                0,
                0
            ])
                cube([
                    ear_length,
                    ear_width,
                    lid_thickness
                ]);

            // Second ear
            translate([
                -ear_length,
                outer_y-ear_width,
                0
            ])
                cube([
                    ear_length,
                    ear_width,
                    lid_thickness
                ]);


    
            // ==================================
            // INTERNAL ALIGNMENT GUIDE
            // ==================================

            translate([
                wall+guide_clearance,
                wall+guide_clearance,
                lid_thickness
            ])
            difference()
            {
                // Outer guide
                cube([
                    inner_x-2*guide_clearance,
                    inner_y-2*guide_clearance,
                    lid_guide_height
                ]);

                // Hollow guide
                translate([
                    lid_guide_thickness,
                    lid_guide_thickness,
                    -0.1
                ])
                    cube([
                        inner_x-2*guide_clearance
                            -2*lid_guide_thickness,

                        inner_y-2*guide_clearance
                            -2*lid_guide_thickness,

                        lid_guide_height+0.2
                    ]);
            }
        }


        // ==================================
        // LID SCREW CLEARANCE HOLES
        // ==================================

        for (p = screw_positions)
        {
            translate([
                p[0],
                p[1],
                -0.1
            ])
                cylinder(
                    h = lid_thickness+0.2,
                    d = screw_clearance
                );
        }


        // ==================================
        // MOUNTING HOLES IN EARS
        // ==================================

        // Mounting holes in ears

        translate([
            -ear_length/2,
            ear_width/2,
            -0.1
        ])
            cylinder(
                h = lid_thickness+0.2,
                d = ear_hole_diameter
            );

        translate([
            -ear_length/2,
            outer_y-ear_width/2,
            -0.1
        ])
            cylinder(
                h = lid_thickness+0.2,
                d = ear_hole_diameter
            );
            }
        }


// ==========================================
// OUTPUT
// ==========================================

// Main enclosure
if (show_box)
{
    enclosure();
}


// Lid displayed separately
if (show_lid)
{
    translate([
        outer_x+assembly_gap,
        0,
        0
    ])
        lid();
}
