//
// ============================================================
// PARAMETRIC MULTI-ENCLOSURE LIBRARY
// ============================================================
//
// FEATURES
//
// 1. Reusable enclosure module
// 2. Reusable box module
// 3. Reusable lid module
// 4. Multiple identical enclosures
// 5. Multiple individually configured enclosures
// 6. Automatic grid positioning
// 7. PCB corner supports
// 8. Bottom mounting holes
// 9. Horizontal side-entry screw
// 10. Four-sided lid alignment guides
// 11. Configurable side-wall ventilation
// 12. Additional circular holes
//
// Units: mm
//

$fn = 48;


// ============================================================
// 1. DEFAULT PARAMETERS
// ============================================================

// Internal dimensions

default_length = 82;
default_width  = 21;
default_height = 30;


// Box walls

default_wall   = 1.4;
default_bottom = 1.4;


// Lid

default_lid_thickness = 1.4;


// PCB supports

default_pcb_size   = 5;
default_pcb_height = 4;


// Bottom mounting holes

default_mount_diameter = 4;
default_mount_offset   = 10;


// Screw

default_screw_diameter       = 3;
default_screw_clearance      = 0.3;
default_screw_pilot_diameter = 2.5;
default_screw_hole_depth     = 3;


// Lid screw support

default_support_width  = 10;
default_support_depth  = 14;
default_support_height = 12;


// Lid alignment guides

default_guide_width     = 2;
default_guide_height    = 2;
default_guide_clearance = 0.2;


// Additional box-side hole

default_side_hole_diameter = 6;
default_side_hole_y = 12;
default_side_hole_z = 14;


// Additional lid hole

default_lid_hole_diameter = 5;
default_lid_hole_x = 50;
default_lid_hole_y = 35;


// Ventilation

default_vent_wall = "back";

default_vent_diameter = 5;
default_vent_spacing = 8;
default_vent_vertical_spacing = 8;

default_vent_margin = 8;
default_vent_vertical_margin = 6;


// ============================================================
// 2. BOX BODY
// ============================================================

module box_body(

    length = default_length,
    width = default_width,
    height = default_height,

    wall = default_wall,
    bottom = default_bottom,

    pcb_size = default_pcb_size,
    pcb_height = default_pcb_height,

    mount_diameter = default_mount_diameter,
    mount_offset = default_mount_offset,

    screw_diameter = default_screw_diameter,
    screw_clearance = default_screw_clearance,

    side_hole_diameter = default_side_hole_diameter,
    side_hole_y = default_side_hole_y,
    side_hole_z = default_side_hole_z,

    vent_enabled = true,
    vent_wall = default_vent_wall,
    vent_diameter = default_vent_diameter,
    vent_spacing = default_vent_spacing,
    vent_vertical_spacing = default_vent_vertical_spacing,
    vent_margin = default_vent_margin,
    vent_vertical_margin = default_vent_vertical_margin,

    pcb_enabled = true,
    mount_enabled = true,
    side_hole_enabled = true,
    screw_enabled = true

) {

    outer_length = length + 2*wall;
    outer_width  = width + 2*wall;

    box_top = bottom + height;


    difference() {

        // OUTER BOX

        cube([
            outer_length,
            outer_width,
            box_top
        ]);


        // INTERNAL CAVITY

        translate([
            wall,
            wall,
            bottom
        ])

        cube([
            length,
            width,
            height + 0.1
        ]);


        // BOTTOM MOUNTING HOLES

        if (mount_enabled) {

            for (x = [
                mount_offset,
                outer_length - mount_offset
            ]) {

                translate([
                    x,
                    outer_width/2,
                    -0.1
                ])

                cylinder(
                    h = bottom + 0.2,
                    d = mount_diameter
                );

            }

        }


        // ADDITIONAL HORIZONTAL SIDE HOLE

        if (side_hole_enabled) {

            translate([
                -0.1,
                side_hole_y,
                side_hole_z
            ])

            rotate([0,90,0])

            cylinder(
                h = wall + 0.2,
                d = side_hole_diameter
            );

        }


        // HORIZONTAL LID SCREW HOLE

        if (screw_enabled) {

            screw_y = outer_width/2;
            screw_z = box_top - 6;

            translate([
                -0.1,
                screw_y,
                screw_z
            ])

            rotate([0,90,0])

            cylinder(
                h = wall + 0.2,
                d = screw_diameter + screw_clearance
            );

        }


        // SIDE WALL VENTILATION

        if (vent_enabled) {

            side_wall_ventilation(

                length,
                width,
                height,

                wall,
                bottom,

                vent_wall,
                vent_diameter,
                vent_spacing,
                vent_vertical_spacing,

                vent_margin,
                vent_vertical_margin

            );

        }

    }


    // PCB SUPPORTS

    if (pcb_enabled) {

        pcb_supports(

            length,
            width,

            wall,
            bottom,

            pcb_size,
            pcb_height

        );

    }

}


