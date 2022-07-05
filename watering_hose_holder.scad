$fn=100;

WIDTH = 13;
THICK = 2;
DHOLE = 8;


//translate([0,0,90])
//difference(){
//cube([10,10,10]);
//translate([0,1.5, 1.5]) cube([10,7,7]);
//}


module foo(){
 
difference(){
    
    hull(){
        cylinder(d=WIDTH, h=DHOLE*1.5);
        translate([0,0,-.5*WIDTH]) cube([WIDTH,THICK, 1], center=true);
    }
    translate([0,0,0.75* DHOLE]) union(){
        translate([-WIDTH/2, 0, 0])    
        rotate([0,90,0]) cylinder(d=DHOLE, h=WIDTH);
        translate([0, WIDTH/2,0]) 
        rotate([90,0,0]) cylinder(d=DHOLE, h=WIDTH);
    }
}
}

module foo2(){
    
    difference() {
    rotate([0,90,0]) union(){
        cylinder(d=WIDTH, h=DHOLE+THICK, center=true);
        translate([0,WIDTH/4,0]) 
        cube([WIDTH, WIDTH/2, DHOLE+THICK], center=true);

    }
    union(){
        translate([-WIDTH/2, 0, 0])    
        rotate([0,90,0]) cylinder(d=DHOLE, h=WIDTH);
        translate([0, WIDTH/2,0]) 
        rotate([90,0,0]) cylinder(d=DHOLE, h=WIDTH);
    }
}

}

module foo3i(){
     rotate([0,90,0])
       difference(){
        union(){
            cylinder(d=DHOLE+2*THICK, h=WIDTH, center=true);
            translate([0,WIDTH/4,0]) 
            cube([DHOLE+2*THICK, WIDTH/2, WIDTH], center=true);
        }
        
       union(){
            // inner
            cylinder(d=DHOLE, h=WIDTH, center=true);
            translate([0,WIDTH/4,0]) 
            cube([DHOLE, WIDTH/2, WIDTH], center=true);

//        translate([0, WIDTH/2,0]) 
//        rotate([90,0,0]) cylinder(d=DHOLE, h=WIDTH);

        }
    }

}

module foo3(){
    
    difference(){
    // outer 
     foo3i();
        translate([0, WIDTH/2,0]) 
        rotate([90,0,0]) cylinder(d=DHOLE, h=WIDTH);
    }

}

foo3i();
cube([WIDTH,THICK, 96]);
//
cube([WIDTH,60, THICK]);
//
translate([0,0,100]) //foo();

foo3();