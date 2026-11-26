use <baita_centrala_v2_rcv.scad>


enclosure(

    length = 82,
    width = 21 +2,
    height = 30,

    wall = 2,

    vent_enabled = true,
    vent_wall = "back",

    pcb_enabled = true,

    show_box = true,
    show_lid = false

);

translate([0,-28,0])
enclosure(

    length = 51,
    width = 26,
    height = 30,

    wall = 2,

    vent_enabled = false,
    vent_wall = "back",

    pcb_enabled = true,

    show_box = true,
    show_lid = false

);



translate([0,-28,0])
enclosure(

    length = 82,
    width = 26,
    height = 30,

    wall = 2,

    vent_enabled = false,
    vent_wall = "back",

    pcb_enabled = false,

    show_box = true,
    show_lid = false

);