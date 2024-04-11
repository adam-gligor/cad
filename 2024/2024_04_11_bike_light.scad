X1 = 11;
Y1 = 15;
Z1 = 15;

$fn=100;

s = 5.6; //scred diam
module xxx(x,y,z){
    
    difference(){
    intersection(){
        union(){
            translate([0,y/2,z-y/2]) rotate([0,90,0])  cylinder(d=y,h=x);
            cube([x,y,z-y/2]);
        }
        cube([x,y,z]); // majes sure it doesnt fall outside the bounds
    }

    translate([0,y/2,z-y/2]) rotate([0,90,0])  cylinder(d=s,h=x);
    }
}



px = 2.4;
py=2.4;
pz=2.4;

OX=X1+2*px;
OY = Y1+2*py;
OZ = Z1+pz;

//difference(){ 
    
  
    
    difference(){
        translate([-px,-py,0]) xxx(OX,OY,OZ);
        xxx(X1,Y1,Z1);
    }

    
    translate([-px,OY/2-py,OZ-OY/2]) rotate([0,90,0])  
    difference() {
        cylinder(d=s+4,h=OX);
        cylinder(d=s,h=OX);
    }
//}
    