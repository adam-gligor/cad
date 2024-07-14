
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

// enforcement
rotate([0,0,45])
difference(){
    intersection(){
         difference() {
             union(){
                translate([0,0,h/2]) cube([d1,2,h], center=true);
                translate([0,0,h/2]) rotate([0,0,90]) cube([d1,2,h], center=true);
                cylinder(d=d3+2, h = h);
            }
            
            cylinder(d=d3, h = h);

        }
        cylinder(d1=d1, d2=d2, h = h);
    }
    union(){
        cylinder(d1=d1-4, d2=d2-4, h = h-10);
        //translate([0,0,h-2]) cylinder(d1=d3, d2=d2-2,h=2);
    }
}

//cap

translate([0,0,h-3]) 
difference(){
    cylinder(d1=d3+2, d2=d2,h=3);
    cylinder(d1=d3, d2=d2-2,h=3);
}