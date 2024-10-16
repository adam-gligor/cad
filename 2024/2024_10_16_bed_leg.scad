//x = 31.5; //mm
//y = 41.5; //mm

$fn =50;

//d1 = y + 15;
//cylinder(d=d1, h= 5);


//module m1(x,y,z) {
//    minkowski(){
//        cube([x,y,z], center=true);
//        sphere(d=z);
//    }
//}


//difference(){
//hull(){
//    m1(x+10,y+10,5);
//    translate([0,0,15]) m1(x+5,y+5,5);
//}
//
//translate([0,0,15]) cube([x,y,20], center=true);
//}

//translate([0,0,-5]) cube([5,5,25]);


// v2 
//
//x= 34;
//y= 27;
//
//x1 = 34+5;
//y1 = 27+5;
//
//difference(){
//union(){
//m1(x1,y1,3);
//
//translate([0,0,4]) m1(x-3,y-3,3); 
////cube([x,y,10], center=true);
//}
//
//translate([0,0,-1]) m1(x-25,y-25,15);  // cylinder(d=x-15, h=20);
//}


// outer dim
x0 = 41.5;
y0 = 31;

// inner dim
x1 = 34;
y1= 27;


//base dim
x = x0+8;
y = y0+8;

// hole dim 

x2 = x1-10;
y2 = y1-10;

difference(){

union(){
//%cube([x,y,5]);
m1(x,y,3);


translate([(x-x1)/2,(y-y1)/2,0]) m1(x1,y1,6);
}


translate([(x-x2)/2,(y-y2)/2,0])  m1(x2,y2,6);

}

module m1(x,y,z) {
d = 5;

hull(){
translate([d/2,d/2,0]) cylinder(d=d,h=z);
translate([d/2,y-d/2,0]) cylinder(d=d,h=z);

translate([x-d/2,d/2,0]) cylinder(d=d,h=z);
translate([x-d/2,y-d/2,0]) cylinder(d=d,h=z);
}
}

