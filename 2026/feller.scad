

module foo(){
h = 1.2; // mm
w = 2; //mm wall

x = 9+w;
y = 10;
cube([x+w,y,w]);

translate([0,0, w + 2*h]) cube([x,y,w]);

translate([x,0,w+h]) cube([w, y, w+h+10]);

cube([w, y,w + 2*h]);
    
}


// baita screw mask 
module bar(){
    
    d1 = 5;
    d2= 9.5;
    d3= d2+4;
    h1=3;
    h2=4;
    
    module x() {
//        translate([0,0,h1]) cylinder(d=d2,h=5);
        cylinder(d1=d1,d2=d2,h=h1);
    }
    
    difference(){
       
        hull(){
        translate([0,0,h2/2]) cylinder(d=d3,h=h2,center=true);
        translate([0,0,4]) cylinder(d=d3-6,h=h2-2,center=true);
        }
        
        hull(){
            x();
            translate([10,0,0]) x();
        }
    }
}


bar();