// ============================================================
// 3. PCB CORNER SUPPORTS
// ============================================================

module pcb_supports(

    length,
    width,

    wall,
    bottom,

    support_size,
    support_height

) {

    for (ix = [0:1]) {

        for (iy = [0:1]) {

            x_corner = ix == 0
                ? wall
                : wall + length;

            y_corner = iy == 0
                ? wall
                : wall + width;


            x_inner = ix == 0
                ? x_corner + support_size
                : x_corner - support_size;

            y_inner = iy == 0
                ? y_corner + support_size
                : y_corner - support_size;


            translate([
                0,
                0,
                bottom
            ])

            linear_extrude(
                height = support_height
            )

            polygon(points = [

                [x_corner, y_corner],

                [x_inner, y_corner],

                [x_corner, y_inner]

            ]);

        }

    }

}


// ============================================================
// 4. LID
// ============================================================

module lid(

    length = default_length,
    width = default_width,
    height = default_height,

    wall = default_wall,
    bottom = default_bottom,

    thickness = default_lid_thickness,

    screw_pilot_diameter = default_screw_pilot_diameter,
    screw_hole_depth = default_screw_hole_depth,

    support_width = default_support_width,
    support_depth = default_support_depth,
    support_height = default_support_height,

    guide_width = default_guide_width,
    guide_height = default_guide_height,
    guide_clearance = default_guide_clearance,

    lid_hole_enabled = true,
    lid_hole_diameter = default_lid_hole_diameter,
    lid_hole_x = default_lid_hole_x,
    lid_hole_y = default_lid_hole_y,

    support_enabled = true,
    guides_enabled = true

) {

    outer_length = length + 2*wall;
    outer_width  = width + 2*wall;

    box_top = bottom + height;

    screw_x = wall;
    screw_y = outer_width/2;
    screw_z = box_top - 6;


    difference() {

        union() {

            // EXTERNAL LID

            cube([
                outer_length,
                outer_width,
                thickness
            ]);


            // SUPPORTS AND GUIDES

            lid_supports(

                length,
                width,
                wall,
                outer_width,

                support_width,
                support_depth,
                support_height,

                guide_width,
                guide_height,
                guide_clearance,

                support_enabled,
                guides_enabled

            );

        }


        // HORIZONTAL SCREW PILOT HOLE

        translate([
            screw_x - 0.1,
            screw_y,
            screw_z - box_top
        ])

        rotate([0,90,0])

        cylinder(
            h = screw_hole_depth + 0.2,
            d = screw_pilot_diameter
        );


        // ADDITIONAL VERTICAL LID HOLE

        if (lid_hole_enabled) {

            translate([
                lid_hole_x,
                lid_hole_y,
                -0.1
            ])

            cylinder(
                h = thickness + 0.2,
                d = lid_hole_diameter
            );

        }

    }

}


// ============================================================
// 5. LID SUPPORTS
// ============================================================

module lid_supports(

    length,
    width,
    wall,
    outer_width,

    support_width,
    support_depth,
    support_height,

    guide_width,
    guide_height,
    guide_clearance,

    support_enabled,
    guides_enabled

) {

    // ORIGINAL SCREW SUPPORT

    if (support_enabled) {

        end_support(

            wall - 0.1,

            (outer_width - support_width)/2,

            support_width,
            support_depth,
            support_height

        );

    }


    // FOUR ALIGNMENT GUIDES

    if (guides_enabled) {

        lid_alignment_guides(

            length,
            width,
            wall,

            guide_width,
            guide_height,
            guide_clearance

        );

    }

}


// ============================================================
// 6. FOUR-SIDED LID ALIGNMENT GUIDES
// ============================================================

module lid_alignment_guides(

    length,
    width,
    wall,

    guide_width,
    guide_height,
    clearance

) {

    guide_length_x = length - 2*clearance;
    guide_length_y = width - 2*clearance;


    // LEFT GUIDE

    translate([
        wall + clearance,
        wall + clearance,
        -guide_height
    ])

    cube([
        guide_width,
        guide_length_y,
        guide_height
    ]);


    // RIGHT GUIDE

    translate([
        wall + length - guide_width - clearance,
        wall + clearance,
        -guide_height
    ])

    cube([
        guide_width,
        guide_length_y,
        guide_height
    ]);


    // FRONT GUIDE

    translate([
        wall + clearance,
        wall + clearance,
        -guide_height
    ])

    cube([
        guide_length_x,
        guide_width,
        guide_height
    ]);


    // BACK GUIDE

    translate([
        wall + clearance,
        wall + width - guide_width - clearance,
        -guide_height
    ])

    cube([
        guide_length_x,
        guide_width,
        guide_height
    ]);

}


