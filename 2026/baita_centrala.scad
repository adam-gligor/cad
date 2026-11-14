
//
// ELECTRONICS ENCLOSURE
// Complete parametric design
//
// Main enclosure + bottom lid
// Continuous mounting flange on short edge X=0
// Cable opening on short edge X=0; configurable long-edge opening
// Reinforced corner screw bosses and four-segment lid alignment guide
//
// Units: mm
//

$fn = 64;


// ==========================================
// CONFIGURATION
// ==========================================

// Internal dimensions
inner_x = 92;
inner_y = 32;
inner_z = 25;

// Wall thickness
wall = 2;
floor_thickness = 1;
roof_thickness = 1;

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

// Corner reinforcement footprint and matching lid-guide corner relief.
boss_gusset_size = 8;
guide_corner_relief = boss_gusset_size + guide_clearance;


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

vent_diameter = 8;
vent_spacing = 11;
vent_margin = 7;


// ==========================================
// CABLE OPENING
// ==========================================

cable_opening_enabled = true;

cable_opening_width = 10;
cable_opening_height = 10;

// Additional opening on one of the long sides (Y=0 or Y=outer_y).
// side_opening_x is the opening centre measured from X=0.
side_opening_enabled = true;
side_opening_width = 10;
side_opening_height = 10;
side_opening_x = outer_x +4 -25;
side_opening_side = "Y0"; // "Y0" or "YMAX"


// ==========================================
// DISPLAY
// ==========================================

show_box = true;
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

            // Screw bosses with broad, full-height corner reinforcement.
            // Each corner pad fills more of the corner and blends into its boss.
            for (i = [0:len(screw_positions)-1])
            {
                p = screw_positions[i];

                hull()
                {
                    translate([p[0], p[1], 0])
                        cylinder(
                            h = inner_z,
                            d = boss_diameter
                        );

                    translate([
                        (i == 0) ? wall : outer_x-wall-boss_gusset_size,
                        (i == 0) ? wall : outer_y-wall-boss_gusset_size,
                        0
                    ])
                        cube([
                            boss_gusset_size,
                            boss_gusset_size,
                            inner_z
                        ]);
                }
            }
        }


        // ==================================
        // ROOF VENTILATION
        // ==================================

        // ==================================
        // ROOF VENTILATION
        // Exclude holes above screw bosses
        // for improved structural stability
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
                    // Skip ventilation holes at the two
                    // diagonal screw boss positions
                    skip_vent =
                        (sqrt(
                            pow(x-screw_positions[0][0], 2) +
                            pow(y-screw_positions[0][1], 2)
                        ) < boss_diameter/2 + vent_diameter/2) ||
                        (sqrt(
                            pow(x-screw_positions[1][0], 2) +
                            pow(y-screw_positions[1][1], 2)
                        ) < boss_diameter/2 + vent_diameter/2);

                    if (!skip_vent)
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

        // Configurable opening on either long edge.
        if (side_opening_enabled)
        {
            side_y = (side_opening_side == "YMAX")
                ? outer_y-wall-0.5
                : -0.5;

            translate([
                side_opening_x-side_opening_width/2,
                side_y,
                0
            ])
                cube([
                    side_opening_width,
                    wall+1,
                    side_opening_height
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

    // Leave the reinforced corners open so the lid can seat fully.
    guide_run_y = guide_d - 2*guide_corner_relief;
    guide_run_x = guide_w - 2*guide_corner_relief;

    boss_radius = boss_diameter/2 + boss_clearance;

    difference()
    {
        union()
        {
            // Left guide wall
            translate([
                guide_x,
                guide_y+guide_corner_relief,
                lid_thickness
            ])
                cube([
                    lid_guide_thickness,
                    guide_run_y,
                    lid_guide_height
                ]);


            // Right guide wall
            translate([
                guide_x+guide_w-lid_guide_thickness,
                guide_y+guide_corner_relief,
                lid_thickness
            ])
                cube([
                    lid_guide_thickness,
                    guide_run_y,
                    lid_guide_height
                ]);


            // Front guide wall
            translate([
                guide_x+guide_corner_relief,
                guide_y,
                lid_thickness
            ])
                cube([
                    guide_run_x,
                    lid_guide_thickness,
                    lid_guide_height
                ]);


            // Rear guide wall
            translate([
                guide_x+guide_corner_relief,
                guide_y+guide_d-lid_guide_thickness,
                lid_thickness
            ])
                cube([
                    guide_run_x,
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
            // CONTINUOUS MOUNTING FLANGE
            // SHORT EDGE X=0; spans the full lid width
            // ==================================

            translate([-ear_length, 0, 0])
                cube([
                    ear_length,
                    outer_y,
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
        // TWO MOUNTING HOLES IN THE CONTINUOUS FLANGE
        // ==================================

        // First flange hole
        translate([
            -ear_length/2,
            ear_width/2,
            -0.1
        ])
            cylinder(
                h = lid_thickness+0.2,
                d = ear_hole_diameter
            );


        // Second flange hole
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
    translate([0,outer_y,outer_z])
    rotate([180,0,0])
    enclosure();
}


// Lid shown separately
if (show_lid)
{
    translate([
        0,
        outer_y+1,
        0
    ])
        lid();
}
