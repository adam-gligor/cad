include <threads.scad>;

// dmin = dmax - (1.082532 * pitch);
// 
$fn = 50;

d_inner = 27; // mm inner diameter
d_outer= 27 + 1; // mm outer diameter
h = 50; //mm height
pitch = 2.5;
chamfer = 3;

//now put a thread on the outer wall
d_thread_min = d_outer;
d_thread_max = d_thread_min + (1.082532 * pitch) ;

module bottle() {
  difference(){
    union(){
      //the thread
      metric_thread(diameter=d_thread_max, pitch=pitch, length=7.5, internal=false);
      // the outer shaft
      cylinder(d=d_thread_min, h=h);
      
    }
    //substract the inner shaft
    cylinder(d=d_inner, h=h);
    
    //and a top chamfer
    difference(){
      cylinder(d=d_thread_max+ 5, h=chamfer);
      linear_extrude(height=chamfer,scale=d_thread_max/d_thread_min) circle(d=d_thread_min);
    }

  }

  //bottom cap
  champfer_cap = 1;

  translate([0,0,h]){
    hull(){
      cylinder(d=d_outer, h = 0.1);
      translate([0,0,champfer_cap]) cylinder(d=d_outer-champfer_cap, h = 0.1);
    }
  }
}

bottle();