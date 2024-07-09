$fn=100;
// cross should be less 
//difference(){
//cylinder(h=2,d=10);
//
//cylinder(h=2,d=7);
//}
//
//translate([0,0,1]) cube([2,10-1,2], center=true);


// part 1

module donut(d1, d2, h, center = false) {
    difference(){
        cylinder(h=h,d=d1, center=center);
        cylinder(h=h,d=d2, center=center);
    }
}

// base

donut(22, 13, 1);

// side
translate([0,0,0])
donut(24, 21.5, 9+1);

// inner part 
translate([0,0,0])
difference(){
cylinder(h=6, d1=15,d2=9.4);

cylinder(h=6, d1=15-2,d2=9.6-2);
}

//inside washer 

donut(20, 13, 1.5);


// cross bar 

translate([0,0,5]) cube([1.6,10-0.7,2], center=true);

//zero point

translate([11.4,0,9.6]) rotate([0,-90,0]) cylinder(d=2, h = (24-21.5)/2 - 0.1, center=true,$fn=3);