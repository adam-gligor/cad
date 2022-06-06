// 26.5 .. inner diam
// 1.5mm

D = 26.5;
R = D/2;
$fn=100;
//module shape()
//    polygon([[0,0], [R,0], [R, 15], [2*R , 2*R],[2*R , 2*R + 5], [0, 2*R + 5] ]);
//
//
//
////difference(){
//shape();
//color("red"){
//    //translate([-1.2,00]) 
//    scale([1,1.03]) 
//    shape();
//}
////}

//cylinder(d=D, h=10);
//
//hull(){
//
//translate([0,0, 10]) cylinder(d=D, h=0.1);
//
//translate([0,0, 20]) cylinder(d=1.4*D, h=5);
//
//}

diameter = 1.5*D;
linear_extrude(1)
    difference() {
        circle(d = diameter);
        
        for(j = [1:1:5])
        for(i = [0 :6+ j*6: 360 ])
          rotate(i)
            translate([20-3*j, 0])
              circle(d = 2.4);
 
    }