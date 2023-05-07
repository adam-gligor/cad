// m16 pipe 1eu/3m
$fn=100;


module corner_v1(){
    R = 16/2;
    RR =  R + 0.025*(R); // radius of the connected tubes (+5% totals)
    R2 = R + 3.5;
    L1 = R2+5; // part 1, polygon
    L2 = 15; // part2, arms
    
    difference(){
        union(){
            // 4 plates
            hull(){
                translate([0,0,R2]) rotate([0,0,0]) cylinder(h=0.1, r=R2);
                translate([0,0,-R2]) rotate([0,0,0]) cylinder(h=0.1, r=R2);
                translate([L1,0,0]) rotate([0,90,0]) cylinder(h=0.1, r=R2);
                translate([0,L1,0]) rotate([90,0,0]) cylinder(h=0.1, r=R2);
            }
            // legs
            translate([L1,0,0]) rotate([0,90,0]) cylinder(h=L2, r=R2);
            translate([0,L1,0]) rotate([-90,0,0]) cylinder(h=L2, r=R2);
        }
        
        //cutouts
        union(){
            //legs
            translate([0,R2,0]) rotate([-90,0,0]) cylinder(h=L1+L2+1, r=RR);
            translate([R2,0,0]) rotate([0,90,0]) cylinder(h=L1+L2+1, r=RR);
            translate([0,0,-R2+5]) rotate([0,0,0]) cylinder(h=L1+L2+1, r=RR);
            //holes
            translate([0,L1+5,R2-3.3]) rotate([0,0,0]) cylinder(h=3+0.4, r1=1.25,r2=2);
            translate([L1+5,0,R2-3.3]) rotate([0,0,0]) cylinder(h=3+0.4, r1=1.25,r2=2);
            translate([-R2*0.505,-R2*0.505,5/2]) rotate([90+45,90,0])  cylinder(h=3+0.3, r1=1.25,r2=2);
        }
    }

}


//corner_v1();


module corner_v2(){
    R = 13.5/2;
    RR = R- 0.025*(R);
    L1 = RR;
    L2 = 20-RR;
    
    hull(){
        translate([0,0,0]) rotate([0,0,0]) sphere(r=RR);
        translate([0,0,L1]) rotate([0,0,0]) cylinder(h=0.1, r=RR);
        translate([L1,0,0]) rotate([0,90,0]) cylinder(h=0.1, r=RR);
        translate([0,L1,0]) rotate([90,0,0]) cylinder(h=0.1, r=RR);
    }

    translate([0,0,L1]) rotate([0,0,0]) cylinder(h=L2, r=RR);
    translate([L1,0,0]) rotate([0,90,0]) cylinder(h=L2, r=RR);
    translate([0,L1,0]) rotate([-90,0,0]) cylinder(h=L2, r=RR);
    
    translate([0,0,L1+L2]) sphere(r=RR);
    translate([L1+L2,0,0]) sphere(r=RR);
    translate([0,L1+L2,0]) sphere(r=RR);
}

corner_v2();