$fn=100;

module donut(d1, d2, h, center = false) {
    difference(){
        cylinder(h=h,d=d1, center=center);
        cylinder(h=h,d=d2, center=center);
    }
}

module v1() {
    // base

    donut(22, 13, 1);

    // sidetranslate([0,0,0])
    donut(24, 21.5, 9+1);

    // inner part 
    translate([0,0,0])
    difference(){
    cylinder(h=6, d1=15,d2=9.4);

    cylinder(h=6, d1=15-2,d2=9.6-2);
    }

    //inside washer 

    donut(24, 19.5, 2);


    // cross bar 

    translate([0,0,5]) cube([1.6,10-0.7,2], center=true);

    //zero point

    translate([11.4,0,9.6]) rotate([0,-90,0]) cylinder(d=2, h = (24-21.5)/2 - 0.1, center=true,$fn=3);
}

module v2(){
    
    do = 24; // cylinder outer diameter
    di = 21.5; // cylinder innter diameter
    h = 9+1; // cylinder height +1 for the base
    
 
    //inside washer    
    dwi = 19.5; // inner diameter of the washer 
    donut(do, 19.5, 2);
    

    d21 = 15; // the bigger cone, bottom diameter
    d22 = 9.4;  // the bigger cone, top diameter
    d2h = 6; // the bigger cone height
    d2o = 2; // wall thickness as diameter difference
    
    // the inner cone
    difference(){
        cylinder(h=d2h, d1=d21 ,d2=d22);
        cylinder(h=d2h, d1=d21-d2o, d2=d22-d2o);
    }
    
    // cross stopper
    tx = 1.6 + 0.2; // thichmentss of the stoopper, was 1.6 initially
    translate([0,0,5]) cube([tx,d22-0.1,2], center=true);
    
    // the base 
    donut(do, d21-1, 1);
    
    // the side
    donut(do, di, h);
    
    // zero point indicator
    translate([do/2-0.1,0,h/2]) 
    cylinder(d=3, h = h, center=true,$fn=3);
 
    
}

//v1();

v2();