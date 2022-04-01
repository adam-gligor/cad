d1=6.1;
d2=14;
$fn = 50;


difference() {
    difference(){
      union(){
        translate([0,0,5]) cylinder(d=d2, h=5);
        cylinder(h=5, d1=d1+1, d2=d2);
      }

      cylinder(d=d1, h=10);

      translate([0,0,10-1.5])
      cylinder(h=3, d1=d1, d2=d2, center=true);
    }

 // cutouts
  difference(){
    color("red") {
      translate([0,-d1/2, 0]) cube([d2,d1, 10]);
    }

    color("blue") {
      translate([0,-d1/2+0.2, 0]) cube([d2,d1-0.4, 10]);
    }
  }

}