// ============================================================
// 7. ORIGINAL NARROW-END SCREW SUPPORT
// ============================================================

module end_support(

    x_position,
    y_position,

    support_width,
    support_depth,
    support_height

) {

    x0 = x_position;
    y0 = y_position;

    x1 = x0 + support_depth;
    y1 = y0 + support_width;

    z0 = -support_height;
    z1 = 0;


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

            [0,3,2,1],

            [0,1,5,4],

            [0,4,3],

            [1,2,5],

            [3,4,5,2]

        ],

        convexity = 10

    );

}


// ============================================================
// 8. CONFIGURABLE SIDE WALL VENTILATION
// ============================================================

module side_wall_ventilation(

    length,
    width,
    height,

    wall,
    bottom,

    selected_wall,

    diameter,
    spacing,
    vertical_spacing,

    margin,
    vertical_margin

) {

    outer_length = length + 2*wall;
    outer_width = width + 2*wall;

    box_top = bottom + height;


    // FRONT OR BACK WALL

    if (
        selected_wall == "front" ||
        selected_wall == "back"
    ) {

        for (
            x = [
                wall + margin :
                spacing :
                outer_length - wall - margin
            ]
        ) {

            for (
                z = [
                    bottom + vertical_margin :
                    vertical_spacing :
                    box_top - vertical_margin
                ]
            ) {

                if (selected_wall == "front") {

                    translate([
                        x,
                        -0.1,
                        z
                    ])

                    rotate([-90,0,0])

                    cylinder(
                        h = wall + 0.2,
                        d = diameter
                    );

                }

                else {

                    translate([
                        x,
                        outer_width + 0.1,
                        z
                    ])

                    rotate([90,0,0])

                    cylinder(
                        h = wall + 0.2,
                        d = diameter
                    );

                }

            }

        }

    }


    // LEFT OR RIGHT WALL

    else if (
        selected_wall == "left" ||
        selected_wall == "right"
    ) {

        for (
            y = [
                wall + margin :
                spacing :
                outer_width - wall - margin
            ]
        ) {

            for (
                z = [
                    bottom + vertical_margin :
                    vertical_spacing :
                    box_top - vertical_margin
                ]
            ) {

                if (selected_wall == "left") {

                    translate([
                        -0.1,
                        y,
                        z
                    ])

                    rotate([0,90,0])

                    cylinder(
                        h = wall + 0.2,
                        d = diameter
                    );

                }

                else {

                    translate([
                        outer_length + 0.1,
                        y,
                        z
                    ])

                    rotate([0,-90,0])

                    cylinder(
                        h = wall + 0.2,
                        d = diameter
                    );

                }

            }

        }

    }

    else {

        echo(
            "ERROR: Vent wall must be front, back, left or right"
        );

    }

}


// ============================================================
// 9. COMPLETE REUSABLE ENCLOSURE
// ============================================================

module enclosure(

    length = default_length,
    width = default_width,
    height = default_height,

    wall = default_wall,
    bottom = default_bottom,

    lid_thickness = default_lid_thickness,

    pcb_size = default_pcb_size,
    pcb_height = default_pcb_height,

    mount_diameter = default_mount_diameter,
    mount_offset = default_mount_offset,

    screw_diameter = default_screw_diameter,
    screw_clearance = default_screw_clearance,

    screw_pilot_diameter = default_screw_pilot_diameter,
    screw_hole_depth = default_screw_hole_depth,

    support_width = default_support_width,
    support_depth = default_support_depth,
    support_height = default_support_height,

    guide_width = default_guide_width,
    guide_height = default_guide_height,
    guide_clearance = default_guide_clearance,

    vent_enabled = true,
    vent_wall = default_vent_wall,
    vent_diameter = default_vent_diameter,
    vent_spacing = default_vent_spacing,
    vent_vertical_spacing = default_vent_vertical_spacing,
    vent_margin = default_vent_margin,
    vent_vertical_margin = default_vent_vertical_margin,

    pcb_enabled = true,
    mount_enabled = true,
    side_hole_enabled = true,
    screw_enabled = true,

    side_hole_diameter = default_side_hole_diameter,
    side_hole_y = default_side_hole_y,
    side_hole_z = default_side_hole_z,

    lid_hole_enabled = true,
    lid_hole_diameter = default_lid_hole_diameter,
    lid_hole_x = default_lid_hole_x,
    lid_hole_y = default_lid_hole_y,

    support_enabled = true,
    guides_enabled = true,

    show_box = true,
    show_lid = true,

    lid_separate = false,
    display_spacing = 15

) {

    outer_length = length + 2*wall;
    outer_width = width + 2*wall;

    box_top = bottom + height;


    // BOX BODY

    if (show_box) {

        box_body(

            length = length,
            width = width,
            height = height,

            wall = wall,
            bottom = bottom,

            pcb_size = pcb_size,
            pcb_height = pcb_height,

            mount_diameter = mount_diameter,
            mount_offset = mount_offset,

            screw_diameter = screw_diameter,
            screw_clearance = screw_clearance,

            side_hole_diameter = side_hole_diameter,
            side_hole_y = side_hole_y,
            side_hole_z = side_hole_z,

            vent_enabled = vent_enabled,
            vent_wall = vent_wall,
            vent_diameter = vent_diameter,
            vent_spacing = vent_spacing,
            vent_vertical_spacing = vent_vertical_spacing,
            vent_margin = vent_margin,
            vent_vertical_margin = vent_vertical_margin,

            pcb_enabled = pcb_enabled,
            mount_enabled = mount_enabled,
            side_hole_enabled = side_hole_enabled,
            screw_enabled = screw_enabled

        );

    }


    // LID

    if (show_lid) {

        translate([

            lid_separate
                ? outer_length + display_spacing
                : 0,

            0,

            box_top

        ])

        lid(

            length = length,
            width = width,
            height = height,

            wall = wall,
            bottom = bottom,

            thickness = lid_thickness,

            screw_pilot_diameter = screw_pilot_diameter,
            screw_hole_depth = screw_hole_depth,

            support_width = support_width,
            support_depth = support_depth,
            support_height = support_height,

            guide_width = guide_width,
            guide_height = guide_height,
            guide_clearance = guide_clearance,

            lid_hole_enabled = lid_hole_enabled,
            lid_hole_diameter = lid_hole_diameter,
            lid_hole_x = lid_hole_x,
            lid_hole_y = lid_hole_y,

            support_enabled = support_enabled,
            guides_enabled = guides_enabled

        );

    }

}


