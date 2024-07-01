// 298 / 2 = 149
// 286 / 2 = 143
// 272 / 2 = 136
$fn = 100;


// 14.9 - 13.6 = 1.3  

h = 60; // mm
d = 27.2;
do = 30.2;

d1 = d + 0.00 * d;
d2 = do + 0.00 * do;
echo(d1);
echo(d2);
difference(){
    
        cylinder(d=d2, h= h); 
        
        union() {
            cylinder(d=d1, h= h); 
            translate([d2-d1,0,h/2]) cube(size=[d2,4,h], center=true);
        }
        
    
//    // inner tube + cutout
//    union(){ 
//        cylinder(r=13.6 + 0.1, h= 80.1, center=true); // pad for smoothness
//        translate([12,0,0]){
//            // gap can be bigger, ex. 4
//            cube(size=[15,3,81], center=true);
//        }   
//    }
}

