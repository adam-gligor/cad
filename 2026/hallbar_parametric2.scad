
module s(){
 
    
 union(){
 translate([0,0,0]) cylinder(d1=8,d2=4,h=3, $fn=25);
     cylinder(d=4,h=10, $fn=25);
 }
}






//difference(){
//    
//union(){
//cube([50,10,5]);
//cube([10,50,5]);
//}
//
//translate([20,5,0]) s();
//translate([40,5,0]) s();
//
//translate([5,20,0]) s();
//translate([5,40,0]) s();
//}
//
//
//translate([10,10,-10])
//difference(){
// cube([40,40,15]);
//
//translate([10,10,0]) cube([20,20,10]);
//}

module c(){
difference(){
linear_extrude(height=3) polygon(points=[[0,0],[30,0], [0,30]]);

translate([5,15,0]) s();
translate([15,5,0]) s();
}
}


translate([0,0,0]) c();

translate([32,0,0]) c();

translate([64,0,0]) c();

translate([96,0,0]) c();

translate([31,31,0]) rotate([0,0,-180]) c();

translate([63,31,0]) rotate([0,0,-180]) c();

translate([95,31,0]) rotate([0,0,-180]) c();

translate([126,31,0]) rotate([0,0,-180]) c();



//translate([0,32,0]) {
//translate([0,0,0]) c();
//
//translate([32,0,0]) c();
//
//translate([64,0,0]) c();
//
//translate([96,0,0]) c();
//
//translate([31,31,0]) rotate([0,0,-180]) c();
//
//translate([63,31,0]) rotate([0,0,-180]) c();
//
//translate([95,31,0]) rotate([0,0,-180]) c();
//
//translate([126,31,0]) rotate([0,0,-180]) c();
//    
//}
