// big - frame clamp, rng - cable clamp

D_BIG = 41; //mm the frame tube

H_BIG = 3; //mm the frame clamp thickness

D_CAB = 5; //mm shifter cable housing

D_RNG =  10; //mm the diameter of the cable clamp

L_RNG = 12+1; // the length of the cable clamp

L_BIG = D_RNG + 24; // mm len the frame clamp

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


//
difference() {
union() {
    // the tube clamp
    linear_extrude(L_BIG) 
       arc(D_BIG/2, [80-3, 100+3], H_BIG, fn=100);

    // the cable clamp (outer-inner)
    translate([0, D_BIG/2 + D_RNG/2 +1, (L_BIG-L_RNG)/2])
    difference(){
    //color("red"){
        //the outer ring
        cylinder(d=D_RNG, h=L_RNG,$fn=50);
        // the inner ring cutout
        translate([0,0,3]) cylinder(d=D_CAB, h=L_RNG, $fn=50);
        //the cable space cutout .. should be 1mm instead of two
        //TODO: round
        //translate([-1,0,0]) cube([2,10,L_RNG]);
        translate([-1,0,0]) linear_extrude(height=L_RNG) offset(0.5) offset(-0.5) square([2,10]);
    }
}


// the screw cutouts
union() {

SPACE = 6;
R1=6.2/2;
R2=3/2; // can be a bit less
H=3.1;
translate([0,D_BIG/2+H_BIG,SPACE]) rotate([90,0,0])
cylinder( h=H,r1=R1,r2=R2);

translate([0,D_BIG/2+H_BIG,L_BIG-SPACE]) rotate([90,0,0])
cylinder( h=H,r1=R1,r2=R2);
}
}