LP = 25; // pads
L = 190.5 + 2*LP;
W = 50;
H = 10;
R = 4;


difference() {
    // bar
    rr =10;
    translate([rr,rr,0])
    minkowski() {
        cylinder(r=rr, h=1);
        cube([L-2*rr,W-2*rr,H]);
    }

    // holes 
    union() {
        
        // holes for screws
        translate([LP, W/2, 0]) {
            cylinder(r=R, h= H+10);
        }

        translate([L-LP, W/2, 0]) {
            cylinder(r=R, h= H+10);
        }

        translate([L/2, W/2, 0]) {
            cylinder(r=R, h= H+10);
        }
        
        // holdes for speed cut
        
        
    }
    
    
}