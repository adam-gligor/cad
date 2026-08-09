
bh = 20; // max board width 

bw = 10;  // max board width

al = 50; // arm length

tk = 10; // thickners

// --
//
//bc = bw+2*tk;
//
//difference(){
//union(){
//bc = bw+2*tk;
//cube([bc,bc,bh]);
//
//cube([bc+al,tk,bh]);
//
//cube([tk,bc+al,bh]);
//}
//
////kk =2*tk;
//// translate([kk+tk,kk+tk,tk]) rotate([0,0,45]) cube([tk,tk,bh], center=true);
//}
//
//bc1 = tk;
//#translate([bc1+bw,bc1+bw,0]) cube([bc,bc,bh],$fn=3);

//tk 


module p1(d, bh, tk) {


    difference() {
        cube([d,d,bh]);
        rotate([0,0,45]) translate([0,0,bh/2]) cube([sqrt(2)*tk,sqrt(2)*tk,bh], center=true);
    }
}


d = bw + 2*tk;

union(){

p1(d,bh,tk);
translate([-d,d-tk,0]) cube([al,tk,bh]);
translate([d-tk,-d,0]) cube([tk,al,bh]);
}


translate([(tk+1.9),(tk+1.9),0]) rotate([0,0,180]) p1(d,bh,tk+4);


// --

//bc = bw+2*tk;
//
//linear_extrude(height=bh)
// polygon(points=[[tk,0],[bc+al,0],[bc+al+3,tk],[bc,tk],[bc,tk+bw],[bc-tk,bc],[tk,bc],[tk,bc+al+3],[0,bc+al], [0,tk] ]);
// 

// -- 

