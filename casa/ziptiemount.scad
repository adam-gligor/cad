//
//difference(){
//    cube([30,30,6], center=true);
//
//    translate([0,0,3]) {
//    //cube([10,30,3], center=true);
//    //cube([30,10,3], center=true);
//        rotate([0,0,45]) cube([30,30,6], center=true);
//    }
//}
//
//difference(){
//cylinder(d=10,h=6);;
//cylinder(d=5,h=6);;
//}


difference(){

hull(){
cylinder(d = 30,h=10);
translate([0,30,0]) cylinder(d = 30,h=10);
}



hull(){
cylinder(d = 20,h=10);
translate([0,30,0]) cylinder(d = 20,h=10);
}
}