include <threads.scad>;

$fn = 50;

thick = 2; // mm 
d = 27 + 2 * thick; // mm outer diameter

d_inner = 27; // mm inner diameter

h = 50; //mm height


//metric_thread(diameter=10, pitch=2.5, length=10, internal=false);


//difference(){
//color("red") cylinder(d=12,h=10);
//metric_thread(diameter=10, pitch=2.5, length=10, internal=true, $fn=20);
//}



pitch = 2.5;
dmax = 10;

dmin = dmax- (1.082532 * pitch);

//difference() {
//  difference(){
//    cylinder(d=12,h=10);
cylinder(d=dmin,h=10);
//  }

  color ("red") translate([0,0,3]) metric_thread(diameter=dmax, pitch=pitch, length=5, internal=true, $fn=20);

//}