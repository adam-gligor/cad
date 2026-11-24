
//
// PARAMETRIC ELECTRONICS ENCLOSURE
// Box + Flat Inset Lid
// Flush-mounted flat lid
// Four corner mounting wedges touching inside walls
// Z-axis inset only
// Front-left screw fastening
// Support-free tapered wedge undersides
// Reinforced screw area with ventilation exclusion
// Units: mm
//

$fn = 48;


// =====================================================
// CONFIGURATION
// =====================================================

// Internal dimensions
box_length = 100;
box_width  = 70;
box_height = 30;

// Box
wall_thickness   = 2;
bottom_thickness = 2;

// Lid
lid_thickness = 2;
lid_clearance = 0.25;

// PCB supports
pcb_support_size   = 8;
pcb_support_height = 5;

// Bottom mounting holes
mount_hole_diameter = 4;
mount_hole_offset   = 10;

// Ventilation
vent_hole_size = 4;
vent_spacing   = 4;
vent_margin    = 8;

// Screw
screw_diameter        = 3;
screw_hole_clearance  = 0.3;
screw_head_diameter   = 6;
screw_head_depth      = 1.2;
screw_pilot_diameter  = 2.5;
screw_hole_depth      = 3;

// Structural reinforcement around screw
// No ventilation holes within this radius
screw_ventilation_exclusion = 12;


// =====================================================
// BOX LOCATING WEDGES
// =====================================================

// Three standard corner wedges
corner_wedge_width  = 8;
corner_wedge_depth  = 8;
corner_wedge_height = 8;

// Larger FRONT-LEFT wedge
large_corner_width  = 14;
large_corner_depth  = 10;
large_corner_height = 8;


// =====================================================
// DISPLAY
// =====================================================

show_box = true;
show_lid = true;

display_spacing = 15;


// =====================================================
// DERIVED DIMENSIONS
// =====================================================

outer_length = box_length + 2 * wall_thickness;
outer_width  = box_width + 2 * wall_thickness;

box_top = bottom_thickness + box_height;

// Lid sits flush with box rim
lid_bottom = box_top - lid_thickness;

// Mounting wedges support the underside of the lid
mount_top = lid_bottom;


// =====================================================
// SCREW POSITION
// =====================================================

// Screw centred in the large front-left wedge

screw_position = [
    wall_thickness + large_corner_width / 2,
    wall_thickness + large_corner_depth / 2,
    box_top
];


// =====================================================
// BOX BODY
// =====================================================

module box_body() {

    difference() {

        // Outer box
        cube([
            outer_length,
            outer_width,
            box_top
        ]);

        // Internal cavity
        translate([
            wall_thickness,
            wall_thickness,
            bottom_thickness
        ])

        cube([
            box_length,
            box_width,
            box_height + 0.1
        ]);

        // Two bottom mounting holes
        for (x = [
            mount_hole_offset,
            outer_length - mount_hole_offset
        ]) {

            translate([
                x,
                outer_width / 2,
                -0.1
            ])

            cylinder(
                h = bottom_thickness + 0.2,
                d = mount_hole_diameter
            );
        }
    }

    // PCB supports
    pcb_supports();

    // Four corner lid mounting wedges
    box_corner_wedges();
}


// =====================================================
// PCB CORNER SUPPORTS
// =====================================================

module pcb_supports() {

    for (ix = [0:1]) {
        for (iy = [0:1]) {

            x_corner = ix == 0
                ? wall_thickness
                : wall_thickness + box_length;

            y_corner = iy == 0
                ? wall_thickness
                : wall_thickness + box_width;

            x_inner = ix == 0
                ? x_corner + pcb_support_size
                : x_corner - pcb_support_size;

            y_inner = iy == 0
                ? y_corner + pcb_support_size
                : y_corner - pcb_support_size;

            translate([
                0,
                0,
                bottom_thickness
            ])

            linear_extrude(
                height = pcb_support_height
            )

            polygon(points = [
                [x_corner, y_corner],
                [x_inner, y_corner],
                [x_corner, y_inner]
            ]);
        }
    }
}


// =====================================================
// BOX CORNER LOCATING WEDGES
// =====================================================

// All wedges:
// - Touch the inside box walls.
// - Retain their original X/Y positions.
// - Are lowered only in Z.
// - Have flat horizontal tops.
// - Have tapered undersides.

module box_corner_wedges() {

