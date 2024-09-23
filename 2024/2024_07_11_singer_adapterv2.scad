
$fn=50;
d1 = 34;
d2 = 26;
d3 = 7;
h = 40;

module holder() {

    intersection(){
        union(){
            rotate([0,0,0]) translate([d3/2,-1,0]) cube([d1/2,2,h]);

            rotate([0,0,90]) translate([d3/2,-1,0]) cube([d1/2,2,h]);

            rotate([0,0,-90]) translate([d3/2,-1,0]) cube([d1/2,2,h]);

            rotate([0,0,180]) translate([d3/2,-1,0]) cube([d1/2,2,h]);

            difference(){
                cylinder(d=d3+4, h = h);
                cylinder(d=d3, h = h);
            }
        }
        cylinder(d1=d1, d2=d2, h=h);
    }
}

module base(){
    d = 44;
    
    difference(){
        union(){
            translate([0,0,1]) cylinder(d=d, h=1);
            
            translate([0,0,-1]) cylinder(d=d3+4,h=1);
            cylinder(d1=d-2, d2=d, h=1);
            

        }
        
        union(){
            //cutouts
            translate([-d * 1.2,0,0]) scale([1.9, 0.8, 1]) cylinder(d=d,h=2);
            translate([ d * 1.2,0,0]) scale([1.9, 0.8, 1]) cylinder(d=d,h=2);
            translate([0 ,-d * 1.2,0]) scale([0.8, 1.9, 1]) cylinder(d=d,h=2);
            translate([0,d * 1.2, 0]) scale([0.8, 1.9, 1]) cylinder(d=d,h=2);
            //lower rest
            translate([0,0,-1]) cylinder(d=d3,h=2+1);

            //cutouts
            translate([0,0,1]) cylinder(d=d3+6,h=1);
            for(i = [0:1])
            rotate([0,0,45 + 90*i])
            union() {
                translate([-1.5,-d/2,1]) cube([2+1,d,1]);
                //translate([-3-1,-d/2,2]) cube([2,d,1]);
            }
        }
    }
    

}

module foot() {

    d = 20;
    
    difference() {
        union(){
            cylinder(d1=d, d2=d+2,h=1);
            translate([0,0,1]) cylinder(d1=d+2, d2=d+2,h=1);
            cylinder(d=d,h=4);
        }
         //cylinder(d=d-5,h=1);
    }
}

foot();

//translate([0,0,2])  rotate([0,0,45]) holder();
// base();