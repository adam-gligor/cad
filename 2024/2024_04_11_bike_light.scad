X1 = 11;
Y1 = 15;
Z1 = 15+2;

$fn=100;

s = 5.6; //scred diam
module xxx(x,y,z, hole){
    
    difference(){
    intersection(){
        union(){
            translate([0,y/2,z-y/2]) rotate([0,90,0])  cylinder(d=y,h=x);
            cube([x,y,z-y/2]);
        }
        cube([x,y,z]); // majes sure it doesnt fall outside the bounds
    }

    if (hole==true) translate([0,y/2,z-y/2]) rotate([0,90,0])  cylinder(d=s,h=x);
    }
}



module foo2(){
XX = 16;
YY = Y1;
ZZ = 3;
PXX = (XX-X1)/2;

//difference(){    
//translate([-PXX,0,0]) cube([XX,YY,2*ZZ]);
//translate([0,0,0]) cube([X1,Y1,2*ZZ]);
//}
X3 = 2.6;
Y4 = X3*2;
   difference(){
translate([-X3,0,0]) cube([X3,Y1,ZZ*2+Y4/2]);
translate([-Y4/2,Y1,Y4/2+ZZ*2]) rotate([90,0,0]) cylinder(d=Y4,h=Y1);
   }

}


px = 2.4;
py=2.4;
pz=2.4;

OX=X1-2*px;
OY = Y1-2*py;
OZ = Z1-pz;

    
  
    
    translate ([0,0,3]) difference(){
        xxx(X1,Y1,Z1,true);
        translate([px,py,0]) xxx(OX,OY,OZ);
        
    }

foo2();

translate([X1,Y1,0]) rotate([0,0,-180]) foo2();