    difference() {

        union() {

            // FRONT LEFT - LARGE
            corner_wedge(
                wall_thickness,
                large_corner_width,
                large_corner_depth,
                large_corner_height,
                false
            );

            // FRONT RIGHT - STANDARD
            corner_wedge(
                outer_length - wall_thickness - corner_wedge_width,
                corner_wedge_width,
                corner_wedge_depth,
                corner_wedge_height,
                false
            );

            // BACK LEFT - STANDARD
            corner_wedge(
                wall_thickness,
                corner_wedge_width,
                corner_wedge_depth,
                corner_wedge_height,
                true
            );

            // BACK RIGHT - STANDARD
            corner_wedge(
                outer_length - wall_thickness - corner_wedge_width,
                corner_wedge_width,
                corner_wedge_depth,
                corner_wedge_height,
                true
            );
        }

        // Vertical screw pilot hole
        translate([
            screw_position[0],
            screw_position[1],
            mount_top - screw_hole_depth
        ])

        cylinder(
            h = screw_hole_depth + 0.2,
            d = screw_pilot_diameter
        );
    }
}


// =====================================================
// INDIVIDUAL CORNER WEDGE
// =====================================================

// X/Y positions remain against the inside walls.
// Only the Z position is lowered.

module corner_wedge(
    x_position,
    wedge_width,
    wedge_depth,
    wedge_height,
    back
) {

    x0 = x_position;
    x1 = x_position + wedge_width;

    // Front wall attachment
    y0 = wall_thickness - 0.1;

    // Z-axis inset only
    z0 = mount_top - wedge_height;
    z1 = mount_top;

    if (back) {

        translate([
            0,
            outer_width,
            0
        ])

        mirror([0,1,0])

        corner_wedge_geometry(
            x0,
            x1,
            y0,
            wedge_depth,
            z0,
            z1
        );

    } else {

        corner_wedge_geometry(
            x0,
            x1,
            y0,
            wedge_depth,
            z0,
            z1
        );
    }
}


// =====================================================
// CORNER WEDGE GEOMETRY
// =====================================================

module corner_wedge_geometry(
    x0,
    x1,
    y0,
    depth,
    z0,
    z1
) {

    y1 = y0 + depth;

    polyhedron(

        points = [

            // Bottom at wall
            [x0,y0,z0],
            [x1,y0,z0],

            // Top at wall
            [x1,y0,z1],
            [x0,y0,z1],

            // Inner top edge
            [x0,y1,z1],
            [x1,y1,z1]
        ],

        faces = [

            // Vertical wall attachment
            [0,3,2,1],

            // Sloping underside
            [0,1,5,4],

            // Left side
            [0,4,3],

            // Right side
            [1,2,5],

            // Flat horizontal top
            [3,4,5,2]
        ],

        convexity = 10
    );
}


// =====================================================
// FLAT INSET LID
// =====================================================

// Completely flat lid.
// No perimeter skirt.
// No raised edges.
// Lid top is flush with box rim.

module lid() {

    difference() {

        // Flat lid plate
        translate([
            wall_thickness + lid_clearance,
            wall_thickness + lid_clearance,
            0
        ])

        cube([
            box_length - 2 * lid_clearance,
            box_width - 2 * lid_clearance,
            lid_thickness
        ]);

        // Screw clearance hole
        translate([
            screw_position[0],
            screw_position[1],
            -0.1
        ])

        cylinder(
            h = lid_thickness + 0.2,
            d = screw_diameter + screw_hole_clearance
        );

        // Countersink
        translate([
            screw_position[0],
            screw_position[1],
            lid_thickness - screw_head_depth
        ])

        cylinder(
            h = screw_head_depth + 0.1,
            d1 = screw_diameter + screw_hole_clearance,
            d2 = screw_head_diameter
        );

        // Ventilation
        ventilation_grid();
    }
}


// =====================================================
// VENTILATION GRID
// =====================================================

// Ventilation holes are excluded from a 12 mm radius
// around the screw centre to preserve structural strength.

module ventilation_grid() {

    step = vent_hole_size + vent_spacing;

    for (
        x = [
            wall_thickness + vent_margin :
            step :
            wall_thickness + box_length
            - vent_margin - vent_hole_size
        ]
    ) {

        for (
            y = [
                wall_thickness + vent_margin :
                step :
                wall_thickness + box_width
                - vent_margin - vent_hole_size
            ]
        ) {

            // Centre of ventilation hole
            vent_x = x + vent_hole_size / 2;
            vent_y = y + vent_hole_size / 2;

            // Distance from screw centre
            screw_distance = sqrt(

                pow(
                    vent_x - screw_position[0],
                    2
                )

                +

                pow(
                    vent_y - screw_position[1],
                    2
                )
            );

            // Keep ventilation away from screw
            // and preserve surrounding lid material

            if (
                screw_distance >
                screw_ventilation_exclusion
            ) {

                translate([
                    x,
                    y,
                    -0.1
                ])

                cube([
                    vent_hole_size,
                    vent_hole_size,
                    lid_thickness + 0.2
                ]);
            }
        }
    }
}


// =====================================================
// ASSEMBLY PREVIEW
// =====================================================

// Box
if (show_box)
    box_body();

// Lid displayed separately at actual installed height
if (show_lid)

    translate([
        outer_length + display_spacing,
        0,
        mount_top
    ])

    lid();
