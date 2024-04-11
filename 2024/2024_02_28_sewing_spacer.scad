D = 2.6 ;
T = 2;

$fn=100;

module foo(r,txt) {
    difference(){
        cylinder(r=r,h=1);
        union(){
            cylinder(d=D,h=1);
           translate([-2,r-4,0.6]) linear_extrude(1) text(txt, size=3);
        }
    }
 

    
}

module bar(r, txt) {
    // large
    difference() {
        cylinder(r=r,h=4);
        cylinder(r=r-T,h=4);
    }
  
    //smalle
    difference() {
        cylinder(d=D+ 2*T,h=2);
        cylinder(d=D,h=2);
    }
    
    translate([-1,D/2,0]) cube([T,r-D/2-1,2]);
    
    rotate([0,0,90]) translate([-T/2,D/2,0]) cube([T,r-D/2-1,2]);
   
    rotate([0,0,-90]) translate([-T/2,D/2,0]) cube([T,r-D/2-1,2]);
   
    rotate([0,0,180]) translate([-T/2,D/2,0]) cube([T,r-D/2-1,2]);
    
}

bar(6, "06");
translate([23,0,0]) bar(15, "15");
translate([60,0,0]) bar(20, "20");
//translate([60,0,0]) foo(20, "20");