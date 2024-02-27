D = 2.6 ;

$fn=100;

module foo(r,txt) {
    difference(){
        cylinder(r=r,h=1);
        union(){
            cylinder(d=D,h=1);
           translate([-2,r-4,0.6]) linear_extrude(0.4) text(txt, size=3);
        }
    }
 

    
}

foo(6, "06");
translate([20,0,0]) foo(10, "10");
translate([60,0,0]) foo(20, "20");