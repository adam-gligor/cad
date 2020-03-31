include<arc.scad>; 

d_big = 38.6; // mm;
d_small = 25.6; // mm;

height = 15; //mm;
chamfer = 2; //mm

$fn = 100;

  difference() {
    union(){
      cylinder(d=d_big+2,h=height);
      
      translate([0,0,height])
        rotate_extrude(angle=360)
          translate([d_big/2-chamfer,0,0])
          arc(radius=chamfer,angles=[0,90],$fn=50);
        
      translate([0,0,height+chamfer])
         cylinder(d=d_big-2*chamfer,h=1);

    }
    cylinder(d=d_big,h=height);
    cylinder(d=d_small,h=height+5);
  }

