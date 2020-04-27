include <threads.scad>;

// https://en.wikipedia.org/wiki/ISO_metric_screw_thread


$fn=100;
d_outer = 28; //0.5 mm per side
d_inner = 27;
height=50;
pitch = 1.5;
d_thread = d_outer +  (1.082532 * pitch);

module body() {
    difference(){
        union(){
           metric_thread (diameter=d_thread, pitch=pitch, length=5, internal=false, leadin=2);
           cylinder(d=d_outer, h=height);
        }
        // inner hole
        cylinder(d=d_inner, h=height);
    }
    // end chamfer
    translate([0,0,height])
        linear_extrude(height=1, scale=d_inner/d_outer) circle(d=d_outer);
}

module cap() {
d_thread_cap = d_thread + 1;
d_outer_cap = d_thread_cap + 1;
    difference(){
        // cap body + end chamfer
        union() {
            cylinder(d=d_outer_cap,h=5);
            translate([0,0,-1])
            linear_extrude(height=1, scale=d_outer_cap/d_thread_cap) circle(d=d_thread_cap);
        }
        // inner chamfer + thread
        union(){
            metric_thread (diameter=d_thread_cap, pitch=pitch, length=5, internal=true);
            translate([0,0,4]) 
            color("red")
                linear_extrude(height=1, scale=1.1)
                    circle(d=d_outer);
        }
    }
}

body();
//cap();

