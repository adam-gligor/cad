


translate([5+2,0,0])
  difference() {
    cube([30-5-2,5+2,50]);
    translate([0,1,1]) cube([50,5,50]);
  }



translate([5+2,0,0])
rotate([0,0,90])
    difference() {
      cube([30,5+2,50]);
      translate([0,1,1]) cube([50,5,50]);
    }
//
color("red")   
translate([0,5+2,0])
rotate([0,0,-90])
    difference() {
      cube([30,5+2,50]);
      translate([0,1,1]) cube([50,5,50]);
    }



//cylinder(r=1,h=50, $fn=50);
//translate([7,7,0])
//cylinder(r=1,h=50, $fn=50);

translate([7,-4,0])
linear_extrude(height=50)
polygon(points=[[0,0],[0,4],[4,4]]);

translate([7,3,0])
linear_extrude(height=50)
polygon(points=[[0,8],[0,4],[4,4]]);