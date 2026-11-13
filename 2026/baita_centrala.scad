// ============================================
// SIMPLE SCREW-MOUNTED ELECTRONICS ENCLOSURE
// Front removable lid
// Two diagonal M3 screws
// Integrated screw posts
// Configurable ventilation
// ============================================

$fn = 64;

// ============================================
// INTERNAL DIMENSIONS
// ============================================

inner_x = 85;
inner_y = 25;
inner_z = 45;

// ============================================
// WALLS
// ============================================

wall = 2;

// ============================================
// LID
// ============================================

lid_th = 2;

screw_d = 3.2;
screw_head_d = 6.2;
screw_head_depth = 1.6;

// ============================================
// SCREW POSTS
// ============================================

boss_d = 9;

insert_hole_d = 4.6;
insert_depth = 5.5;

// Distance of screw posts from enclosure corners
boss_offset = 6.5;

// ============================================
// VENTILATION GRID
// ============================================

vent_enabled = true;

vent_size = 15;       // Square opening size
vent_rib = 5;        // Material between openings
vent_margin = 5;     // Border around ventilation

// ============================================
// CALCULATED DIMENSIONS
// ============================================

outer_x = inner_x + 2*wall;
outer_y = inner_y + wall;
outer_z = inner_z + 2*wall;

// Screw positions
screw1 = [
    boss_offset,
    boss_offset
];

screw2 = [
    outer_x-boss_offset,
    outer_z-boss_offset
];


// ============================================
// MAIN ENCLOSURE
// ============================================

module enclosure() {

    difference() {

        union() {

            // Outer shell with front opening
            difference() {

                cube([
                    outer_x,
                    outer_y,
                    outer_z
                ]);

                // Internal cavity
                translate([
                    wall,
                    -0.1,
                    wall
                ])
                    cube([
                        inner_x,
                        inner_y+0.1,
                        inner_z
                    ]);
            }

            // Integrated screw posts
            screw_posts();
        }

        // Insert holes
        insert_holes();

        // Ventilation
        if (vent_enabled)
            ventilation();
    }
}


// ============================================
// SCREW POSTS WITH CORNER REINFORCEMENT
// ============================================

corner_reinforcement = 2;

module screw_posts() {

    for (p = [screw1, screw2]) {

        dx = p[0] < outer_x/2 ? 1 : -1;
        dz = p[1] < outer_z/2 ? 1 : -1;

        union() {

            // Main cylindrical screw post
            translate([p[0], 0, p[1]])
                rotate([-90,0,0])
                    cylinder(
                        h=inner_y,
                        d=boss_d
                    );

        // Thin cube towards X wall
        translate([
            dx > 0 ? wall : p[0],
            0,
            p[1] - boss_d/2
        ])
            cube([
                boss_d/2,
                inner_y,
                boss_d
            ]);

        // Thin cube towards Z wall
        translate([
            p[0] - boss_d/2,
            0,
            dz > 0 ? wall : p[1]
        ])
            cube([
                boss_d,
                inner_y,
                boss_d/2
            ]);
        }
    }
}

// ============================================
// HEAT-SET INSERT HOLES
// ============================================

module insert_holes() {

    for (p = [screw1, screw2]) {

        translate([
            p[0],
            -0.1,
            p[1]
        ])
            rotate([-90,0,0])
                cylinder(
                    h=insert_depth+0.1,
                    d=insert_hole_d
                );
    }
}



// ============================================
// SQUARE VENTILATION GRID
// Left, right, top and bottom walls
// No ventilation on front or rear
// ============================================

module ventilation() {

    pitch = vent_size + vent_rib;

    // Grid dimensions
    nx = floor((inner_x - 2*vent_margin + vent_rib)/pitch);
    ny = floor((inner_y - 2*vent_margin + vent_rib)/pitch);
    nz = floor((inner_z - 2*vent_margin + vent_rib)/pitch);

    // Centered grid positions
    sx = wall + (inner_x - (nx*vent_size+(nx-1)*vent_rib))/2;
    sy = wall + (inner_y - (ny*vent_size+(ny-1)*vent_rib))/2;
    sz = wall + (inner_z - (nz*vent_size+(nz-1)*vent_rib))/2;

    // ----------------------------------------
    // LEFT AND RIGHT WALLS
    // ----------------------------------------

    for (side = [0,1])
        for (y = [0:ny-1])
            for (z = [0:nz-1])

                translate([
                    side == 0 ? -0.1 : outer_x-wall-0.1,
                    sy+y*pitch,
                    wall+sz-wall+z*pitch
                ])
                    cube([
                        wall+0.2,
                        vent_size,
                        vent_size
                    ]);

    // ----------------------------------------
    // TOP AND BOTTOM WALLS
    // ----------------------------------------

    for (side = [0,1])
        for (x = [0:nx-1])
            for (y = [0:ny-1])

                translate([
                    sx+x*pitch,
                    sy+y*pitch,
                    side == 0 ? -0.1 : outer_z-wall-0.1
                ])
                    cube([
                        vent_size,
                        vent_size,
                        wall+0.2
                    ]);
}


// ============================================
// REMOVABLE FRONT LID
// ============================================

module lid() {

    difference() {

        // Lid plate
        translate([
            0,
            -lid_th,
            0
        ])
            cube([
                outer_x,
                lid_th,
                outer_z
            ]);

        // Screw holes and countersinks
        for (p = [screw1,screw2]) {

            // Through hole
            translate([
                p[0],
                -lid_th-0.1,
                p[1]
            ])
                rotate([-90,0,0])
                    cylinder(
                        h=lid_th+0.2,
                        d=screw_d
                    );

            // Countersink
            translate([
                p[0],
                -lid_th-0.01,
                p[1]
            ])
                rotate([-90,0,0])
                    cylinder(
                        h=screw_head_depth,
                        d1=screw_head_d,
                        d2=screw_d
                    );
        }
    }
}


// ============================================
// OUTPUT
// ============================================

// Options:
// "body"
// "lid"
// "both"

show = "both";

if (show == "body") {

    enclosure();

}
else if (show == "lid") {

    lid();

}
else {

    enclosure();

//    // Separate lid preview
//    translate([
//        0,
//        -lid_th-5,
//        0
//    ])
//        lid();
}