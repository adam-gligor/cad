//D1 = 24.5;
//D2 = 17;
//D3 =7;
//
//H1 = 20;
//H2 = 10;
D1 = 24.8;
D2 = 17;
D3 =7;

H1 = 5;
H2 = 5;

$fn=100;


difference(){

union(){    
cylinder(d=D1, h=H1);
translate([0,0,H1]) cylinder(d=D2, h=H2);
}

cylinder(d=D3, h=H1+H2);

}
