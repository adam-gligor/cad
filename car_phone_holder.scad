
sphere(d=15, $fn=100);

//rotate([-90,0,0])
//translate([0,0,5])
//cube([8,8,10], center=true);
//sphere(d=14, $fn=100;);

//polygon([[-6,0], [6,0], [5,40], [3,40], [3,8], [-4,40]]);

module shape(){
    polygon([[0,0],[4,8], [4,50], [2,50], [2,13], [0,13]]);
}


translate([0,-3,-4])
linear_extrude(height = 8) {
    shape();
    mirror([1,0,0]) 
    shape();
}

//shape();

translate([0,-(15/2)-1.5+1.2,0])
cube([10.5,3,10.5], center=true);

translate([0,-5,0])
cube([10.5,5,10.5], center=true);