
//
// PARAMETRIC ELECTRONICS ENCLOSURE
// External Top Lid with Internal Lid Supports
// Horizontal Side-Entry Screw
//
// Changes:
// - Lid supports moved from box to underside of lid.
// - Lid sits ON TOP of box.
// - Lid covers the complete external box footprint.
// - Horizontal screw enters through narrow end wall.
// - Screw engages pilot hole in lid support.
// - PCB supports and existing box features retained.
//

$fn = 48;


// =====================================================
// CONFIGURATION
// =====================================================

// Internal dimensions
box_length = 82;
box_width  = 21;
box_height = 30;

// Box
wall_thickness   = 1.4;
bottom_thickness = 1.4;

// Lid
lid_thickness = 1.4;
lid_clearance = 0.25;

// PCB supports
pcb_support_size   = 5;
pcb_support_height = 2;

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


// Screw reinforcement
screw_ventilation_exclusion = 12;


// =====================================================
// ADDITIONAL CIRCULAR HOLES
// =====================================================

// Existing horizontal hole in box side wall
box_side_hole_diameter = 10;
box_side_hole_y = 12;
box_side_hole_z = 10;

// Vertical hole in lid
lid_hole_diameter = 5;
lid_hole_x = 50;
lid_hole_y = 35;


// =====================================================
// LID SUPPORT DIMENSIONS
// =====================================================

large_corner_width  = 14;
large_corner_depth  = 10;
large_corner_height = 8;


// =====================================================
// DISPLAY
// =====================================================

show_box = true;
show_lid = false;

display_spacing = 15;


// =====================================================
// DERIVED DIMENSIONS
// =====================================================

outer_length = box_length + 2 * wall_thickness;
outer_width  = box_width + 2 * wall_thickness;

box_top = bottom_thickness + box_height;


// =====================================================
// HORIZONTAL SCREW POSITION
// =====================================================

// Screw enters horizontally through the first narrow end.
//
// X = screw insertion direction
// Y = centre of narrow end
// Z = 3 mm below top of box


// Screw enters horizontally through first narrow end.
// Positioned 6 mm below the top of the box.

screw_x = wall_thickness;
screw_y = outer_width / 2;
screw_z = box_top - 6;


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


        // Bottom mounting holes
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


        // Existing horizontal side-wall hole
        translate([
            -0.1,
            box_side_hole_y,
            box_side_hole_z
        ])

        rotate([0, 90, 0])

        cylinder(
            h = wall_thickness + 0.2,
            d = box_side_hole_diameter
        );


        // =================================================
        // NEW HORIZONTAL LID SCREW HOLE
        // =================================================

        // Screw clearance through box end wall


        translate([
            -0.1,
            screw_y,
            screw_z
        ])

        rotate([0, 90, 0])

        cylinder(
            h = wall_thickness + 0.2,
            d = screw_diameter + screw_hole_clearance
        );
    }


    // PCB supports remain in box

    pcb_supports();
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
// LID
// =====================================================

module lid() {

    difference() {

        union() {

            // =================================================
            // EXTERNAL TOP LID
            // =================================================

            // Lid covers complete external box dimensions.
            // Its bottom surface sits directly on box top.

            cube([
                outer_length,
                outer_width,
                lid_thickness
            ]);


            // =================================================
            // TWO SUPPORTS UNDERNEATH LID
            // =================================================

            lid_supports();
        }


        // =================================================
        // HORIZONTAL SCREW PILOT HOLE
        // =================================================

        // This hole runs horizontally into the first
        // support underneath the lid.

        translate([
            screw_x - 0.1,
            screw_y,
            -3
        ])

        rotate([0, 90, 0])

        cylinder(
            h = screw_hole_depth + 0.2,
            d = screw_pilot_diameter
        );


        // =================================================
        // ADDITIONAL LID HOLE
        // =================================================

        translate([
            lid_hole_x,
            lid_hole_y,
            -0.1
        ])

        cylinder(
            h = lid_thickness + 0.2,
            d = lid_hole_diameter
        );


        // =================================================
        // VENTILATION
        // =================================================

        ventilation_grid();
    }
}


// =====================================================
// LID SUPPORTS
// =====================================================

module lid_supports() {

    // Supports are attached to the UNDERSIDE of the lid.
    //
    // First narrow end:
    // Centred support WITH horizontal screw pilot hole.
    //
    // Opposite narrow end:
    // Centred support WITHOUT screw hole.

    end_support(
        (outer_width - large_corner_width) / 2,
        large_corner_width,
        large_corner_depth,
        large_corner_height,
        false
    );


    end_support(
        (outer_width - large_corner_width) / 2,
        large_corner_width,
        large_corner_depth,
        large_corner_height,
        true
    );
}


// =====================================================
// NARROW-END SUPPORT POSITIONING
// =====================================================

module end_support(
    y_position,
    support_width,
    support_depth,
    support_height,
    opposite_end
) {

    x0 = wall_thickness - 0.1;

    y0 = y_position;

    // Supports extend DOWN from the underside of the lid.

    z0 = -support_height;
    z1 = 0;


    if (opposite_end) {

        // Mirror support onto opposite narrow end

        translate([
            outer_length,
            0,
            0
        ])

        mirror([1, 0, 0])

        end_support_geometry(
            x0,
            y0,
            support_width,
            support_depth,
            z0,
            z1
        );

    } else {

        end_support_geometry(
            x0,
            y0,
            support_width,
            support_depth,
            z0,
            z1
        );
    }
}


// =====================================================
// SUPPORT GEOMETRY
// =====================================================

module end_support_geometry(
    x0,
    y0,
    support_width,
    support_depth,
    z0,
    z1
) {

    x1 = x0 + support_depth;
    y1 = y0 + support_width;

    polyhedron(

        points = [

            [x0, y0, z0],
            [x0, y1, z0],

            [x0, y1, z1],
            [x0, y0, z1],

            [x1, y0, z1],
            [x1, y1, z1]
        ],

        faces = [

            [0, 3, 2, 1],

            [0, 1, 5, 4],

            [0, 4, 3],

            [1, 2, 5],

            [3, 4, 5, 2]
        ],

        convexity = 10
    );
}


// =====================================================
// VENTILATION GRID
// =====================================================

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

            vent_x = x + vent_hole_size / 2;
            vent_y = y + vent_hole_size / 2;

            screw_distance = sqrt(

                pow(
                    vent_x - (wall_thickness + large_corner_depth / 2),
                    2
                )

                +

                pow(
                    vent_y - screw_y,
                    2
                )
            );

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

// Box remains in original position.

if (show_box)
    box_body();


// Lid shown separately to the right.
// Its supports are on the underside.

if (show_lid)

    translate([
        outer_length + display_spacing,
        0,
        box_top
    ])

    lid();
