
  difference() {
    cube([30,5+2,50]);
    translate([5+2,1,1]) cube([50,5,50]);
  }


color("red")
translate([5+2,0,0])
rotate([0,0,90])
    difference() {
      cube([30,5+2,50]);
      translate([5+2,1,1]) cube([50,5,50]);
    }

translate([7,7,0])
linear_extrude(height=50)
polygon(points=[[0,0],[4,0],[0,4]]);