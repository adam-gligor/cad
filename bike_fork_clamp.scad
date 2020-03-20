d_inner=36.4;
w=3;
h=10;

d_outer=2*w+d_inner;
r_outer=d_outer/2;
r_inner = d_inner/2;

mount = 5;

difference(){
  linear_extrude(height=h){
    difference(){
      circle(d=d_outer);
      circle(d=d_inner);
    }
  }


  translate([0-50,-20,-1]){ // adj here
    cube([40,40,12], center=false);
  }
}

translate([r_inner,-mount/2,0])
cube([mount+5,mount,h],center=false);