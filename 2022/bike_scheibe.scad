Z1= 2.5;
Z2 = 1.5;

D1 = 18;
D2 = 7;
$fn=100;


difference(){
    
    
    
    union(){

        intersection(){
            cylinder(d=D1, h=Z1+Z2);
            translate([-1.5,-1.5,0])
            cube([D1,D1, Z1+Z2]);
        }
        cylinder(d=D1, h=Z2);
    }
    cylinder(d=D2, h=Z1+Z2);
}

