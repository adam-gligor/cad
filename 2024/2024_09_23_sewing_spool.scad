di = 6.1 + 0.1; // mm
do = 20.5; //mm

h = 24; //mm

$fn=100;


difference(){
    donut(do=do,di=di,h=2);
    translate([(do-di)/2,0,0]) cylinder(d=2.5,h=2);
    translate([-di/2-3.5,-1,0]) cube([4,2,1]);
}

translate([0,0,h]) difference(){
    donut(do=do,di=di,h=2);
    translate([-(do-di)/2,0,0]) cylinder(d=2.5,h=2);
    translate([di/2+3.5,-1,1]) cube([4,2,1]);

}

translate([0,0,2]) donut(do=di+4,di=di,h=h-2);



module donut(do, di, h){

    difference() {
        cylinder(d=do,h=h);
        cylinder(d=di,h=h);
    }
}
