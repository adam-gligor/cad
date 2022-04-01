d1=6.1;
d2=14;
$fn = 50;

difference(){

union() {
    difference(){
      cylinder(d=d2, h=10);
      cylinder(d=d1, h=10);
      translate([0,-d1/2, 0]) cube([d2,d1, 10]);
    }


    intersection(){
        cylinder(d=d2, h=10);
        difference(){
          translate([0,-d1/2+0.2, 0]) cube([d2,d1-0.4, 10]);
          cylinder(d=d1, h=10);
        }
    }

}

union(){
    translate([0,0,10-1.5])
    cylinder(h=3, d1=d1, d2=d2, center=true);
    
    cylinder(h=3, d1=d1, d2=d2, center=true);
}

}
