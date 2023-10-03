// Change these for other phones

phone_thickness=9.5;
phone_width=73.5;

// Change these for  other cars
vent_hole_height=8; 
vent_hole_width=14;
vent_hole_distance=77;
vent_thickness=3.5;
vent_depth=17;

angle=12;
height=60;

wall_thickness=2;

center=(phone_width+2*wall_thickness)/2;

module hook () {
    difference() {
        cube([vent_hole_width,vent_depth+5,vent_hole_height]);
        union() {
            cube([vent_hole_width,vent_depth,vent_hole_height/2]);
            translate([0,0,2]) cube([vent_hole_width,vent_depth+2,vent_thickness]);
        }
    }
}

difference() {
    union() {
        cube([phone_width+(2*wall_thickness),phone_thickness+(2*wall_thickness),height]);
        rotate([-angle,0,0]) {
            cube([phone_width+(2*wall_thickness),phone_thickness+(2*wall_thickness),height]);
            translate([center-vent_hole_distance/2,phone_thickness+2*wall_thickness,height-vent_hole_height])
                hook();
            translate([center+vent_hole_distance/2-vent_hole_width,phone_thickness+2*wall_thickness,height-vent_hole_height])
                hook();
                }
    }
    union() {
        translate([wall_thickness,wall_thickness,wall_thickness]) 
            cube([phone_width,phone_thickness,phone_width]);
        translate([wall_thickness*2,0,wall_thickness*2]) 
            cube([phone_width-2*wall_thickness,phone_thickness,height]);
        translate([center-7.5,0,-10]) 
            cube([15,phone_thickness+wall_thickness,10+wall_thickness*2]);
        translate([0,0,-10]) cube([2*phone_width,2*phone_thickness,10]);
    }
}