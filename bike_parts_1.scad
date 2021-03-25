
//tube diameters
D1=41; // original
D11= 41-4;//

//small hole diameters
d1=5;
d2=6;
d3=10;
//d33 = d3+ 4;
$fn=50;
Z= 0.1;


//difference() {
    color("red")
    cylinder(d=D1+2*d3, h=1);

    union() {
        //tube diameter
        cylinder(d=D1, h=1);
        
        //bottom bound 
        translate([-(D1/2), -(D1/2),0])
        cube([D1, D1/2, 1]);

        //left bound
        translate([-(D1/2)-d3,-(D1/2),0])
            cube([d3, D1*2, 1]);

        //right bound
        translate([D1/2,-D1/2,0])
            cube([d3, D1*2, 1]);
        


        //3 holes
        
        rotate([0,0,-24])
        translate([0,D1/2+d3/2,0])
        cylinder(d=d1, h=1);
        
        translate([0,D1/2+d3/2,0])
        cylinder(d=d1, h=1);

        rotate([0,0,24])
        translate([0,D1/2+d3/2,0])
        cylinder(d=d3, h=1);

    }
//}