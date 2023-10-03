D = 60.2;
H=19;
$fn=100;

difference(){

linear_extrude(H)
difference(){
offset(r=1.2) circle(d=D);
circle(d=D);
}

union(){
    translate([10,0,7])
    rotate([0,90,0])
    cylinder(d=2.5,h=D/2);

    translate([-10,0,H-7])
    rotate([0,-90,0])
    cylinder(d=2.5,h=D/2);
}

}