
//tube diameters
D1=41; // original


//small hole diameters
d1=5; // hose
d2=6; 
d3=10; //existing clamp
$fn=50;


module shape_1(d_inner, d_outer, z){
    
    //D2 = D1 + 2* d3 + 4; //outer tube (for topmost bound)
    //Z = 15;
    SIDE_OFFS = 3;
    
    difference() {
        //color("red")
        cylinder(d=d_outer, h=z);

        union() {
            //tube diameter
            color("blue")
            cylinder(d=d_inner, h=z);
            
            //bottom bound 
            translate([-(d_outer/2), -(d_outer/2),0])
            cube([d_outer, d_outer/2, z]);

            //left bound
            translate([-(d_inner/2)-20 + SIDE_OFFS,0,0])
                cube([20, d_outer, z]);

            //right bound
            translate([d_inner/2 - SIDE_OFFS,0,0])
                cube([20, d_outer, z]);
            
        }
    }
}

module cutout(z){
    zz = 10; //existing hole
    CUTOUT = 1.5;
    
    //left
    rotate([0,0,24])
    translate([0,(D1+d3)/2,0]) {        
        translate([0,0,2]) {
            cylinder(d=d1, h=z);                        
        }
        cylinder(d=d3, h=zz);
        cylinder(d=CUTOUT, h=z);
    }
    
    rotate([0,0,24])
    translate([-CUTOUT/2,(D1+d3)/2,0]) 
    cube([CUTOUT,d3,z]);

    
    //middle
    translate([0,(D1+d3)/2,0]){
        translate([0,0,2]) {
            cylinder(d=d1, h=z);
        }
        cylinder(d=CUTOUT, h=z);
    }
        
    translate([-CUTOUT/2,(D1+d3)/2,0]) 
    cube([CUTOUT,d3,z]);
    
    //right

    rotate([0,0,-24])
    translate([0,(D1+d3)/2,0]){
        translate([0,0,2]) {
            cylinder(d=d1, h=z);
        }
        cylinder(d=CUTOUT, h=z);
    }

    rotate([0,0,-24])
    translate([-CUTOUT/2,(D1+d3)/2,0]) 
    cube([CUTOUT,d3,z]);

}

module clamp() {
    DX = D1 + 3;
    
}

Z = 15;

difference(){
    shape_1(D1, D1 + 2* d3 + 4, Z);
    cutout(Z);
}

//translate([0,0,Z])
//shape_1(D1, D1 + 5, 4);

//color("red")
//cylinder(d=D1, h=15);