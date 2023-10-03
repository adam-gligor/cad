$fn=100;
difference(){
    cylinder(d=28.6, h = 40);
    union(){
        translate([0,0,3])
        sphere(d=25);
        cube([50,5,20], center=true);
        rotate([0,0,90])
        cube([50,5,20], center=true);
    }
}


difference(){
sphere(d=25);
translate([0,0,-8])
    cube([30,30,9],center=true);
}

translate([0,0,-5])
    cube([30,30,3],center=true);
