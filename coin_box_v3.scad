include <threads.scad>;

$fn = 50;

// box parameters 
d_inner = 27; // mm inner diameter (2eu coin)
d_outer= 27 + 1; // mm outer diameter (1 mm wall thickness)
h = 50; //mm height

// thread parameters 
thread_pitch = 2.5; 
thread_size = 2; // means 1 mm thread height per side 
thread_aspect_ratio = 0.5; // determines the depth of the profle based on previous 
thread_length = 7.5;
chamfer = 2; // chamfer of the ends of the thread


module cap() {
  pad = 0.6; // make this thread slightly bigger ! use it  
  d_thread_min = d_outer + pad;
  d_thread_max = d_outer + (thread_aspect_ratio * thread_size);
  d_cap = d_thread_max + 1.2; // cap outer diameter 
  
  difference(){
    //the outer hull minus the thread
    difference(){
      cylinder(d=d_cap, h=thread_length);
      metric_thread(
        diameter=d_thread_max,
        pitch=thread_pitch, 
        length=thread_length,
        thread_size=thread_size,
        internal=true, 
        square=true,
        rectangle=thread_aspect_ratio
        );
    }
    //the chamfer at the end of the thread
    
//    translate([0,0,thread_length-chamfer])
//      linear_extrude(height=chamfer,scale=d_thread_max/d_thread_min) 
//        circle(d=d_thread_min);
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

  
module bottle() {
  d_thread_min = d_outer;
  d_thread_max = d_outer+ (thread_aspect_ratio * thread_size);
  
  difference(){
    union(){
      //the thread
      metric_thread(
        diameter=d_thread_max, 
        pitch=thread_pitch, 
        length=thread_length, 
        thread_size=thread_size, 
        internal=false, 
        square=true, 
        rectangle=thread_aspect_ratio,
        leadin=2
     );
      // the outer shaft
      cylinder(d=d_thread_min, h=h);
    }
    //substract the inner shaft
    cylinder(d=d_inner, h=h);
    
    //and a chamfer to the thred's end
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


//cap();
bottle();


//      metric_thread(
//        diameter=8+2,
//        pitch=2, 
//        length=10,
//        thread_size=2,
//        internal=true, 
//        square=true,
//        rectangle=1,
//        leadin = 0
//        );
