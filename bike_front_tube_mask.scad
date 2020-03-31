include<arc.scad>; 

d_big = 38.6; // mm;
d_small = 25.6; // mm;

height = 15; //mm;
//height2 = 0; //mm


$fn = 100;



  difference() {
    union(){
      cylinder(d=d_big+2,h=height);
      
      translate([0,0,height])
        rotate_extrude(angle=360)
          translate([d_big/2-2,0,0])
          arc(radius=2,angles=[0,90],$fn=50);
        
      translate([0,0,height+2])
         cylinder(d=d_big-2*2,h=1);

    }
    cylinder(d=d_big,h=height);
    cylinder(d=d_small,h=height+5);
  }

