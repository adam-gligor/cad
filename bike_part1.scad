$fn = 100;

module part1() {
    difference() {
        cylinder(d=5.8, h=20);
        cylinder(d=5, h=20);
    }
}



module part3(){

    D1=41;
    d1=6; //6.4
    d2=9.6;
    h=1;
    
    difference(){
        union() {
            color("red") {
            rotate([0,0,45])
            rotate_extrude(angle = 90) 
                translate([20.5, 0, 00]) 
                    square(size = [ 10+1,1]);
            
           translate([-D1/2,0,0])
           cube([D1,D1/2, 1]);
           }
       }
       union(){
           color("green") {
           cylinder(d=D1,h=1);
           
           translate([-D1/2-10 + 4,0,0])
           cube([10,D1, 1]);
           
           translate([D1/2 - 4,0,0])
           cube([10,D1, 1]);
           

            rotate([0,0,0]) translate([0,D1/2+d2/2,0])
                cylinder(d=d2,h=1);
            rotate([0,0,-25]) translate([0,D1/2+d2/2,0])
                cylinder(d=d2, h=1);
            
            rotate([0,0,25]) translate([0,D1/2+d2/2,0])
                cylinder(d=d2, h=1);
           }
           
       }        
   }

}

part1();

