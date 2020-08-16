//h = 77; + 2mm base

$fn = 100;

// cell 18.5 * 4 = 74
// 19 x 75 

module myshape(l, w) {
    w_half = w/2;
    l_half = l/2;
    union() {
        square(size=[l - w, w], center=true);

        
            translate([w_half - l_half, 0, 0])
                circle(d=w);

            translate([-w_half + l_half, 0, 0])
                circle(d=w);
        
    }
}



// base
linear_extrude(height=2)
    myshape(76, 20);

// side
linear_extrude(height=77 +2)
    difference(){
         myshape(80, 23); // 80 ok
         myshape(76, 20); // 76 ok
    }