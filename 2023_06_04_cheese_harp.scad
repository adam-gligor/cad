
// 12.8 x 4.8
a = 12.8;
b = 4.8;
c = 10+b;
p = 1.4; // pad 

difference() {
    ap = a+2*p;
    bp = b+2*p;
    cp = c+p-0.1;
    union(){
    translate([0,-b-2*p,0]) rotate([0,0,0]) cube([ap,bp,cp]);
    translate([0,0,0]) rotate([90,0,0]) cube([ap,bp,cp]);
    }
    
    translate([p,-p,p])
    union(){
    translate([0,-b,0]) rotate([0,0,0]) cube([a,b,c]);
    translate([0,0,0]) rotate([90,0,0]) cube([a,b,c]);
    }

}