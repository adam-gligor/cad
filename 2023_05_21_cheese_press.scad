include <threads.scad>;

R = 133/2; //mm
R2= R/2;// inner cylinder radius

$fn=100;


module ring(r1, r2, h){
    
    difference(){
        cylinder(r=r1,h=h);
        cylinder(r=r2,h=h);
    }
}

module mold_press_part() {
    //r = 133/2; //mm ... slightly too big
    r = 116/2; // mm
    t=3; // thichness
    cylinder(r=r, h=t);
//    ring(r1=r,r2=r-t,h=2*t);
//
//
//    for(i=[0:8]) {
//       rotate([0,0,45*i])
//        hull(){
//            translate([0,R2-t,t]) cube([t,t,3*t]);
//            translate([0,r-t-2,t]) cube([t,t,t]);
//        }
//    }
//    
//    //ring(r1=R2,r2=R2-t,h=h2+1);
//   
//    cylinder(r=R2-t+1,h=4*t);

}
//mold_press_part();


module cap2(r){
    
    difference() {
        t = 3;
        cylinder(r=r, h=t);
        
        s = 5;
        for(j=[0:r/s-5]) {
            for(i=[0:36-2*j]) {
                rotate([0,0,360/(36-2*j)*i]) translate([r-j*s-s,0,0]) cube([2,2,10]);
            }
        }
    }
}

//cap(R);

module cheese_press_part(){
 
  difference(){
    union(){
        translate([0,0,5]) cylinder(h=5, r1=20/2, r2=10/2);
        cylinder(h=5, r1=20/2, r2=20/2);
    }
    union(){
        translate([0,0,5])   metric_thread(diameter=6.1,  length=5, internal=true,pitch=1.1 );
        translate([0,0,8])  cylinder(h=2, r1=2, r2=4);
    }
  }
}


//press();


module cheese_press_part2(){

difference(){
cylinder(d=20,h=7);
translate([0,0,5]) cylinder(d=16.5,h=5);
}

translate([0,0,-3])
difference(){
cylinder(r1=5,r2=10,h=3);
cylinder(d=7,h=3);
}

}

//cheese_press_part2();


module spring_cap(){
    difference(){
        cylinder(d=19,h=3);
        union(){
            translate([0,0,1.5]) cylinder(d=16.5,h=1.5);
            translate([0,0,0]) cylinder(d=7,h=1.5);
        }
    }

}

spring_cap();