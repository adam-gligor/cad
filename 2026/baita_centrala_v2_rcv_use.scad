use <baita_centrala_v2_rcv.scad>


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
    vent_walls = ["back", "right", "front"],

    pcb_enabled = true,
    pcb_height  = 4+8,

    show_box = true,
    show_lid = false

);



translate([53,-28-0.4,0])
enclosure(

    length = 82-51-2,
    width =26.4 ,
    height = 30,

    wall = 2,

    vent_enabled = true,
     vent_walls = ["back", "left"],

    pcb_enabled = false,

    show_box = true,
    show_lid = false

);