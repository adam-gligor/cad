D = 30; 
D2 = 11;
H = 3.4;

$fn=100;

translate([0,0,0]) 

difference(){
    translate([D/2,D/2,0])
    hull(){
        //translate([0,0,0])cylinder(h=H,d=D);
        //translate([D/2,0,0]) cylinder(h=H,d=D);
        //translate([0,0,0]) cylinder(h=H,d=10);
        //translate([D+D/3,0,0]) cylinder(h=H,d=10);
        //translate([0,D,0]) cylinder(h=H,d=10);
        //translate([D+D/3,D,0]) cylinder(h=H,d=10);

          translate([0,0,0]) cylinder(h=H,d=D+6);
          translate([D/3,0,0]) cylinder(h=H,d=D+6);
        
    }

    translate([D/2,D/2,-2])
    union(){
        hull(){
          translate([0,0,0]) cylinder(h=H,d=D);
          translate([D/3,0,0]) cylinder(h=H,d=D);
        }


        
        hull(){
          translate([0,0,0]) cylinder(h=H+10,d=D2);
          translate([D/3,0,0]) cylinder(h=H+10,d=D2);
        }
    }
}