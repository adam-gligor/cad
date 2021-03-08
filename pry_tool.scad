include <../scad-utils/morphology.scad>;
X=150;
Y=2.5;
Y1=Y+4;
Z=10;
linear_extrude(height=Z)
polygon([[0,-1],[X,0],[X,Y1],[X-Y,Y1],[X-Y,Y],[0,Y+1]]);

scale([1,1,1])
translate([0,25,Z/2])
rotate([90,0,0])
cylinder(h=50,d=Z);