//
// PARAMETRIC ELECTRONICS ENCLOSURE
// External Top Lid with Internal Lid Supports
// Horizontal Side-Entry Screw
// Four-Sided Lid Alignment Guides
//
// Changes:
// - Removed ventilation holes from the lid.
// - Aligned lid pilot hole with the box-side screw hole.
// - Added configurable circular ventilation holes to one selected box side.
// - Lid supports moved from box to underside of lid.
// - Lid sits ON TOP of box.
// - Lid covers complete external box footprint.
// - Horizontal screw enters through narrow end wall.
// - Screw engages pilot hole in lid support.
// - Original screw-hole support retained.
// - Opposite solid support removed.
// - Four alignment guides added underneath lid.
// - Guide width, height and clearance configurable.
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
pcb_support_height = 4;


// Bottom mounting holes
mount_hole_diameter = 4;
mount_hole_offset   = 10;


// =====================================================
// SIDE-WALL VENTILATION GRID
// =====================================================

side_vent_wall = "back"; // "front", "back", "left", "right"

side_vent_diameter = 5;

// Horizontal spacing between holes
side_vent_spacing = 8;

// Vertical spacing between rows
side_vent_vertical_spacing = 8;

// Distance from horizontal edges
side_vent_margin = 8;

// Distance from top and bottom edges
side_vent_vertical_margin = 6;



// Screw
screw_diameter        = 3;
screw_hole_clearance  = 0.3;
screw_head_diameter   = 6;
screw_head_depth      = 1.2;
screw_pilot_diameter  = 2.5;
screw_hole_depth      = 3;


// =====================================================
// ADDITIONAL CIRCULAR HOLES
// =====================================================

// Existing horizontal hole in box side wall
box_side_hole_diameter = 5;
box_side_hole_y = 12;
box_side_hole_z = 14;


// Vertical hole in lid
lid_hole_diameter = 5;
lid_hole_x = 50;
lid_hole_y = 35;


// =====================================================
// LID SUPPORT DIMENSIONS
// =====================================================

large_corner_width  = 10;
large_corner_depth  = 14;
large_corner_height = 12;


// =====================================================
// LID ALIGNMENT GUIDES
// =====================================================

lid_guide_width     = 2;
lid_guide_height    = 2;
lid_guide_clearance = 0.2;


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


// =====================================================
// HORIZONTAL SCREW POSITION
// =====================================================

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


        // Horizontal lid screw hole

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


        // Configurable circular side ventilation

        side_wall_ventilation();
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

            // External top lid

            cube([
                outer_length,
                outer_width,
                lid_thickness
            ]);


            // Original screw support + alignment guides

            lid_supports();
        }


        // Horizontal screw pilot hole
        // Z position aligned with box screw hole

        translate([
            screw_x - 0.1,
            screw_y,
            screw_z - box_top
        ])

        rotate([0, 90, 0])

        cylinder(
            h = screw_hole_depth + 0.2,
            d = screw_pilot_diameter
        );


        // Additional lid hole

        translate([
            lid_hole_x,
            lid_hole_y,
            -0.1
        ])

        cylinder(
            h = lid_thickness + 0.2,
            d = lid_hole_diameter
        );

    }
}


// =====================================================
// LID SUPPORTS + ALIGNMENT GUIDES
// =====================================================

module lid_supports() {

    // Keep original screw-hole mounting support
    // at first narrow end.

    end_support(
        (outer_width - large_corner_width) / 2,
        large_corner_width,
        large_corner_depth,
        large_corner_height,
        false
    );


    // Four alignment guides underneath lid

    lid_alignment_guides();
}


// =====================================================
// FOUR-SIDED LID ALIGNMENT GUIDES
// =====================================================

module lid_alignment_guides() {

    guide_length_x =
        box_length - 2 * lid_guide_clearance;

    guide_length_y =
        box_width - 2 * lid_guide_clearance;