///*
// HALLBAR 2x2 PLATFORM — LONG-SPAR VERSION
//
// Design:
//   Outer frame: 560 x 450 mm, 20x10 mm timber, 20 mm VERTICAL.
//   Internal support grid: TWO CONTINUOUS 10x10 mm spars.
//     - one 560 mm spar
//     - one 430 mm spar
//   No segmented internal cross pieces.
//   Only one centre crossing is used.
//
// The T-joints are END/RAIL connectors: a long spar slides through the
// connector and continues uninterrupted. The connector attaches it to
// the perimeter rail.
//
// Parts:
//   corner x4
//   t_joint x4
//   center_4way x1
//   foot x4
//   optional leg_sleeve x4
//*/
//
//$fn=64;
//
//// ---------- USER PARAMETERS ----------
//outer_x = 560;
//outer_y = 450;
//
//rail_h = 20;       // vertical dimension of 20x10 outer board
//rail_t = 10;       // horizontal thickness
//cross = 10;        // 10x10 spars
//
//leg = 20;          // two 10x10 boards paired
//leg_h = 105;       // 105 + 20 frame = 125 mm overall
//
//fit = 0.35;
//wall = 5.5;
//corner_r = 5;
//gusset_r = 11;
//
//foot_size = 36;
//foot_h = 10;
//foot_wall = 4.5;
//
//screw_d = 4.0;
//
//// ---------- HELPER ----------
//module rb(s=[20,20,20], r=3) {
//    x=s[0]; y=s[1]; z=s[2];
//    r=min(r,min(x,y)/2-0.1);
//    hull() {
//        for(xx=[-1,1],yy=[-1,1])
//            translate([xx*(x/2-r),yy*(y/2-r),0])
//                cylinder(r=r,h=z,center=true);
//    }
//}
//
//// ---------- CORNER ----------
//module corner() {
//    body=rail_t+2*wall+18;
//
//    difference() {
//        union() {
//            translate([0,0,rail_h/2])
//                rb([body,body,rail_h+2*wall],corner_r);
//
//            // large curved cheeks
//            translate([-(body/2-2),0,rail_h/2])
//                rotate([0,90,0])
//                    cylinder(r=gusset_r,h=wall*2,center=true);
//
//            translate([0,-(body/2-2),rail_h/2])
//                rotate([90,0,0])
//                    cylinder(r=gusset_r,h=wall*2,center=true);
//
//            // heavy leg collar
//            translate([0,0,-leg_h/2])
//                rb([leg+2*wall,leg+2*wall,leg_h/3],corner_r);
//        }
//
//        // long rail socket +X
//        translate([body/2-4,0,rail_h/2])
//            cube([body+10,rail_t+2*fit,rail_h+2*fit],center=true);
//
//        // short rail socket +Y
//        translate([0,body/2-4,rail_h/2])
//            cube([rail_t+2*fit,body+10,rail_h+2*fit],center=true);
//
//        // leg socket
//        translate([0,0,-leg_h/2])
//            cube([leg+2*fit,leg+2*fit,leg_h+2],center=true);
//
//        // optional retaining holes
//        translate([body/2-7,0,rail_h/2])
//            rotate([90,0,0])
//                cylinder(d=screw_d,h=rail_t+2*wall+4,center=true);
//
//        translate([0,body/2-7,rail_h/2])
//            rotate([0,90,0])
//                cylinder(d=screw_d,h=rail_t+2*wall+4,center=true);
//    }
//}
//
//// ---------- LONG-SPAR T-JOINT ----------
////
//// The spar passes through the connector.
//// It does NOT need to be cut at the joint.
////
//// The connector sits at the perimeter and captures the 20x10 rail.
//// The 10x10 spar passes through the central tunnel.
////
//// PART IS SYMMETRIC ENOUGH TO ROTATE 180° WHEN ASSEMBLING.
//module t_joint() {
//    L=44;
//    B=32;
//    H=30;
//
//    difference() {
//        union() {
//            // thick body
//            translate([0,0,H/2])
//                rb([L,B,H],5);
//
//            // long curved shoulder along the spar
//            translate([0,0,9])
//                rotate([90,0,0])
//                    cylinder(r=gusset_r,h=B,center=true);
//
//            // second curved shoulder on underside
//            translate([0,0,5])
//                rotate([90,0,0])
//                    cylinder(r=7,h=B+4,center=true);
//        }
//
//        // CONTINUOUS 10x10 spar tunnel, full length
//        translate([0,0,rail_h-cross/2])
//            cube([L+4,cross+2*fit,cross+2*fit],center=true);
//
//        // 20x10 perimeter rail socket, perpendicular
//        translate([0,0,rail_h/2])
//            cube([rail_t+2*fit,B+4,rail_h+2*fit],center=true);
//
//        // retaining screw for the continuous spar
//        translate([0,0,rail_h-cross/2])
//            rotate([90,0,0])
//                cylinder(d=screw_d,h=B+4,center=true);
//
//        // retaining screw for perimeter rail
//        translate([0,0,rail_h/2])
//            rotate([0,90,0])
//                cylinder(d=screw_d,h=L+4,center=true);
//    }
//}
//
//// ---------- CENTER 4-WAY ----------
////
//// The two spars remain single pieces and cross through this hub.
//// No cutting or joining of short pieces.
//module center_4way() {
//    S=42;
//    H=20;
//
//    difference() {
//        union() {
//            rb([S,S,H+2*wall],6);
//
//            // four curved arms
//            for(a=[0,90,180,270])
//                rotate([0,0,a])
//                    translate([S/2-4,0,H/2])
//                        rotate([90,0,0])
//                            cylinder(r=gusset_r,h=wall+1,center=true);
//        }
//
//        // first continuous spar
//        translate([0,0,H-cross/2])
//            cube([S+6,cross+2*fit,cross+2*fit],center=true);
//
//        // second continuous spar
//        translate([0,0,H-cross/2])
//            cube([cross+2*fit,S+6,cross+2*fit],center=true);
//
//        // optional central pin/screw
//        cylinder(d=screw_d,h=H+2*wall+4,center=true);
//    }
//}
//
//// ---------- FOOT ----------
//module foot() {
//    difference() {
//        union() {
//            rb([foot_size,foot_size,foot_h],6);
//
//            translate([0,0,foot_h/2+3])
//                rb([leg+2*foot_wall,leg+2*foot_wall,foot_h+6],4);
//
//            for(a=[0,90,180,270])
//                rotate([0,0,a])
//                    translate([foot_size/2-7,0,foot_h/2])
//                        rotate([90,0,0])
//                            cylinder(r=6,h=foot_wall,center=true);
//        }
//
//        translate([0,0,foot_h+2])
//            cube([leg+2*fit,leg+2*fit,foot_h+10],center=true);
//
//        cylinder(d=8,h=foot_h+4,center=true);
//    }
//}
//
//// ---------- OPTIONAL LEG SLEEVE ----------
//module leg_sleeve() {
//    outer=30;
//    h=25;
//
//    difference() {
//        rb([outer,outer,h],5);
//        cube([leg+2*fit,leg+2*fit,h+2],center=true);
//
//        // split for easy insertion
//        translate([outer/2-2,0,0])
//            cube([8,4,h+4],center=true);
//    }
//}
//
//// ---------- EXPORT ----------
//PART="t_joint";
//
//if(PART=="corner") corner();
//if(PART=="t_joint") t_joint();
//if(PART=="center_4way") center_4way();
//if(PART=="foot") foot();
//if(PART=="leg_sleeve") leg_sleeve();
