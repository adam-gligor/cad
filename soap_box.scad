include <../scad-utils/morphology.scad>;
include <../scad-utils/mirror.scad>;
include<arc.scad>;
$fn=20;

height = 22; // mm total height 
length = 120; // mm total lenght
width = 75; // mm total thickness

half_width = width/2;
half_length = length/2;

side_thick = 5; 
bottom_thick = 2;

rounding = 10;

module shape (){
  //half_width = 10;
  
  fillet(r=0.9)
   rounding(r=0.9)
      polygon(points = [
        [0,0],
        [0.5*side_thick,0],
        
        [side_thick,0.1*height],
        [side_thick,0.2*height],
        [side_thick/2,0.3*height],
        [side_thick/2,0.75*height],
        [side_thick,0.9*height],
        
  
        [side_thick,height],
        [0,height]
      ]);
}

module side_section(){
  
  //long side + corner
  translate([half_width,0,-half_length])
    union(){
      translate([0,0,rounding])
        linear_extrude(height=half_length-rounding) 
          shape();
      translate([-rounding,0,rounding]) 
        rotate([-90,0,0]) 
          rotate_extrude(angle = 90, $fn=50)
            translate([rounding,0,0]) 
              shape();
    }
   
    //short side
   translate([0,0,-half_length])
     rotate([0,90,0]) 
      linear_extrude(height=half_width-rounding) 
        shape();
    
    //bottom
    union(){
     difference(){
      cube(size =[half_width+1,half_length+1,bottom_thick]);
      translate([half_width-rounding+1,half_length-rounding+1,0])
        cube(size =[rounding,rounding,bottom_thick]);
      }
      translate([half_width-rounding+1,half_length-rounding+1,0])
        cylinder(r=rounding, h=bottom_thick);
    }
}

// draw 

rotate([90,0,0])
  mirror_z()
    union(){
      mirror_x() side_section();
      side_section();
    }


//linear_extrude(height=bottom_thick)
