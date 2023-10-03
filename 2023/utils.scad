
module tube(r1, r2, h ){
    difference() {
        cylinder(r=r1, h=h);
        cylinder(r=r2, h=h);
    }
}

module taperout(r,h) {
    intersection(){
        cylinder(r=r, h=h);
        cube([r,r,h]);
    }
}

module taperin(r,h) {
    difference(){
        cube([r,r,h]);
        cylinder(r=r, h=h);
    }
}

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

//linear_extrude(1) arc(radius, angles, width);


//tube(20,10,10);

// taperout(10,10);

 //taperin(10,10);