// ============================================================
// 10. MULTIPLE IDENTICAL ENCLOSURES
// ============================================================

module enclosure_grid(

    count_x = 2,
    count_y = 2,

    spacing_x = 20,
    spacing_y = 20,

    length = default_length,
    width = default_width,
    height = default_height,

    wall = default_wall,
    bottom = default_bottom,

    show_box = true,
    show_lid = true,

    lid_separate = false

) {

    outer_length = length + 2*wall;
    outer_width = width + 2*wall;


    for (ix = [0:count_x-1]) {

        for (iy = [0:count_y-1]) {

            translate([

                ix * (outer_length + spacing_x),

                iy * (outer_width + spacing_y),

                0

            ])

            enclosure(

                length = length,
                width = width,
                height = height,

                wall = wall,
                bottom = bottom,

                show_box = show_box,
                show_lid = show_lid,

                lid_separate = lid_separate

            );

        }

    }

}


// ============================================================
// 11. INDIVIDUAL ENCLOSURE CONFIGURATIONS
// ============================================================

module example_individual_boxes() {


    // BOX 1

    enclosure(

        length = 82,
        width = 21,
        height = 30,

        vent_wall = "back"

    );


    // BOX 2

    translate([110,0,0])

    enclosure(

        length = 100,
        width = 30,
        height = 35,

        vent_wall = "front",
        vent_diameter = 4

    );


    // BOX 3

    translate([240,0,0])

    enclosure(

        length = 60,
        width = 40,
        height = 25,

        wall = 2,

        vent_wall = "left",

        pcb_enabled = false

    );

}


// ============================================================
// 12. MAIN CONFIGURATION
// ============================================================
//
// DISPLAY MODE:
//
// 0 = Single enclosure
// 1 = Multiple identical enclosures
// 2 = Multiple individually configured enclosures
//

display_mode = 0;


// SINGLE BOX DIMENSIONS

single_length = 82;
single_width  = 21;
single_height = 30;


// MULTIPLE BOX SETTINGS

number_x = 3;
number_y = 2;

spacing_x = 20;
spacing_y = 20;


// DISPLAY OPTIONS

display_box = true;
display_lid = true;


// LID POSITION
//
// false = lid assembled on box
// true  = lid displayed separately
//

separate_lid = false;


// ============================================================
// 13. MAIN EXECUTION
// ============================================================


// SINGLE ENCLOSURE

if (display_mode == 0) {

    enclosure(

        length = single_length,
        width = single_width,
        height = single_height,

        show_box = display_box,
        show_lid = display_lid,

        lid_separate = separate_lid

    );

}


// MULTIPLE IDENTICAL ENCLOSURES

else if (display_mode == 1) {

    enclosure_grid(

        count_x = number_x,
        count_y = number_y,

        spacing_x = spacing_x,
        spacing_y = spacing_y,

        length = single_length,
        width = single_width,
        height = single_height,

        show_box = display_box,
        show_lid = display_lid,

        lid_separate = separate_lid

    );

}


// MULTIPLE INDIVIDUAL ENCLOSURES

else if (display_mode == 2) {

    example_individual_boxes();

}