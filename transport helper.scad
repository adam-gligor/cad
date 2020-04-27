include <../scad-utils/morphology.scad>;

$fn=100;
//difference(){
//    cylinder(d=28.6, h = 40);
//    union(){
//        translate([0,0,3])
//        sphere(d=25);
//        cube([50,5,20], center=true);
//        rotate([0,0,90])
//        cube([50,5,20], center=true);
//    }
//}


translate([0,0,3])
difference(){
sphere(d=34);
translate([0,0,-17])
    cube([34,34,34],center=true);
}

translate([0,0,0])
    linear_extrude(height=3)
        rounding(r=5)
            square([50,50], center=true);