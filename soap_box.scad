include <../scad-utils/morphology.scad>;
$fn=20;

height = 22; // mm total height 
length = 120; // mm total lenght
width = 75; // mm total thickness

half_width = width/2;
half_length = length/2;

side_thick = 4; 
bottom_thick = 2;

module shape (width){
  half_width = width/2;
  
  fillet(d=0.9)
    rounding(r=0.9)
      polygon(points = [
        [0,0],
        [half_width,0],
        
        [half_width-(side_thick/2),side_thick],
        [half_width-(side_thick/2),height-side_thick],
        [half_width,height], 
        [half_width-side_thick,height],
        [half_width-side_thick,bottom_thick],
        [0,bottom_thick],
      ]);
}


linear_extrude(height=half_length-half_width/2) shape(width=half_width);
translate([half_width/4,0,0]) rotate([-90,0,0]) rotate_extrude(angle = 90) shape(width=half_width/2);