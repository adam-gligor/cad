//total_xy: 104 x 47 
//side_x: 31

X = 104;
Y = 47;

//right box
X1 = X-31; 
Y1 = Y;

//left box
X2 = 31;
Y2 = Y+15;

//top box
X3 = X1;
Y3 = Y2-Y;


Z1 = 11;
Z2 = 26-Z1;

WALL= 0.8;
DWALL = 2*WALL;

module box_l(hollow = false, wall = 0){
    translate([X2,0,0]) cube([X1,Y1,Z1+Z2]);    
}

module box_b(){
    color("blue") cube([X2,Y2,Z1+Z2]);
}

module box_t(){
    translate([X2,Y1,Z1]) cube([X3,Y3,Z2]);
}

module shape(){
}

module cutout(){
    color("black"){
        translate([X2,WALL,0]) cube([X1-WALL,Y1-DWALL,Z1+Z2]);
        translate([WALL,WALL,0]) cube([X2-DWALL,Y2-DWALL,Z1+Z2]);
        translate([X2,Y1,Z1]) cube([X3-WALL,Y3-WALL,Z2]);
    }
}



difference(){
    union(){
        box_l();
        box_b();
        box_t();
    }
    cutout();
}
