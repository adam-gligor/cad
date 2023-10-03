$fn=100;

////column
//C_H = 100;
//C_D = 5;
//
////base
//B_W = 12;
//B_H = 2;

D1 = 8;
D2 = 10;

L = 7;

// 1st part

module foo(){
        translate([D2 * 0.75,0,0]) rotate([0,0,0]) scale([1,0.5,1])  

        cylinder(d=D2, h=L, $fn=3);
}
//
////translate([0,D2/2,D2/2]) rotate([0,90,0])
//difference(){
//    union(){
//        cylinder(d=D2, h=L);
//        translate([0, -D2/2,0]) cube([D2 * 0.75, D2, L]);
//    }
//    union(){
//        cylinder(d=D1, h=L);
//        foo();
//
//    }
//}

// 2nd pART
color("red")
{
difference(){
    union(){
    translate([D2 * 0.75, -D2/2 ,0]) cube([2, D2, L]);
    translate([0.3,0,0]) scale([0.95, 0.95,1]) foo();

    }
    translate([D2 - 0.5 , -D2/2 ,0]) cube([3, D2, L]);
}
}
