include <threads.scad>;

$fn = 50;
d = 27; // mm inner diameter
h = 50; //mm height

r=d/2;

step=0.1; //mm min step
chamfer=2; //mm
wall = 3; //mm

//bottom
module body(){
    //bottom chamfer
    translate([0,0,-h/2 - chamfer]){
        hull(){
            cylinder(r=r, h=step, center=true);
            translate([0,0,chamfer]){
                cylinder(r=r+wall, h=step, center=true);
            }
        }
    }
    difference(){    
        cylinder(r=r+wall,h=h, center=true);
        translate([0,0, chamfer + step]){
            cylinder(r=r,h=h, center=true);
        }
        translate([0,0,h/2-5+step]){
            metric_thread(diameter=d+2.7, pitch=2.5, length=5, internal=true);
        }
    }
    
}

module cap(){
    translate([0,0,h/2-5+step]){
        metric_thread(diameter=d+2.7-1.6, pitch=2.5, length=5, internal=false);
        translate([0,0,6]){
            cylinder(r=r+wall,h=5, center=false);
        }
        //bottom chamfer
        translate([0,0,5]){
            hull(){
                cylinder(r=r+wall-1, h=step, center=true);
                translate([0,0,1]){
                    cylinder(r=r+wall-1, h=step, center=true);
                }
            }
        }
        //top chamfer
        translate([0,0,11]){
            hull(){
                cylinder(r=r+wall, h=step, center=true);
                translate([0,0,chamfer]){
                    cylinder(r=r, h=step, center=true);
                }
            }
        }
    }  
} 

module cap_v2(){
    translate([0,0,h/2-5+step]){
        metric_thread(diameter=d+2.7-1.6, pitch=2.5, length=5, internal=false);
        //middle
        translate([0,0,6]){
            cylinder(r=r+wall+1,h=5, center=false);
        }
        //bottom chamfer
        translate([0,0,5]){
            hull(){
                cylinder(r=r+wall+1, h=step, center=true);
                translate([0,0,1]){
                    cylinder(r=r+wall+1, h=step, center=true);
                }
            }
        }
        //top chamfer
        translate([0,0,11]){
            hull(){
                cylinder(r=r+wall+1, h=step, center=true);
                translate([0,0,chamfer]){
                    cylinder(r=r+1, h=step, center=true);
                }
            }
        }
    }  
} 

//body();
cap_v2();