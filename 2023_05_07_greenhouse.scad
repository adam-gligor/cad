// m16 pipe 1eu/3m
$fn=100;


module corner_connector_v2() {
// 7 x 2 cm
H = 30; // total size of the shape
R = 24/2; // total thickness at the connection point
R2 = 16/2 + 0.1*(16/2); // radius of the connected tubes

module inner_leg(){
    
    difference(){
        hull(){
            T = H-R;
            cylinder(h=H,r=R);
            sphere(r=R);
        }
        union(){
            T = H-2*R;
            H = 2* R;
            translate([0,0,T+3]) rotate([0,0,0]) cylinder(h=H,r=R2);
        }
    }
    
    hull(){
    translate([R,0,R]) sphere(d=5);
    translate([R,0,R+5]) sphere(d=5);
    translate([R+5,0,R]) sphere(d=5);
    }
    rotate([0,0,90])
    hull(){
    translate([R,0,R]) sphere(d=5);
    translate([R,0,R+5]) sphere(d=5);
    translate([R+5,0,R]) sphere(d=5);
    }

}

rotate([0,0,0]) inner_leg();
rotate([0,90,0]) rotate([0,0,90]) inner_leg();
rotate([-90,0,0]) rotate([0,0,-90]) inner_leg();
}

//corner_connector_v2();

module corner_connector_v3(){
    
    
    R = 16/2 + 0.1*(16/2); // radius of the connected tubes
    H = 15; // part 1, polygon
    H2 = 10; // paer2, arms
    R2 = R+3; // wall thichness

    difference(){

        union(){
        // base polygon
        hull(){
        translate(0.0*[R,R,R]) sphere(r=R2);
        translate([0,H,0]) rotate([-90,0,0]) cylinder(h=1, r=R2);
        translate([H,0,0]) rotate([0,90,0]) cylinder(h=1, r=R2);
        translate([0,0,H]) rotate([0,0,0]) cylinder(h=1, r=R2);
        }
        
        // arms
        union(){

        translate([0,H,0]) rotate([-90,0,0]) cylinder(h=H2, r=R2);
        translate([H,0,0]) rotate([0,90,0]) cylinder(h=H2, r=R2);
        translate([0,0,H]) rotate([0,0,0]) cylinder(h=H2, r=R2);
        }
    }
    
    // cutout
    union(){
        L=20;
        H2=20;
        translate([0,0,0]) rotate([-90,0,0]) cylinder(h=H+H2, r=R);
        translate([0,0,0]) rotate([0,90,0]) cylinder(h=H+H2, r=R);
        translate([0,0,0]) rotate([0,0,0]) cylinder(h=H+H2, r=R);
        }
    
    }
}


corner_connector_v3();
