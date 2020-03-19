
w=160;
half_w = w/2;
h = 140;
thick = 20; // w/thick , w/height should be integer
half_thick = thick/2;


module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};
linear_extrude(height=25, center=false)
{
  copy_mirror([1,0,0]) {
    difference(){
      
      union(){
        //body minus a corner
        difference(){
          polygon([[0,0],[half_w,0],[half_w,h],[0,h]]);
          translate([half_w-thick,h-thick,0]) square(size=[thick,thick]); 
        }
        //cricle to fill the corner
        translate([half_w-thick,h-thick,0]) circle(d=thick*2);
      }
      //center big holw
        minkowski(){
            color() {translate([thick+half_thick,thick*2]) circle(r=thick);}
            color() {translate([0,0]) square(size=[half_w-thick*2-thick-half_thick,h-4*thick]);}
        }
       
       c_shrink=5;
       //horizontal holes bottom
       color("red"){
         for (i=[0:2])
          translate([half_thick+i*thick,half_thick,0]) 
          circle(d=thick-c_shrink);
       }

       //horizontal holes top
       color("red"){
         for (i=[0:2])
          translate([half_thick+i*thick,h-half_thick,0]) 
          circle(d=thick-c_shrink);
       }
       
       //vertical side holes
        color("red"){
         for (i=[1:5])
          translate([half_w-half_thick,half_thick+i*thick,0]) 
          circle(d=thick-c_shrink);
       }
       
       //vertical center
        color("red"){
         for (i=[1:5])
          translate([0,half_thick+i*thick,0]) 
          circle(d=thick-c_shrink);
       }
     }
   }
 }