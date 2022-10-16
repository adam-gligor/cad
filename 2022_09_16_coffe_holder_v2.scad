R0 = 58.6/2;
R01 = R0-1.2;

//R0 = 70/2 + 1.2;
//R =70/2;
//R2 = 67/2;
R1 = R0 + 4;
R11 = R1 - 1.2;


$fn=100;


difference(){
cylinder(h=25, r=R1);
cylinder(h=25, r1=R01, r2=R11);
}


//difference(){
//cylinder(h=1, r=R+3);
//cylinder(h=1, r=R);
//}


//bottom insert
translate([0,0,-5])
difference(){
cylinder(h=6, r=R0);
cylinder(h=6, r=R01);
}
