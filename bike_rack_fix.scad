// d rurub = 5 mm
// d teava = 10mm
// x1 = 70mm
// x2 = 40mm + 10


difference() {

    union(){
        cube([86,15,1.2], center=true);
        translate([-22.4,1,0])
            cylinder(d=5,h=2, $fn=50);
        translate([-25,1, 0])
            cylinder(d=5,h=2, $fn=50);
        translate([22.4,1,0])
            cylinder(d=5,h=2, $fn=50);
        translate([25,1, 0])
            cylinder(d=5,h=2, $fn=50);
    }

    translate([-35,1,-1])
        cylinder(d=6,h=5, $fn=50);

    translate([35,1,-1])
        cylinder(d=6,h=5, $fn=50);
}

//color("red")
//translate([0,0,1])
//cube([39.5,15,1], center=true);