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
    show_lid = false

);

translate([0,-28-0.4,0])
enclosure(

    length = 51,
    width = 26.4,
    height = 30,

    wall = 2,

    vent_enabled = true,
    vent_walls = [ "right", "front"],
    

    pcb_enabled = true,
    pcb_height  = 4+8,

    show_box = true,
    show_lid = false

);



translate([0,-28-0.4,0])
enclosure(

    length = 82,
    width =26.4 ,
    height = 30,

    wall = 2,

    vent_enabled = true,
    vent_walls = ["back", "left"],
    //vent_margin=1,
    pcb_enabled = false,

    show_box = true,
    show_lid = false

);
}

//translate([2,-26,30])
//cube([82,26.4+23,5]);