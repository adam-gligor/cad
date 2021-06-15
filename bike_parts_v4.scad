
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
    SIDE_OFFS = 6;
    
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
            translate([-(d_outer/2) - SIDE_OFFS,0,0])
                cube([d_outer/2, d_outer/2, z]);

            //right bound
            translate([ SIDE_OFFS,0,0])
                cube([d_outer/2, d_outer/2, z]);
            
        }
    }
}

module cutout(z){
    zz = 6; //existing hole
    CUTOUT = 1.5;
    
//    //left
//    rotate([0,0,12])
//    translate([0,(D1+d3)/2,0]) {        
//        translate([0,0,2]) {
//            cylinder(d=d1, h=z);                        
//        }
//        translate([0,0, -10])
//            cylinder(d=d3, h=zz + 10);
//        cylinder(d=CUTOUT, h=z);
//    }
//    
//    rotate([0,0,12])
//    translate([-CUTOUT/2,(D1+d3)/2,0]) 
//    cube([CUTOUT,d3,z]);


    
    //right

    //rotate([0,0,-12])
    translate([0,(D1+d3)/2,0]){
        translate([0,0,2]) {
            cylinder(d=d1, h=z);
        }
        cylinder(d=CUTOUT, h=z);
    }

    //rotate([0,0,-12])
    translate([-CUTOUT/2,(D1+d3)/2,0]) 
    cube([CUTOUT,d3,z]);

}


Z = 14;

difference(){
    union()
    {
        shape_1(D1, D1 + 2* d3 + 4, Z);
        translate([0,0,-Z/2])
            shape_1(D1, D1 + 4, Z+14);
    }
    cutout(Z);
    
}
    translate([0,0,7])
    rotate([0,0,10])
     shape_1(D1, D1 + 4, (Z+14)/2);

//shape_1(D1, D1 + 2* d3 + 4, Z);


//color("red")
//cylinder(d=D1, h=15);