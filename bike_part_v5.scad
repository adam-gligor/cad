D_BIG = 41; //mm the frame tube

H_BIG = 3; //mm the frameclamp thickness

D_CAB = 5; //mm shifter cable housing

D_RNG =  10; //mm the diameter of the piece

L_RNG = 12; // the length of the  piece



module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

difference() {
union() {
    // the tube clamp
    linear_extrude(L_RNG + 10) arc(D_BIG/2, [70, 110], H_BIG, fn=100);

    // the ring
    translate([0, D_BIG/2 + D_RNG/2 +0.5, 5])
    difference(){
        cylinder(d=D_RNG, h=L_RNG,$fn=50);

        translate([0,0,3]) cylinder(d=D_CAB, h=L_RNG, $fn=50);

        translate([-1,0,0])cube([2,10,L_RNG]);
    }
}

rotate([0,0,25]) translate([-D_RNG/2, D_BIG/2 -2 , 5]) cube([D_RNG,D_RNG,L_RNG]);
}