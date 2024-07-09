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

module donut(d1, d2, h) {
    difference(){
        cylinder(h=h,d=d1);
        cylinder(h=h,d=d2);
    }
}

// base

donut(22, 13, 1);

// side
%translate([0,0,1])
donut(24, 21.4, 9);

// inner part 
translate([0,0,0])
difference(){
cylinder(h=6, d1=15,d2=9.4);

cylinder(h=6, d1=15-2,d2=9.6-2);
}

// cross bar 

translate([0,0,5]) cube([1.6,10-0.7,2], center=true);