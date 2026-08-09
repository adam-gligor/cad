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


module back_pad_v1(){


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
    
    //height 
    h1 = 8;
    h2 = 3;

    difference(){
        union(){
            //%cube([x,y,5]);
            m1(x,y,h2);
            translate([(x-x1)/2,(y-y1)/2,0]) m1(x1,y1,h1);
        }
        translate([(x-x2)/2,(y-y2)/2,h2])  m1(x2,y2,h1-h2);
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
}

module back_pad_v2(){
    
    x0 = 40.5 + 1;
    y0 = 31 + 1;
    offs = 5;
    h = 3;
    
    difference(){
    hull(){
        hull(){
        translate([0,0,0]) cylinder(r=offs, h = h); 
        translate([x0,0,0]) cylinder(r=offs, h = h); 
        translate([0,y0,0]) cylinder(r=offs, h = h); 
        translate([x0,y0,0]) cylinder(r=offs, h = h); 
        }
        
        hull(){
        h2 = 2*h;
        r2 = 3;
        translate([0,0,0]) cylinder(r=r2, h = h2); 
        translate([x0,0,0]) cylinder(r=r2, h = h2); 
        translate([0,y0,0]) cylinder(r=r2, h = h2); 
        translate([x0,y0,0]) cylinder(r=r2, h = h2); 
        }
    }
    
    translate([0,0,h]) cube([x0,y0,h]);
   }
    
}

back_pad_v2();
//front_pad1();

//front_pad2();