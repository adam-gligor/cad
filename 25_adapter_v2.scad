//xy = 104 x 47
//z = 26
//side_x = 31

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

module box(xyz_trans, xyz){
    translate(xyz_trans) 
        cube(xyz);
}


module hollow_box(xyz_trans, xyz, wall){
    difference(){
        translate(xyz_trans) 
            cube(xyz);
        translate(xyz_trans + [wall, wall, 0]) 
            cube(xyz - [2*wall, 2*wall, 0]);
    }
}

module box_l(wall, z){
    hollow_box([X2,0,0],[X1,Y1,z],wall);
}

module box_b(wall, z){
    hollow_box([0,0,0],[X2,Y2,z],wall);
}

module box_t(wall, z_trans, z){
    hollow_box([X2,Y1,z_trans], [X3,Y3,z], wall);
}



box_l(WALL, Z1+Z2);
box_b(WALL, Z1+Z2);
box_t(WALL, Z1, Z2);

translate([0,0,Z1+Z2-0.6]){
    box_l(3, 0.6);
    box_b(3, 0.6);
    box_t(3, 0, 0.6);
}




