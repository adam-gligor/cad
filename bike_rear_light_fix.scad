
L = 15;
W = 8.5;
H= 1.2;
X = 1.3;
cube([L,W,H]);


W1=W-2*X;
W2=W1/2;
R=L/2;


translate([0, X, 0]) cube([L,W1,8]);
translate([0, X, 0]) cube([L,W2,13]);
translate([R,W2+X,13]) rotate([90,0,0]) cylinder(W2,d=L);




//polygon([[0,0],[W,0], [W,20]]);
