$fn=100;

d1 = 32.3;
d2 = 32.6; 
h1 = 20;

x1 = 132;
y1 = 54;



//module b1() {
//hull() {
//    cube([x1,y1,5], center =true);
//    translate([0,0,20])
//    cylinder(d=d1, h=1);
//}
//
//translate([0,0,20])
//cylinder(d=d1, h=10);
//
//}


module b2(offs=0) {

    hull() {
        cube([x1+offs,y1+offs,5], center =true);
        translate([0,0,h1 + offs])
        rotate([0,90,0])
        cylinder(d=d2, h=x1, center=true);
        }

    translate([-x1/2,0,h1+offs/2])
     rotate([0,-90,0])
   cylinder(d1=d1 + offs, d2=d2 + offs, h=h1);

}


//scale([1.002, 1.002, 1]) // 0.2% shrinkage
difference() {
b2(offs=5);
b2(offs=0);
}

