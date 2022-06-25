D1 = 24.4;
D2 = 17;
D3 =7;

H1 = 15;


$fn=100;

module xxx(){
    hull(){
        translate([0,-D2/2,H2-1]) cube([1,D2,1]);
        translate([0,-D2/2-0.5,0]) cube([1,D2+1,0.01]);
        
    }
}

module torus(){
    rotate_extrude(angle=360, $fn=100) translate([-20.5,H1/2])  circle(d=20);
}

difference(){

    union(){    
        cylinder(d=D1, h=H1);
        
       // translate([0,0,H1]) cylinder(d=D2, h=H2);
        
        //translate([0,0,H1]) xxx();
        
        //translate([0,0,H1]) rotate([0,0,90]) xxx();
    }

    union(){
      cylinder(d=D3, h=H1);
      torus();
      translate([-1, -D3/2 - 2, 0]) cube([2, D3+4, H1]);
      rotate([0,0,90]) translate([-1, -D3/2 - 2, 0]) cube([2, D3+4, H1]);
    }
}

//rotate([0,90])
