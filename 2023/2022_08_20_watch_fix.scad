
A=22.8;// 
B=6;
H=10;

module stopper(){
   //3x3 
    rotate([0,90,0])
    linear_extrude(height=3, center=true)
    polygon([[0,0], [3,0], [2,1.2], [1,1.2]]);
}

// main body
linear_extrude(height=H)
difference(){
    minkowski(){
        square([A,B]);
        circle(r=1.5, $fn=120); // can adjut r 1..1.5
    }//stopper();
    square([A,B]);
}

// small piece to prevent it from sliding
translate([A/2,0,H/2+1.5])
 stopper();