// oven rail  25 x 15

THICK = 3;


module shape(x1, x2, y) {
    // x1 - opened x part 
    // x2 - closed x part
    // x total = x1 + x2
    difference(){

        offset(delta=THICK, $fn=50)
            square([x1 + x2 , y ]);

        union(){    
            square([x1 + x2 , y ]);
            square([x1 , y + THICK ]);
        }
    }
}

linear_extrude(height=10)
offset(r=1.2,  $fn=50) offset(r=-1.2,  $fn=50)
union(){
    //bigger C
    shape(25, 10, 15);

    //smaller C
    rotate([0,0,180])
    translate([THICK,-15,0])
    shape(10, 5, 15);
}