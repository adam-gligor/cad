$fn=100;
difference(){

//    cylinder(d=23.2,h=2.4);
    union(){
        linear_extrude(height=0.6, scale=[23.2/22.2, 23.2/22.2])
            circle(d=22.2);

        translate([0,0,0.6])
            cylinder(d=23.2,h=2.4-1.2);

        translate([0,0,2.4-0.6])
            linear_extrude(height=0.6, scale=[22.2/23.2, 22.2/23.2])
                circle(d=23.2);
    }
    cylinder(d=6,h=2.4);
}