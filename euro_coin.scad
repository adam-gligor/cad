D = 23.25;
H = 2.4; //2.33;

difference(){
    cylinder(d=D,h=H,$fn=100);
    union(){
        cylinder(d=7,h=1,$fn=100);
        translate([0,0,H-1])
        cylinder(d=7,h=1,$fn=100);
    }
}

//difference(){
//    hull(){
//        
//        cylinder(d=D-1,h=0.001,$fn=50);
//        
//        translate([0,0,0.4])
//            cylinder(d=D,h=0.001,$fn=50);
//            
//        translate([0,0,H-0.4])
//            cylinder(d=D,h=0.001,$fn=50);
//        
//        translate([0,0,H])
//            cylinder(d=D-1,h=0.001,$fn=50);
//    }
//    
//    union(){
////        hull(){
////            cylinder(d=7,h=0.001,$fn=50);
////            translate([0,0,0.4])
////            cylinder(d=7-1,h=0.001,$fn=50);            
////        }
//        hull(){
//            translate([0,0,H-0.4])
//                cylinder(d=7-1,h=0.001,$fn=50);
//            translate([0,0,H])
//                cylinder(d=7,h=0.001,$fn=50);
//
//        }
//    }
//}