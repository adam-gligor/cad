
//horizontal piece
X1 = 104; 
Y1 = 47;

//verical piece
X2 = 31;
Y2 = Y1+15;

//union of two
X3 = X1;
Y3 = Y2;


Z1 = 11;
Z2 = 26-Z1;

WALL= 1;
DWALL = 2*WALL;

module shape(){
    cube([X1,Y1,Z1]);
    cube([X2,Y2,Z1]);
    translate([0,0,Z1])
        cube([X3,Y3,Z2]);
}

module cutout(){
    color("red"){
        translate([WALL,WALL,0]){
            cube([X1-DWALL,Y1-DWALL,Z1+Z2]);
            cube([X2-DWALL,Y2-DWALL,Z1+Z2]);
        }
    }
    color("blue"){
        translate([X2,Y1,Z1])
        cube([X1-X2-WALL,Y2-Y1-WALL,Z2]);
        
    }
}

translate([0,0,Z1+Z2-0.6])
    cube([X3,Y3,0.6]);

difference(){
    shape();
    cutout();
}