
//module prism(l, w, h){
//   polyhedron( 
//    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
//    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
//   );
//}



//104

thick = 1;

// horizontal
//1
cube([104,10,thick]);
//2
translate([0,10,0])
    cube([31, 35, thick]);


//vertical
//1.1
translate([0,10-thick,0])
    cube([104, thick, 12]);
//1.2
cube([104, thick, 12]);
//1.3
translate([0,45-thick,0])
    cube([31, thick, 12]);

//2.1
translate([31-thick,0,0])
    cube([thick,45,12]);
//2.2
cube([thick,45,12]);
//2.3
translate([104-thick,0,0])
    cube([thick,10,12]);


//top


translate([0,0,11])
    cube([104,15,thick]);
 translate([0,10,11])
    cube([31, 35, thick]);
