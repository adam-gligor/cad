$fn=50;

X = 13;
Y = 15;
B = 1.3;
ZZ = 8.5;
Z = ZZ - (2*B);

R1 = 5;
module xxx() {
    for (z =[0:10])
        rotate([0,0,18*z])
                cube([R1,0.4,1]);
}

module base() {
    
    union(){
        translate([1,0,0]){
            cylinder(Z,d=Y);
            translate([0, -Y/2, 0]) cube([X,Y,Z]);
        }
        cylinder(Z+3,r=R1);
//        translate([0,0,Z+3]) 
//        xxx();
    }
}


difference() {
     base();

    //cutout
    cylinder(10,d=4.5);
}

translate([X,-Y/2,-B])
cube([1.3,Y,ZZ]);
