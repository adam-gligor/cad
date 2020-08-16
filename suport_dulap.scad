include <threads.scad>;

$fn=100;

diam = 25;
diam2 = 50;
h = 250;

    
difference() {
    union(){

        cylinder(h=h,d=diam);

        cylinder(h=5,d=diam2);
        translate([0,0,5])
            linear_extrude(height=10, scale=0.5)
                circle(d=diam+10);

    }
    
    cylinder(h=h,d=15);
}