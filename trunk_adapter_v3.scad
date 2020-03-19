w=140;
h=140;

linear_extrude(height=25, center=false){
  difference(){
    translate([5,5,0]) {
      minkowski(){
        square(size=[w-5,h-5]);
        circle(r=5);
      }
    }

    gap=5;
    color("red"){
      for(i=[0:3])
        for(j=[0:3])
          translate([w/4*i+gap,w/4*j+gap,0])
            square(size=[w/4-gap,h/4-gap]);
    }
  }
}