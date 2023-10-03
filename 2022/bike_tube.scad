$fn=50;

difference(){
    cylinder(d=6, h=20);
    union(){
    cylinder(d=1.5, h=20);
    translate([0,0,2])
        cylinder(d=5, h=20);
    }
}
