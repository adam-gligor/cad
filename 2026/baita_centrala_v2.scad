
//
// PARAMETRIC ELECTRONICS ENCLOSURE
// Box + Cap-style Lid
// Single fixed front screw fastening
// 45-degree support-free tapered screw wedge
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
lid_thickness       = 2;
lid_skirt_height    = 6;
lid_skirt_thickness = 2;
lid_clearance       = 0.25;

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

// Screw wedge
screw_wedge_width  = 12;
screw_wedge_depth  = 8;
screw_wedge_height = 8;

// Fixed screw position
fastener_position = 50;


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

lid_outer_length =
    outer_length + 2 * lid_clearance
    + 2 * lid_skirt_thickness;

lid_outer_width =
    outer_width + 2 * lid_clearance
    + 2 * lid_skirt_thickness;

lid_offset = lid_skirt_thickness + lid_clearance;


// =====================================================
// FIXED SCREW POSITION
// =====================================================

// Permanently located on the FRONT wall.
// Centred along the enclosure length.

screw_position = [
    wall_thickness + fastener_position,
    wall_thickness + screw_wedge_depth / 2,
    box_top
];

screw_lid_x = lid_offset + screw_position[0];
screw_lid_y = lid_offset + screw_position[1];


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

    pcb_supports();

    screw_wedge();
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
// SUPPORT-FREE TRIANGULAR SCREW WEDGE
// =====================================================

// Fixed to the inside of the FRONT wall.
//
// Geometry:
//
// - Flat horizontal top.
// - 45-degree tapered underside.
// - Vertical attachment to the front wall.
// - Full-width triangular prism.
// - Slight overlap with the inside wall.
// - Vertical blind screw pilot hole.
//
// The underside rises towards the centre of the box.
//
// Designed for printing with the box bottom on the
// build plate without requiring support material.


module screw_wedge() {

    difference() {

        x0 = screw_position[0] - screw_wedge_width / 2;
        x1 = screw_position[0] + screw_wedge_width / 2;

        // Front wall overlap
        y0 = wall_thickness - 0.1;

        // Inner edge
        y1 = y0 + screw_wedge_depth;

        // Bottom and top
        z0 = box_top - screw_wedge_height;
        z1 = box_top;

        // Fully enclosed solid wedge
        polyhedron(

            points = [

                [x0, y0, z0],  // 0
                [x1, y0, z0],  // 1
                [x1, y0, z1],  // 2
                [x0, y0, z1],  // 3

                [x0, y1, z1],  // 4
                [x1, y1, z1]   // 5
            ],

            faces = [

                // Bottom
                [0, 4, 5, 1],

                // Front
                [0, 1, 2, 3],

                // Top
                [3, 2, 5, 4],

                // Sloped underside
                [0, 3, 4],

                // Right side
                [1, 5, 2],

                // Left side
                [0, 4, 3],

                // Back triangular face
                [0, 5, 4, 1]
            ],

            convexity = 10
        );

        // Vertical blind screw pilot hole
        translate([
            screw_position[0],
            screw_position[1],
            box_top - screw_hole_depth
        ])

        cylinder(
            h = screw_hole_depth + 0.2,
            d = screw_pilot_diameter
        );
    }
}


// =====================================================
// LID
// =====================================================

module lid() {

    difference() {

        union() {

            // Top plate
            cube([
                lid_outer_length,
                lid_outer_width,
                lid_thickness
            ]);

            // Perimeter skirt
            translate([
                0,
                0,
                -lid_skirt_height
            ])

            difference() {

                cube([
                    lid_outer_length,
                    lid_outer_width,
                    lid_skirt_height
                ]);

                translate([
                    lid_skirt_thickness,
                    lid_skirt_thickness,
                    -0.1
                ])

                cube([
                    outer_length + 2 * lid_clearance,
                    outer_width + 2 * lid_clearance,
                    lid_skirt_height + 0.2
                ]);
            }
        }

        // Single screw clearance hole
        translate([
            screw_lid_x,
            screw_lid_y,
            -0.1
        ])

        cylinder(
            h = lid_thickness + 0.2,
            d = screw_diameter + screw_hole_clearance
        );

        // Countersink
        translate([
            screw_lid_x,
            screw_lid_y,
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

module ventilation_grid() {

    step = vent_hole_size + vent_spacing;

    for (
        x = [
            vent_margin :
            step :
            lid_outer_length - vent_margin - vent_hole_size
        ]
    ) {

        for (
            y = [
                vent_margin :
                step :
                lid_outer_width - vent_margin - vent_hole_size
            ]
        ) {

            // Distance from screw centre
            screw_distance = sqrt(

                pow(
                    x + vent_hole_size / 2 - screw_lid_x,
                    2
                )

                +

                pow(
                    y + vent_hole_size / 2 - screw_lid_y,
                    2
                )
            );

            // Keep ventilation away from screw head
            if (
                screw_distance >
                screw_head_diameter / 2 + 2
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

if (show_box)
    box_body();

if (show_lid)

    translate([
        outer_length + display_spacing,
        0,
        lid_skirt_height
    ])

    lid();
