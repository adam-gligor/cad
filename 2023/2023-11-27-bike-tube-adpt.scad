D1 = 27.2 + 0.1; //mm
D2 = 30.8 + 0.1; // mm
H = 80; //mm

$fn=100;


rotate([00,90,0]) 
difference() {
    union(){
        cylinder(h=H, d=D2);
        cylinder(h=3, d=D2+2);
    }
    union(){    
       cylinder(h=H, d=D1);
       translate([-D2/2-10,-1.5,0]) cube([D2/2,3,H]);
    }
}


