// m5 nut cap
// uses https://github.com/openscad/scad-utils

include <Polygon.scad>;
include <../scad-utils/morphology.scad>;

// https://www.slideshare.net/tejasudas/dimensions-of-metric-hex-nuts
// m5 - 8.8 mm outside circle 


module side_shape(){
    circle(r=6.5);
    for (i=[0:18])
        rotate([0,0,20*i])
            square(size=[15,1], center=true);
}


difference(){
    //side
    union(){
        translate([0,0,1])
        linear_extrude(height=7)
            side_shape();
        
        cylinder(r=5.5, height=1, $fn=50);
//        translate([0,0,5])
//            linear_extrude(height=2,scale=1)
//                side_shape();

    }
    // cutout
    union(){
        linear_extrude(height=1)
            circle(d=5.5, $fn=50);
        
        translate([0,0,1])
            linear_extrude(height=7)
                Hexagon(R=4.7); // <= OK, 7% contraction
        
//         translate([0,0,5])
//             linear_extrude(height=2)
//                circle(r=5, $fn=50);
    }
}