DOUTER = 25; // mm
ROUTER= DOUTER/2;

$fn=100;

module v1(){
difference(){
union(){
cylinder(h=70, r1=15, r2=80/2, center=false);
 
translate([0,0,-50]) cylinder(h=70, r=25/2, center=false);
}
rotate([30,0,0])translate([0,20,90]) cube([100,100,100], center=true);

}

cylinder(h=5, r=15, center=true);

}

module v2(){
    
    h1=30;
    // https://www.calculator.net/right-triangle-calculator.html
    h2 = 50;
    r1 = ROUTER + 8.81635; // correspoding to triangle with 80 deg 
    // means the cylibder will have to be roted with 10 deg (90-80)

    union(){
        cylinder(h=h1, r=ROUTER, center=false);
        hull(){
            cylinder(h=0.1, r=ROUTER, center=false);
            rotate([0,10,0]) translate([0,0,-h2-3]) 
                cylinder(h=h2, r1=r1, r2=ROUTER, center=false);
        }
    }
}


//rotate([0,90,0])


difference() {
difference(){
    v2();
    scale([0.9,0.9,1]) v2();
}

translate([0,0,-164]) rotate([0,30,0]) cube([200,200,200], center=true);
}