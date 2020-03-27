include <threads.scad>;

// dmin = dmax - (1.082532 * pitch);

$fn = 50;

d_inner = 27; // mm inner diameter
d_outer= 27 + 1; // mm outer diameter
h = 50; //mm height

chamfer = 3; // chamfer of the thread top

//now put a thread on the outer wall
thread_pitch = 2.5;
thread_length = 7.5;
d_thread_min = d_outer;
d_thread_max = d_thread_min + (1.082532 * thread_pitch) ;

module bottle() {
  difference(){
    union(){
      //the thread
      metric_thread(diameter=d_thread_max, pitch=thread_pitch, length=thread_length, internal=false);
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


d_cap = d_thread_max + 1;

difference(){
  cylinder(d=d_cap, h=thread_length);
  metric_thread(diameter=d_thread_max, pitch=thread_pitch, length=thread_length, internal=false);
}
//bottle();