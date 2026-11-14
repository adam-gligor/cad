
//
// ELECTRONICS ENCLOSURE
// Complete parametric design
//
// Main enclosure + bottom lid
// Mounting ears on short edge X=0
// Cable opening on short edge X=0
// Four-segment lid alignment guide
//
// Units: mm
//

$fn = 64;


// ==========================================
// CONFIGURATION
// ==========================================

// Internal dimensions
inner_x = 90;
inner_y = 50;
inner_z = 25;

// Wall thickness
wall = 2.5;
floor_thickness = 2.5;
roof_thickness = 3.0;

// External dimensions
outer_x = inner_x + 2*wall;
outer_y = inner_y + 2*wall;
outer_z = inner_z + roof_thickness;


// ==========================================
// LID
// ==========================================

lid_thickness = floor_thickness;

lid_guide_height = 4;
lid_guide_thickness = 1.2;
guide_clearance = 0.25;

boss_clearance = 0.5;


// ==========================================
// MOUNTING EARS
// ==========================================

ear_length = 10;
ear_width = 16;
ear_hole_diameter = 4.5;


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
// DISPLAY
// ==========================================

show_box = false;
show_lid = true;

assembly_gap = 8;


// ==========================================
// SCREW POSITIONS
// ==========================================

// Two diagonal screw positions

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
            // External shell and hollow interior
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

            // Screw bosses
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
        // ROOF VENTILATION
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
        // SHORT EDGE X=0
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
// LID ALIGNMENT GUIDE
// Four segments with boss clearance
// ==========================================

module alignment_guide()
{
    guide_x = wall + guide_clearance;
    guide_y = wall + guide_clearance;

    guide_w = inner_x - 2*guide_clearance;
    guide_d = inner_y - 2*guide_clearance;

    boss_radius = boss_diameter/2 + boss_clearance;

    difference()
    {
        union()
        {
            // Left guide wall
            translate([
                guide_x,
                guide_y,
                lid_thickness
            ])
                cube([
                    lid_guide_thickness,
                    guide_d,
                    lid_guide_height
                ]);


            // Right guide wall
            translate([
                guide_x+guide_w-lid_guide_thickness,
                guide_y,
                lid_thickness
            ])
                cube([
                    lid_guide_thickness,
                    guide_d,
                    lid_guide_height
                ]);


            // Front guide wall
            translate([
                guide_x,
                guide_y,
                lid_thickness
            ])
                cube([
                    guide_w,
                    lid_guide_thickness,
                    lid_guide_height
                ]);


            // Rear guide wall
            translate([
                guide_x,
                guide_y+guide_d-lid_guide_thickness,
                lid_thickness
            ])
                cube([
                    guide_w,
                    lid_guide_thickness,
                    lid_guide_height
                ]);
        }


        // Clearance around first screw boss
        translate([
            screw_positions[0][0],
            screw_positions[0][1],
            lid_thickness-0.1
        ])
            cylinder(
                h = lid_guide_height+0.2,
                r = boss_radius
            );


        // Clearance around second screw boss
        translate([
            screw_positions[1][0],
            screw_positions[1][1],
            lid_thickness-0.1
        ])
            cylinder(
                h = lid_guide_height+0.2,
                r = boss_radius
            );
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
            // MOUNTING EARS
            // SHORT EDGE X=0
            // ==================================

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


            // Alignment guide
            alignment_guide();
        }


        // ==================================
        // LID SCREW HOLES
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

        // First ear
        translate([
            -ear_length/2,
            ear_width/2,
            -0.1
        ])
            cylinder(
                h = lid_thickness+0.2,
                d = ear_hole_diameter
            );


        // Second ear
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


// Lid shown separately
if (show_lid)
{
    translate([
        outer_x+assembly_gap,
        0,
        0
    ])
        lid();
}
