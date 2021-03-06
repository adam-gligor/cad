length = 106;
width = 66;
height = 13;
wall = 1.2;
wall2 = 2.4;
feet_height = 3;
$fn = 50;

difference(){
    minkowski() {
        cylinder(d=wall2,h=height);
        cube([length, width, height]);
    }
    union(){
        translate([0,0,feet_height + wall])
            cube([length, width, height *2]);
        translate([-5,feet_height,0])
            cube([length + 10, width-6, feet_height]);

    }
}

