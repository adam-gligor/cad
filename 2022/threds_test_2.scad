include <threads.scad>;

$fn = 50;

// https://en.wikipedia.org/wiki/ISO_metric_screw_thread


module screw(d, h){
  // d = the outer diameter (d_max_thread)
  // h = the screw's total height
  // will include 1mm bottom chamfer
   
  d_max_thread = d;
  pitch = 2.5;
  d_min_thread = d_max_thread- (1.082532 * pitch);
  
  difference(){
    union(){
      translate([0,0,0])
        metric_thread(diameter=d_max_thread, pitch=pitch, length=h, internal=false, $fn=50);
      

      // top chamfer
      translate([0,0,h-1])
        linear_extrude(height=1, scale=d_max_thread/d_min_thread) 
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



module nut(d, h){
  // h - the nut's total height
  // d - d_max_thread (with 1 mm wall, means thread outer diamter =d+2)
  
  wall=1;
  pitch = 2.5;
  
  d_max_thread = d; 
  d_min_thread = d_max_thread- (1.082532 * pitch);
  d_outer = d_max_thread+2*wall;
  
   difference(){
    cylinder(d=d_outer,h=h);
   
    union(){
      //will draw th thread
      translate([0,0,0]) 
        metric_thread(diameter=d_max_thread, pitch=pitch, length=h, internal=true, $fn=50);
      
      //will draw 1 mm top and bottm chamfers
      translate([0,0,h-1]) 
        linear_extrude(height=1, scale=d_max_thread/d_min_thread) 
          circle(d=d_min_thread);
      translate([0,0,0]) 
        linear_extrude(height=1, scale=d_min_thread/d_max_thread) 
          circle(d=d_max_thread);
    }
   }
}

//translate([0,0,5])
//nut(10,5);

//color("red") 
screw(10,10);