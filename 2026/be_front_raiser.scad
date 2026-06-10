r1 = (90 +2)/2; 

$fn=50;

// abs shrinkage 1% 

module m1() {
color("red") cylinder(r = r1 , h=1);


difference() {

minkowski() {
translate([0,0,7]) cylinder(r = r1 , h=1);

translate([0,0,0]) sphere(r=7);
}

translate([0,0,11]) cylinder(r = r1 , h=20);
}
} 

module m2() {

    //translate([46,20,0]) sphere(r=6);
    difference(){
        minkowski() {
            cylinder(r = r1 , h=0.1);
            translate([0,0,0]) sphere(r=5);
        }
    translate([0,0,3]) cylinder(r = r1 , h=10);
   // translate([0,0,-10]) cylinder(r = 20 , h=20);    
    }
}


m2();