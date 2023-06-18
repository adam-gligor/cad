
module tube(r1, r2, h ){
    difference() {
        cylinder(r=r1, h=h);
        cylinder(r=r2, h=h);
    }
}

module taperout(r,h) {
    intersection(){
        cylinder(r=r, h=h);
        cube([r,r,h]);
    }
}

module taperin(r,h) {
    difference(){
        cube([r,r,h]);
        cylinder(r=r, h=h);
    }
}

//tube(20,10,10);

// taperout(10,10);

 taperin(10,10);