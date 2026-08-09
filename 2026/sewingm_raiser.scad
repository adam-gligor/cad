
$fn=100;

module folder(){
    
    difference(){
        
    union(){
    z = 1.2;
    
    rotate([-3,0,0]) cube([10+1,30,z]);
    
    translate([3*z,0,z*2]) rotate([0,0,0]) cube([10 - 3* z,30,z]);
    
    translate([0,0,z*4]) rotate([3,0,0]) cube([10,30,z]);



    hull(){
        rotate([-3,0,0]) cube([1,30,z]);
        translate([0,0,z*4]) rotate([3,0,0]) cube([1,30,z]);
    }

    translate([10,0,0])
    hull(){
    translate([0,0,z*2]) rotate([0,0,0]) cube([1,30,z]);
    translate([0,0,z*4]) rotate([3,0,0]) cube([1,30,z]);
    }
    }
    
    translate([0,29,-5]) cube([20,20,20]);
}


}

folder();

//module spool_holder() {
//
//  d = 6.2;
//   h = 75;
//   l = 120;
////   part 1
//    difference(){
//    union(){
//        translate([0,0,0]) cube([l-5,10,5], center=true); 
//   
//        
//        translate([-l/2+d,0,0]) cylinder(d1=d+1,d2=d-2,h=h);
//        translate([l/2-d,0,0]) cylinder(d1=d+1,d2=d-2,h=h);
//        
//        
//        translate([0,0,0]) cylinder(d=3*d,h=5, center=true);
//        
//        translate([-l/2+d,0,0]) cylinder(d=3*d,h=5, center=true);
//   
//        translate([l/2-d,0,0]) cylinder(d=3*d,h=5, center=true);
//    }
//   translate([0,0,0]) cylinder(d=d,h=5, center=true);
//
//}

// part 2

//translate([0,0,0]) rotate([0,90,0]){
//    union(){
//   translate([0,0,2.5+2]) cylinder(d1=d+1.4,d2=d-1,h=h);
//   translate([0,0,-2.5])  cylinder(d1=d-1.4,d2=d+1.4, h=7);
//    }
//}


//rotate([0,-90,0])
//difference(){
//  ll = 200;
//  ww = 8;
//  cylinder(d=ww,h=ll, $fn=3);
//      
//      
//    for ( i = [1:20:ll-20]) {
//      translate([ww/2+1,ww/2,i+20]) rotate([90,0,0])
//      cylinder(d=ww,h=ww, $fn=50);
//    }
//}
//}
//
//
//spool_holder();