include <threads.scad>;

// dmin = dmax - (1.082532 * pitch);

$fn = 100;

// box parameters 
d_inner = 27; // mm inner diameter (2eu coin)
d_outer= 27 + 1; // mm outer diameter (1 mm wall thickness)
h = 50; //mm height

// thread parameters 
thread_pitch = 2.5;
thread_length = 7.5;


chamfer = 2; // chamfer of the ends of the thread

module bottle() {
  d_thread_min = d_outer;
  d_thread_max = d_thread_min + (1.082532 * thread_pitch) ;
  
  difference(){
    union(){
      //the thread
      metric_thread(diameter=d_thread_max, pitch=thread_pitch, length=thread_length, internal=false);
      // the outer shaft
      cylinder(d=d_thread_min, h=h);
    }
    //substract the inner shaft
    cylinder(d=d_inner, h=h);
    
    //and a chamfer to the thred's end
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

module cap() {
  pad = 1; // make this thread slightly bigger ! use it  
  d_thread_min = d_outer + pad;
  d_thread_max = d_thread_min + (1.082532 * thread_pitch) ;
  d_cap = d_thread_max + 1.5; // cap outer diameter
  
  difference(){
    //the outer hull minus the thread
    difference(){
      cylinder(d=d_cap, h=thread_length);
      metric_thread(diameter=d_thread_max, pitch=thread_pitch, length=thread_length, internal=false);
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

//bottle();
cap();