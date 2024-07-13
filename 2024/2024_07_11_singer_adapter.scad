
$fn=100;
d1 = 33;
d2 = 22;
d3 = 7;
h = 40;


//outer cylinder, with cutiot
difference() {
    difference(){
        cylinder(d1=d1, d2=d2, h = h);
        cylinder(d1=d1-2, d2=d2-2, h = h);
    }

    intersection(){
        hc=0.75*h;
        translate([0,0,hc/2]) union(){
            cube([d1,5,hc], center=true);
            rotate([0,0,90]) cube([d1,5,hc], center=true);    
        
        }
    }
}

// inner cylinder
translate([0,0,h/2]) 
difference(){
    cylinder(d1=d3+2, d2=d2, h=h/2);
    cylinder(d1=d3, d2=d2-2, h=h/2);
}

// enforcement 
 rotate([0,0,945]) difference() { 
    
    intersection(){       
        cylinder(d1=d1, d2=d2, h = h);
        translate([0,0,h/2]) union(){
            cube([d1,2,h], center=true);
            rotate([0,0,90]) cube([d1,2,h], center=true);    
        }
    }
    
    union() {
    cylinder(d1=d1-4, d2=d2-8, h = h);
    
    translate([0,0,h/2]) cylinder(d1=d3, d2=d2-2, h=h/2);
    }
    
   // translate([0,0,h/2]) cylinder(d1=d3+2, d2=d2, h=h/2);
}
    


