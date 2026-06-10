$fn=100;

module front_pad1() {
x = 45;
y = 70;
h = 10;

xs = 38; 
ys = 32;


difference(){
    
hull(){
r = 2;
translate([r,r,0]) cylinder(r=r,h=h);
translate([x-r,r,0]) cylinder(r=r,h=h);
translate([r,y-r,0])cylinder(r=r,h=h);
translate([x-r,y-r,0])cylinder(r=r,h=h);
}


union (){
r1 = 3;
ofsx = 27;
ofsy= 17;


translate([(x-ofsx)/2,ofsy,-1]) {
    cylinder(r=r1, h=h+10);
    translate([ofsx,0,0]) cylinder(r=r1, h=h+10);
}


ofsx2 = 24;
ofsy2= 51;

translate([(x-ofsx2)/2,ofsy2,-1]) {
    cylinder(r=r1, h=h+10);
    translate([ofsx2,0,0]) cylinder(r=r1, h=h+10);
}
}
}

} 


module front_pad2() {

d1 = 61;
d2 = 49;

difference(){
cylinder(d=d1,h=3);
cylinder(d=d2,h=2);
}
}

//front_pad1();

front_pad2();