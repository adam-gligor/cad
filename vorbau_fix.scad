$fn = 100;

//difference(){
//cylinder(d=30,h=0.8);
//cylinder(d=16,h=0.8);
//}

//19-16

//10

//6.5



difference() {

    hull(){

    cylinder(d=22,h=0.4);
    translate([0,0,4]) cylinder(d=12,h=0.1);
    }

    union(){
        cylinder(d=6.5,h=4);
        translate([0,0,1]) cylinder(d=10,h=4);
    }
}