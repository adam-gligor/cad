// 40 x 25
// space 28-29 mm
// holes 5-6 mm
X = 40;
Y = 25;
Z = 4;

$fn=50;
D = 6;

difference() {
    
hull(){
    translate([D/2,D/2,0]) cylinder(d=D, h=Z);
    translate([X-D/2,D/2,0]) cylinder(d=D, h=Z);
    translate([D/2,Y-D/2,0]) cylinder(d=D, h=Z);
    translate([X-D/2,Y-D/2,0]) cylinder(d=D, h=Z);
}

union(){

    hull(){
    translate([D+1,D+1,0]) cylinder(d=D, h=Z);
    translate([X-D-1,D+1,0]) cylinder(d=D, h=Z);
    }


    hull(){
    translate([D+1,Y-D-1,0]) cylinder(d=D, h=Z);
    translate([X-D-1,Y-D-1,0]) cylinder(d=D, h=Z);
    }

    translate([0,Y+2,Z/2]) rotate([0,90,0]) cylinder(d=D-0.5,h=X);

}
}