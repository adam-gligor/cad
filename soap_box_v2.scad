include <../scad-utils/morphology.scad>;
include <../scad-utils/mirror.scad>;

height = 22; // mm total height 
length = 120; // mm total lenght
width = 75; // mm total thickness

half_width = width/2;
half_length = length/2;

side_thick = 5; 
bottom_thick = 2;

$fn = 50;

module side (){
  half_width = 10;
  
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


rounding = side_thick+10;

//translate([half_width-side_thick,half_length-side_thick-rounding,0]){
  //the corner
  translate([-rounding,0,0])
    rotate_extrude(angle=90)
      translate([rounding,0,0])
        side();
  //the long side
  rotate([90,0,0])
    linear_extrude(height=half_length-side_thick-rounding)
      side();
  //the short side
  translate([-half_width+side_thick,rounding,0])
    rotate([90,0,90])
      linear_extrude(height=half_width-side_thick-rounding)
        side();

  //the bottom
  //translate([0,rounding,0]) {
    //rotate([0,0,-180]){
      difference(){
        cube(size =[half_width-side_thick,half_length-side_thick,bottom_thick]);
        color("red") cube(size=[rounding,rounding, bottom_thick]);
      }
      translate([rounding,rounding,0])
        cylinder(r=rounding,h=bottom_thick);
    //}
  //}
  
    
//}