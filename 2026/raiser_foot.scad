// 17 deg 
// 5.5 cm tall
// 2x2 cm base


module v1(){
difference() {


cube([30,30,55+3]);


translate([4,4,55]) cube([22,22,10]);
}

hull(){
cylinder (r=5, h=5);
translate([30,0,0]) cylinder (r=5, h=5);
translate([0,30,0]) cylinder (r=5, h=5);
translate([30,30,0]) cylinder (r=5, h=5);
}
}



module v2() {
difference() {
cube([30,30,55+3]);
translate([4,4,0]) cube([22,22,55+3]);
}

translate([4,4,40-3])
difference(){

 cube([22,22,18]);
translate([11,11,0]) sphere (r=15);

}
}


module v3() {
    
    difference() {
    cylinder (d = 30, h=55+3);
        translate([0,0,55+11-3-3]) cube([23,23,10], center = true);
    }
}



v3();


