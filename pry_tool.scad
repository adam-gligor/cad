module shape1(){
    X=200;
    Y=2.5;
    X1=4;
    Y1=4.5;
    Z=12;

    //Y + Y1 <= 7
    
    translate([0,-Y/2,-Z/2])
    linear_extrude(height=Z)
    polygon([
        [0,0],[X,0],
        [X+2,Y],[X-X1,Y+Y1], [X-X1-X1,Y+Y1],
        [X-X1,Y],[0,Y]
        ]
    );
}

module shape2(){
    Y=50;
    Z=12;
    scale([0.5,1,1])
    translate([2,0,0])
    rotate([90,0,0])
    cylinder(h=Y,d=Z, center=true);
}

module shape3(){
    Z=4;
    linear_extrude(height=Z, center=true)
    polygon([
        [0,-20], [6,0], [0,20]
    ]);
}

shape1();
shape2();
shape3();