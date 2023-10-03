// https://openhome.cc/eGossip/OpenSCAD/SectorArc.html
include <arc.scad>;
//module arc(radius, thick, angle)


phone_x = 75;
phone_y=150;
phone_z=11;
//half_w = w/2;
holder_thick=4;
clamp_width = 20;

$fn=50;
//square([10,10]);

module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};

module rounded_cube(x,y,z,r) {
  
  translate([0,r,0]) cube([x,y-2*r,z]);
  translate([r,0,0]) cube([x-2*r,y,z]);
  translate([x-r,y-r,0]) cylinder(r=r,h=z);
  translate([x-r,r,0]) cylinder(r=r,h=z);
  translate([r,y-r,0]) cylinder(r=r,h=z);
  translate([r,r,0]) cylinder(r=r,h=z);
  
  //color("red") translate([x-2*r,-y/2,0]) cube(size=[x,y,z],center=center);
}

module horizontal_clamp(x,y,z,wall_thick){
  // x = the inner x size
  // y = the inner y size 
  // z = the z size 
  // wall_thick = the wall wall_thickness
  difference(){
    union(){
       union(){
         difference(){
            rounded_cube(x+2*wall_thick,y+2*wall_thick,z,wall_thick);
            translate([wall_thick,wall_thick,-0.01]) rounded_cube(x,y,z+0.02,2);
            translate([2*wall_thick,y+wall_thick-0.01,-0.01]) cube([x-2*wall_thick,wall_thick+0.02,z+0.02]);
         }
         
         translate([2*wall_thick,y+1.5*wall_thick,0]) cylinder(d=wall_thick,h=z);
         translate([x + 0.5*wall_thick-1,y+1.5*wall_thick,0]) cylinder(d=wall_thick,h=z);
        }
        
        
        hull(){
          translate([x/2+wall_thick-z,0,0]) cylinder(r=wall_thick, h=z);
          translate([x/2+wall_thick+z,0,0]) cylinder(r=wall_thick, h=z);
        }
      }
  translate([x/2-1.5*wall_thick,0,-0.01]) cube([z,wall_thick+0.02,z+0.02]);
  }
}

module vertical_clamp(x,y,z,thick){
  // x = the inner x size
  // y = the inner y size 
  // z = the z size 
  // thick = the wall thickness
  union(){
    difference(){
      rounded_cube(x+2*thick,y+2*thick,z,thick);
      translate([thick,thick,-0.01]) rounded_cube(x,y,z+0.02,2);
      translate([2*thick,y+thick-0.01,-0.01]) cube([x-2*thick,thick+0.02,z+0.02]);
      
      translate([thick,y+0.5*thick+0.01,-0.01]) cube([thick*1.5,thick*1.5,z+0.02]);
    }
   translate([x + 0.5*thick-1,y+1.5*thick,0]) cylinder(d=thick,h=z);
  } 
}

//horizontal_clamp(phone_x, phone_z, clamp_width, holder_thick);
//translate([phone_x/2+clamp_width/2+holder_thick,0,-phone_y+clamp_width-holder_thick+phone_x/2]) rotate([0,-90,0]) 
//vertical_clamp(phone_y, phone_z, clamp_width, holder_thick);

r=36/2;
y=20;
module handle(x,z, r) {
//  linear_extrude(height=z){
    arc(r,[20,160],5);
    translate([-x/2,x,0]) square([x,x]);
//  }
}

module foo(){
  difference(){
  union(){
    difference(){
      linear_extrude(height=r) handle(y,y,r);

      //translate([0,0,0])
//      linear_extrude(height=r) {
//        offset(r = -3) {
//          handle(y,y,r);
//        }
//      }
    }

    translate([0,0,1])
    linear_extrude(height=r-2) {
      offset(r = -1) {
        handle(y,y,r);
      }
    }
  }
    
    translate([-15,20.5,6]) cube([30,2,4]);
  
}
}

//translate([phone_x/2+holder_thick,-40,0])
foo();
