include <threads.scad>;

$fn = 50;

// https://en.wikipedia.org/wiki/ISO_metric_screw_thread


module screw(d, h, d_thread){
  // d = the outer diameter (of the top)
  // h = the screw's total height
  // d_thread = thread diam
   
  d_max_thread = d_thread;
  pitch = 2.5;
  d_min_thread = d_max_thread- (1.082532 * pitch);
  chamfer = 3;
  
  difference(){
    union(){
      translate([0,0,0])
        metric_thread(diameter=d_max_thread, pitch=pitch, length=h, internal=false, $fn=50);
      

      // top chamfer
      translate([0,0,h-chamfer])
        linear_extrude(height=chamfer, scale=d_max_thread/d_min_thread) 
          circle(d=d_min_thread);
      
      //top cap
      translate([0,0,h])
        cylinder(h=2,d=d_max_thread+2);
    }
   
    //bottom chamfer (inner)
    //color("red")
    difference() {
      cylinder(d=d_max_thread+1, h=1);
      linear_extrude(height=1, scale=d_max_thread/d_min_thread) 
        circle(d=d_min_thread);
    }
  }
}



module nut(d, h, d_thread){
  // h - the nut's total height
  // d - the nut's outer diemater
  // d - d_max_thread 
  
  //wall=1;
  pitch = 2.5;
  chamfer = 3; // top and bottm chamfer height
 
  d_max_thread = d_thread; 
  d_min_thread = d_max_thread- (1.082532 * pitch);
  d_outer = d;
  
   difference(){
    cylinder(d=d_outer,h=h);
   
    union(){
      //will draw th thread
      translate([0,0,0]) 
        metric_thread(diameter=d_max_thread, pitch=pitch, length=h, internal=true, $fn=50);
      
      //will draw 1 mm top and bottm chamfers
      translate([0,0,h-chamfer]) 
        linear_extrude(height=chamfer, scale=d_max_thread/d_min_thread) 
          circle(d=d_min_thread);
      translate([0,0,0]) 
        linear_extrude(height=chamfer, scale=d_min_thread/d_max_thread) 
          circle(d=d_max_thread);
    }
   }
}

//translate([0,0,5])
nut(d=12,h=10, d_thread=10+0.6);

//color("red") 
screw(10,10);