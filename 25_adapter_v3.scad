X = 104 -0.5;
Y = 47 + 15;


X3 = X-31;
Y3 = 15;

Z1 = 11;
Z2 = 26;

WALL = 0.6;

module hollow_box(xyz_trans, xyz, wall){
    difference(){
        translate(xyz_trans) 
            cube(xyz);
        translate(xyz_trans + [wall, wall, 0]) 
            cube(xyz - [2*wall, 2*wall, 0]);
    }
}


module grid(){
 hollow_box([0,0,0],[X,Y,Z2],WALL);

 hollow_box([0,0,0],[X/2,Y,Z2],WALL);

 hollow_box([0,0,0],[X,Y/2,Z2],WALL);

 hollow_box([X-X3-WALL,Y-Y3-WALL,0],[X3+WALL,Y3+WALL,Z2], WALL);
}

difference(){
    grid();
    translate([X-X3,Y-Y3,0])
    cube([X3,Y3,Z1]);
}

hollow_box([0,0,Z2-0.6], [X,Y, 0.6], 3);