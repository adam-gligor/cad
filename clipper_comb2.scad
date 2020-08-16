wall = 2;
width = 36;
$fn=50;

module side() {
    translate([0,0,wall]) {
        difference(){
            cube(size=[wall,10,7]);
            translate([0,3,3])
                cube(size=[wall,4,2]);
        }
    }
}


cube(size=[width + 2* wall, 10, wall]);

side();
translate([width+wall,0,0])
    side();

 