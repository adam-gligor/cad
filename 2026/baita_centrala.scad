```scad
// ==================================================
// PARAMETRIC ELECTRONICS ENCLOSURE
// SIDE OPENING WITH SNAP-FIT LID
// ==================================================

// INTERNAL DIMENSIONS
xi = 85;
yi = 25;
zi = 30;

// WALL PARAMETERS
wall = 2;
lid_th = 2;
corner_r = 3;

// GRILLE PARAMETERS
grille_opening = 16;
grille_rib = 3;
grille_margin = 5;

// SNAP FIT PARAMETERS
clip_width = 7;
clip_th = 0.8;
clip_length = 7;
clip_hook = 0.6;
clip_clearance = 0.25;

// LID PARAMETERS
lid_skirt_h = 5;

// WALL MOUNTING
mount_d = 5;
mount_head_d = 9;
mount_offset = 8;

// SELECT PART
// "body", "lid", "both"

part = "both";

$fn = 48;

// DERIVED DIMENSIONS
xo = xi + 2*wall;
yo = yi + 2*wall;
zo = zi + 2*wall;


// ==================================================
// ROUNDED BOX
// ==================================================

module rounded_box(x,y,z,r) {
    hull() {
        for(a=[r,x-r])
            for(b=[r,y-r])
                translate([a,b,0])
                    cylinder(h=z,r=r);
    }
}


// ==================================================
// GRILLE CUTOUTS
// ==================================================

module grille_cuts() {

    // FRONT LARGE WALL
    for(x=[
        grille_margin:
        grille_opening+grille_rib:
        xo-grille_margin-grille_opening
    ])

    for(z=[
        grille_margin:
        grille_opening+grille_rib:
        zo-grille_margin-grille_opening
    ])

        translate([x,-0.1,z])
            cube([
                grille_opening,
                wall+0.2,
                grille_opening
            ]);


    // LEFT AND RIGHT WALLS
    for(y=[
        grille_margin:
        grille_opening+grille_rib:
        yo-grille_margin-grille_opening
    ])

    for(z=[
        grille_margin:
        grille_opening+grille_rib:
        zo-grille_margin-grille_opening
    ]) {
