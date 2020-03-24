// https://openhome.cc/eGossip/OpenSCAD/SectorArc.html
include <arc.scad>;
//module arc(radius, thick, angle)


phone_width = 75;
phone_height=10;
//half_w = w/2;
holder_thick=3;
holder_height = 20;

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

module horizontal_clamp(x,y,z,thick){
  // x = the inner x size
  // y = the inner y size 
  // z = the z size 
  // thick = the wall thickness
  union(){
    difference(){
      rounded_cube(x+2*thick,y+2*thick,z,thick);
        translate([thick,thick,-0.001]) rounded_cube(x,y,z+0.002,2);
        translate([2*thick,y+thick-0.001,-0.001]) cube([x-2*thick,thick+0.002,z+0.002]);
    }
    translate([1.5*thick+1,y+1.5*thick,0]) cylinder(d=thick,h=z);
    translate([x + 0.5*thick-1,y+1.5*thick,0]) cylinder(d=thick,h=z);
  }
}

horizontal_clamp(phone_width, phone_height, holder_height, holder_thick);