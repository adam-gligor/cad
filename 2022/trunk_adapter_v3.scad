w=135;
h=135;

difference(){
  linear_extrude(height=25, center=false){
    difference(){
      translate([5,5,0]) {
        minkowski(){
          square(size=[w-10,h-10]);
          circle(r=5);
        }
      }
       color("red") 
      translate([5+15,5+15,0]) {
          
          minkowski(){
            square(size=[w-40,h-40]);
            circle(r=5);
          }
        
      }
      
      

    }
  }

  translate([-1,-27,12.5])
  rotate([0,90,0])
  cylinder(r=30,h=w+2, $fn=50);
}