    // LEFT EDGE

    translate([
        wall_thickness + lid_guide_clearance,
        wall_thickness + lid_guide_clearance,
        -lid_guide_height
    ])

    cube([
        lid_guide_width,
        guide_length_y,
        lid_guide_height
    ]);


    // RIGHT EDGE

    translate([
        wall_thickness + box_length
            - lid_guide_width
            - lid_guide_clearance,

        wall_thickness + lid_guide_clearance,

        -lid_guide_height
    ])

    cube([
        lid_guide_width,
        guide_length_y,
        lid_guide_height
    ]);


    // FRONT EDGE

    translate([
        wall_thickness + lid_guide_clearance,
        wall_thickness + lid_guide_clearance,
        -lid_guide_height
    ])

    cube([
        guide_length_x,
        lid_guide_width,
        lid_guide_height
    ]);


    // BACK EDGE

    translate([
        wall_thickness + lid_guide_clearance,

        wall_thickness + box_width
            - lid_guide_width
            - lid_guide_clearance,

        -lid_guide_height
    ])

    cube([
        guide_length_x,
        lid_guide_width,
        lid_guide_height
    ]);
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

    z0 = -support_height;
    z1 = 0;


    if (opposite_end) {

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
// CONFIGURABLE CIRCULAR SIDE-WALL VENTILATION GRID
// =====================================================

module side_wall_ventilation() {

    // FRONT OR BACK WALL
    // Holes distributed horizontally and vertically

    if (side_vent_wall == "front" ||
        side_vent_wall == "back") {

        for (
            x = [
                wall_thickness + side_vent_margin :
                side_vent_spacing :
                outer_length - wall_thickness - side_vent_margin
            ]
        ) {

            for (
                z = [
                    bottom_thickness + side_vent_vertical_margin :
                    side_vent_vertical_spacing :
                    box_top - side_vent_vertical_margin
                ]
            ) {

                if (side_vent_wall == "front") {

                    translate([
                        x,
                        -0.1,
                        z
                    ])

                    rotate([-90, 0, 0])

                    cylinder(
                        h = wall_thickness + 0.2,
                        d = side_vent_diameter
                    );

                } else {

                    translate([
                        x,
                        outer_width + 0.1,
                        z
                    ])

                    rotate([90, 0, 0])

                    cylinder(
                        h = wall_thickness + 0.2,
                        d = side_vent_diameter
                    );
                }
            }
        }


    // LEFT OR RIGHT WALL
    // Holes distributed horizontally and vertically

    } else if (
        side_vent_wall == "left" ||
        side_vent_wall == "right"
    ) {

        for (
            y = [
                wall_thickness + side_vent_margin :
                side_vent_spacing :
                outer_width - wall_thickness - side_vent_margin
            ]
        ) {

            for (
                z = [
                    bottom_thickness + side_vent_vertical_margin :
                    side_vent_vertical_spacing :
                    box_top - side_vent_vertical_margin
                ]
            ) {

                if (side_vent_wall == "left") {

                    translate([
                        -0.1,
                        y,
                        z
                    ])

                    rotate([0, 90, 0])

                    cylinder(
                        h = wall_thickness + 0.2,
                        d = side_vent_diameter
                    );

                } else {

                    translate([
                        outer_length + 0.1,
                        y,
                        z
                    ])

                    rotate([0, -90, 0])

                    cylinder(
                        h = wall_thickness + 0.2,
                        d = side_vent_diameter
                    );
                }
            }
        }

    } else {

        echo(
            "ERROR: side_vent_wall must be front, back, left, or right"
        );

    }
}


// =====================================================
// ASSEMBLY PREVIEW
// =====================================================

// Box remains in original position.

if (show_box)
    box_body();


// Lid shown separately to the right.
// Alignment guides and screw support underneath.

if (show_lid)

    translate([
        outer_length + display_spacing,
        0,
        box_top
    ])

    lid();