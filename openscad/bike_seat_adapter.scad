// 298 / 2 = 149
// 286 / 2 = 143
// 272 / 2 = 136
$fn = 50;


// 14.9 - 13.6 = 1.3  

difference(){
    union(){
        translate([0,0, -35]){
            //bottom wide cylinder
            // could be wider ...
            // 17 too narrow
            // try 19 ...
            cylinder(r=18.5, h= 2.0 , center=false);
        }
        // outer cylinder
        // +0.0 too little
        // +0.5 too much
        // +0.2 tight fit
        cylinder(r=14.9 + 0.2, h= 70.0, center=true); 
    }
    
    // inner tube + cutout
    union(){ 
        cylinder(r=13.6 + 0.1, h= 80.1, center=true); // pad for smoothness
        translate([12,0,0]){
            // gap can be bigger, ex. 4
            cube(size=[15,3,81], center=true);
        }   
    }
}

// bottom section
//difference(){
//    cylinder(r=18, h= 1 , center=false);
//    translate([0,0,-1]){
//        cylinder(r=13.65, h= 12, center=false);
//    }
//    translate([12,0,-1]){
//        cube(size=[10,3,100], center=false);
//    }
//}

