//X1 = 23.5;
//X2 = 2.5;

X1 = 0;
X2 = 2.5;
X3 = 23.5 + 2.5;
X4 = 23.5 + 2 * 2.5;

Y1 = 0;
Y2 = 10;
Y3 = 20;

module corner(){
    intersection(){
        square([2.5,2.5]);
        circle(r=2.5, $fn=50);
    }
}


linear_extrude(height=20)

union(){
    polygon([
        [X1,Y1], [X4,Y1], [X4,Y3], [X3,Y3], [X3,Y2], [X2,Y2],
        [X2,Y2], [X2,Y3], [X1,Y3]
    ]);


    translate([X2,Y3])
    mirror([1,0])
    corner();

    translate([X3,Y3])
    corner();
}

