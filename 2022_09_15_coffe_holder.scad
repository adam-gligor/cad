R = 58.6/2;


$fn=100;

module foo() {
 translate([0,0,25]) cylinder(h=5, r=R+10);

 cylinder(h=25, r1=R, r2=R+10);
 
   translate([0,0,-5]) cylinder(h=5, r=R);  
}




difference(){
foo();
scale([0.95,0.95,1]) foo();
}


