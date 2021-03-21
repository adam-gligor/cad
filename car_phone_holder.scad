
sphere(d=14, $fn=100);

//rotate([-90,0,0])
//translate([0,0,5])
//cube([8,8,10], center=true);
//sphere(d=14, $fn=100;);

//polygon([[-6,0], [6,0], [5,40], [3,40], [3,8], [-4,40]]);

module shape(){
    polygon([[0,0],[6,12], [4,50], [2,50], [3,13], [0,10]]);
}


translate([0,0,-4])
linear_extrude(height = 8) {
    shape();
    mirror([1,0,0]) 
    shape();
}
