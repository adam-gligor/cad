include <Polygon.scad>;
$fn=100;
module shape() {
    difference(){
        union() {
            translate([4, 4, 0])
                circle(d=8);
            translate([4, 12, 0])
                circle(d=8);
            translate([12, 4, 0])
                circle(d=8);
            translate([12, 12, 0])
                circle(d=8);
            translate([2,2,0])
                square(size=[12, 12]);
        }
        union(){
            translate([-6, 8, 0])
                circle(d=16);
            translate([22, 8, 0])
                circle(d=16);
            translate([8, -6, 0])
                circle(d=16);
            translate([8, 22, 0])
                circle(d=16);   
            translate([8,8,0])
                circle(d=5.5);
        }
    }
}

difference(){
    linear_extrude(height=8)
        shape();

    linear_extrude(height=4)
        translate([8,8,4])
            Hexagon(R=4.7);
}
        

//translate([8,8,0])
//color("red")
//     Hexagon(R=4.7);



