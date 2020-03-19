include <threads.scad>;
$fn = 50;
//v1
//d=10;
//h=10;
//pitch=1

//v2
d=20;
h=10;
pitch=2.5;

module outside(){
    difference(){
        cylinder(r=d/2+1.5, h=h, center=true);
        
        translate([0,0,-h/2-0.01]){
            //fix here !
            //0 not good 
            //1 too thight
            //1.5 almost perfect (maybe try 1.6)
            //2 too loose
            metric_thread(diameter=d+1.5, pitch=pitch, length=h+0.02, internal=true);
        }
    }
}

module inside(){
    difference(){
        union(){
            translate([0,0,h/2+1]){
                cylinder(r=d/2+1, h=2, center=true);
            }
            
            translate([0,0,-h/2-0.01]){
                metric_thread(diameter=d, pitch=pitch, length=h+0.02, internal=false);
            }
        }
        cylinder(r=d/2-2, h=h + 10, center=true);
    }
}

//inside();
outside();