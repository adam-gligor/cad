
R0 =70/2;
R1 = 60/2; 


$fn=100;


difference(){
cylinder(h=20, r1=R0+1.2, r2=R0+1.2);
cylinder(h=20, r1=R1, r2=R0);
}



//bottom insert
translate([0,0,-4])
difference(){
cylinder(h=4, r=R0 + 1.2);

cylinder(h=4, r=R0);

}
