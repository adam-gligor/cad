
x = 21;
y = 1.8;
z = 8;
$fn=50;

intersection(){
cube([x,y,z]);
translate([x/2,y,z/2]) rotate([90,0,0]) cylinder(d=x,h=y);
}


x1 = 4;
y1 = y+10;
z1 = 7;
translate([(x-x1)/2,0,0]) cube([x1,y1,z1]);

//tip
translate([(x-x1)/2,y1,z1/2]) rotate([0,90,0]) cylinder(d=z1,h=x1);


//back
difference(){

x2 = 5.2;
y2 = 5.4-2;
z2 = z1;

x3 = x2+2*1.6;
y3 = y2+1.6 + 2;
z3 = z1;

translate([(x-x3)/2,-y3,0]) cube([x3,y3,z3]);

translate([(x-x2)/2,-y2-2,0]) cube([x2,y2,z2]);

}

