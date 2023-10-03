include <threads.scad>;

// dmin = dmax - (1.082532 * pitch);

$fn = 100;

// box parameters 
d_inner = 27; // mm inner diameter (2eu coin)
d_outer= 27 + 1; // mm outer diameter (1 mm wall thickness)
h = 50; //mm height

// thread parameters 
thread_pitch = 2.5; 
thread_size = 2; // thickness
thread_aspect_ratio = 0.5;
thread_length = 7.5;


chamfer = 2; // chamfer of the ends of the thread

module bottle() {
  d_thread_min = d_outer;
  d_thread_max = d_thread_min + (thread_aspect_ratio * thread_size) ;
  
  difference(){
    union(){
      //the thread
      metric_thread(diameter=d_thread_max, pitch=thread_pitch, length=thread_length, thread_size=thread_size, internal=false, square=true, rectangle=thread_aspect_ratio);
      // the outer shaft
      cylinder(d=d_thread_min, h=h);
    }
    //substract the inner shaft
    cylinder(d=d_inner, h=h);
    
//    //and a chamfer to the thred's end
//    difference(){
//      cylinder(d=d_thread_max+ 5, h=chamfer);
//      linear_extrude(height=chamfer,scale=d_thread_max/d_thread_min) circle(d=d_thread_min);
//    }
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

module cap() {
  pad = 1; // make this thread slightly bigger ! use it  
  d_thread_min = d_outer + pad;
  d_thread_max = d_thread_min + (thread_aspect_ratio * thread_size) ;
  d_cap = d_thread_max + 1; // cap outer diameter 
  
  difference(){
    //the outer hull minus the thread
    difference(){
      cylinder(d=d_cap, h=thread_length);
      metric_thread(diameter=d_thread_max, pitch=thread_pitch, length=thread_length, thread_size=thread_size, internal=true, square=false, rectangle=thread_aspect_ratio);
    }
    //the chamfer at the end of the thread
    
    translate([0,0,thread_length-chamfer])
      linear_extrude(height=chamfer,scale=d_thread_max/d_thread_min) 
        circle(d=d_thread_min);
  }
  
  // the bottom cap 
  champfer_cap = 1;
  translate([0,0,-champfer_cap]){
    hull(){
      cylinder(d=d_cap-champfer_cap, h = 0.1);
      translate([0,0,champfer_cap]) cylinder(d=d_cap, h = 0.1);
    }
  }
}
bottle();
//cap();


// Standard M8 x 1.
//metric_thread (diameter=8, pitch=2, thread_size=1, length=4);

// Square thread.
// metric_thread (diameter=8, pitch=1, length=4, square=true);

// Non-standard: long pitch, same thread size.
//metric_thread (diameter=8, pitch=4, length=4, thread_size=1, groove=true);

// Non-standard: 20 mm diameter, long pitch, square "trough" width 3 mm,
// depth 1 mm.
//metric_thread (diameter=10, pitch=5, length=10, square=true, thread_size=2, rectangle=0.5);