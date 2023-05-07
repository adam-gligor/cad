// m16 pipe 1eu/3m
$fn=100;


module corner_connector_v2() {
// 7 x 2 cm
H = 40; // total size of the shape
R = 24/2; // total thickness at the connection point
R2 = 16/2 + 0.1*(16/2); // radius of the connected tubes

module inner_leg(){
    
    difference(){
        hull(){
            T = H-R;
//            translate([-R/2,-R/2,0]) sphere(r=3);
//            translate([R/2,R/2,0]) sphere(r=3);
//            translate([-R/2,R/2,0]) sphere(r=3);
//            translate([R/2,-R/2,0]) sphere(r=3);
//            translate([-R/2,-R/2,H]) sphere(r=3);
//            translate([R/2,R/2,H]) sphere(r=3);
//            translate([-R/2,R/2,H]) sphere(r=3);
//            translate([R/2,-R/2,H]) sphere(r=3);
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
    translate([R,0,R]) sphere(d=10);
    translate([R,0,R+5]) sphere(d=10);
    translate([R+5,0,R]) sphere(d=10);
    }
    rotate([0,0,90])
    hull(){
    translate([R,0,R]) sphere(d=10);
    translate([R,0,R+5]) sphere(d=10);
    translate([R+5,0,R]) sphere(d=10);
    }

}

rotate([0,0,0]) inner_leg();
rotate([0,90,0]) rotate([0,0,90]) inner_leg();
rotate([-90,0,0]) rotate([0,0,-90]) inner_leg();
}


corner_connector_v2();
