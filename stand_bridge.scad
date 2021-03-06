X=210;//mm;
Z = 9;
Y=15.6;

x=12.8;
y=13;
z=4;


module xxx(){
    translate([-x,(Y-y)/2,(Z-z)/2 +z])
    rotate([90,0,90])
    linear_extrude(height=x)
    polygon([[0,-2],[2,0],[y-2,0],[y,-2],[y-2,-z],[2,-z],[0,-2]]);
}

cube([X, Y, Z]);
xxx();
translate([X+x,0,0])
xxx();