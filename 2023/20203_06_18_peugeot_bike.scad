
include <utils.scad>;

$fn=100;
module v1() {
H = 8;
D1 = 7;
D2 = 12;

D12 =6;

difference() {
    
    union(){
        translate([0,0,D2/2]) rotate([0,90,0]) cylinder(h=H, d=D2);

        translate([0,-D2/2,0]) cube([H,D2,D2/2]);

        translate([0,D2/2,0]) cube([H,D2/2,5]);

        translate([4,D2/2+9,0])  tube(h=5, r1=(D12+4)/2, r2=D12/2);
    }translate([0,0,X]) rotate([0,90,0]) cylinder(h=X, r=X);

translate([0,0,D2/2]) rotate([0,90,0]) cylinder(h=H, d=D1);
    
}

}

module v2(){
    
    H =8;
    R = 3; // D=6 holes
    P = 8;
    HP = 4;
    
    X = R+HP;

    difference() {
        union(){
            translate([0,0,X]) rotate([0,90,0]) cylinder(h=X, r=X);
            
            hull(){
                translate([0,0,0]) cube([X,0.1,2*X]);
                translate([0,2*X,0]) cube([X,X,X]);
            }

            hull(){
                translate([0,3*X,0]) rotate([0,0,0]) cylinder(h=X, r=X);
                translate([-2*X,3*X,0]) rotate([0,0,0]) cylinder(h=X, r=X);
            }
        }translate([0,0,X]) rotate([0,90,0]) cylinder(h=X, r=X);
        
    //holes
        union(){
            translate([0,0,R+HP]) rotate([0,90,0]) cylinder(h=H, r=R);
            hull(){
                translate([-0.5*X,3*X,0]) rotate([0,0,0]) cylinder(h=X, r=R);
                translate([-2*X,3*X,0]) rotate([0,0,0]) cylinder(h=X, r=R);
            }
        }
    }
}

module v3(){
    
    R = 3; // D=6 holes
    HP = 4; // thickness   
    X = R+HP; // thickness on X axis
    
    LY = 8 *X  ; // lentgth on Y axis (logically the height) initiailly 4x
    
    difference() {
        union(){
            
            // circle piece
            translate([0,0,X]) rotate([0,90,0]) cylinder(h=X, r=X);
            
            // connector 1
            hull(){
                translate([0,0,X]) rotate([0,90,0]) cylinder(h=X, r=X); // same as the 'circle piece'
                //translate([0,0,0]) cube([X,0.01,2*X]);
                translate([0,2*X,0]) cube([X,0.01,X]);
                //translate([-0.5*X,3*X,0]) rotate([0,0,0]) cube([X,0.1,X]);
            }
            

            // connector 2
            translate([0,X,0]) cube([X,LY,X]);


            // oval piece
            translate([1.5*X,LY,0])
            hull(){
                translate([0,0,0]) rotate([0,0,0]) cylinder(h=X, r=X);
                translate([-1.2*X,0,0]) rotate([0,0,0]) cylinder(h=X, r=X);
                //translate([-2*X,-X,0]) rotate([0,0,0]) cube([X,X,X]);
                //translate([0,-X,0]) rotate([0,0,0]) cube([X,X,X]);
            }
            
           
        }
        
        //holes
        union(){
            translate([0,0,R+HP]) rotate([0,90,0]) cylinder(h=X, r=R);
            translate([1.5*X,LY,0])
            hull(){
                translate([-0*X,0,0]) rotate([0,0,0]) cylinder(h=X, r=R);
                translate([-1.2*X,0,0]) rotate([0,0,0]) cylinder(h=X, r=R);
            }
        }
    }
}

v3();