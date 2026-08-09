
module s(){
 
    
 union(){
 translate([0,0,0]) cylinder(d1=8,d2=4,h=3, $fn=25);
     cylinder(d=4,h=10, $fn=25);
 }
}




//difference(){
//    union(){
//    cube ([30,5,20]);
//
//    cube ([5,30,20]);
//
//
//    translate([0,25,0]) cube ([30,5,20]);
//
//    translate([25,0,0]) cube ([5,30,20]);
//
//
//    translate([0,0,0]) cube([30,30,5]);
//    }
//
//    translate([5,15,10])  rotate([0,-90,0])  s();
//
//    translate([15,5,10])  rotate([90,90,0]) s();
//
//
//    translate([30,15,10]) rotate([0,-90,0]) cylinder(d=8,h=10);
//
//    translate([15,30,10])  rotate([90,90,0]) cylinder(d=8,h=10);
//
//    
//}


difference(){
    
union(){
cube([50,10,5]);
cube([10,50,5]);
}

translate([20,5,0]) s();
translate([40,5,0]) s();

translate([5,20,0]) s();
translate([5,40,0]) s();
}


translate([10,10,-10])
difference(){
 cube([40,40,15]);

translate([10,10,0]) cube([20,20,10]);
}

//translate([10,10,0])cube([40,5,20]);
//translate([10,10,0])cube([5,40,20]);