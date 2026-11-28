use <baita_centrala_v2_rcv.scad>


union(){
enclosure(

    length = 82,
    width = 23,
    height = 30,

    wall = 2,

    vent_enabled = true,
    vent_walls = ["front","back"],

    pcb_enabled = true,

    show_box = true,
    show_lid = false,
    
    side_hole_diameter = 8,
    side_hole_y=13

);

translate([25,-28-0.4,0])
enclosure(

    length = 51,
    width = 26.4,
    height = 14,

    wall = 2,

    vent_enabled = false,
    vent_walls = [ "right", "front"],
    

    pcb_enabled = true,
    pcb_height  = 4+8,

    show_box = true,
    show_lid = false,
    side_hole_enabled=false,
    screw_enabled=false
);



translate([0,-28-0.4,0])
enclosure(

    length = 82,
    width =26.4 ,
    height = 30,

    wall = 2,

    vent_enabled = true,
    vent_walls = ["back"],
    //vent_margin=1,
    pcb_enabled = false,

    show_box = true,
    show_lid = false,
    
    side_hole_diameter = 6.2,
    side_hole_y=15

);
}

//#translate([2,-26,30])
//cube([82,26.4+23 +1.6,5]);