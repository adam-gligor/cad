D = 27; // normally is 28 ; // mm 
D2 = D +2;
R = D/2;
H = 5;

$fn=100;

difference(){

union(){
cylinder(d=D2, h=H);

translate([R,0,0])
cylinder(d=6, h=H);
}

union(){
cylinder(d=D, h=H);

translate([0,-0.5,0])
cube([D2/2+5,1,H]);

}

}

