R = 58.6/2;


$fn=100;

module foo() {
 //translate([0,0,25]) cylinder(h=5, r=R+10);

 cylinder(h=25, r=R+4);
 
   translate([0,0,-5]) cylinder(h=5, r=R);  
}




//difference(){
//foo();
//scale([0.95,0.95,1]) foo();
//}


difference(){
cylinder(h=25, r=R+4);
cylinder(h=25, r=R+3);
}

difference(){
cylinder(h=1, r=R+3);
cylinder(h=1, r=R);
}


translate([0,0,-5])
difference(){
cylinder(h=6, r=R);
cylinder(h=6, r=R-1);
}
