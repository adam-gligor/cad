length = 150 - 0.8; // mm - 0.4
width = 42.8 - 0.8; // -0.4
height = 5;

module hull(hooks){
    translate([length/2, width/2 , 0]) {
        translate([0, 0, 2.5])
            difference() {
                cube([length,width,5], center= true);
                cube([length-4,width-4,5], center= true);
            }

        if (hooks) {
            translate([length/2-1, 0, 4]){
                cube ([2, 10 , 8], center = true);
                translate([1,0,6])
                    cube ([4, 10 , 4], center = true);
            }


            translate([-length/2+1, 0, 4]){
                cube ([2, 10 , 8], center = true);
                translate([-1,0,6])
                    cube ([4, 10 , 4], center = true);
            }
        }
    }
}

module grid(){
    stepx = 5.61;
    stepy=5;
    difference(){
        cube([length, width, 1]);
        union(){
            for (x=[0:stepx:length]) 
                for (y=[0:stepy:width])
                    translate([x+2,y+2,-2])
                        cube([stepx-0.6,stepy-0.6,4]); 
        }
}
}
 hull(hooks=true);
//difference(){
//    union(){
//        hull(hooks=true);
//        translate([0,width,0])
//            hull(hooks=false);
//        translate([0,2*width,0])
//            hull(hooks=false);
//        translate([0,3*width,0])
//            hull(hooks=true);
//    }
//    translate([2,2,0])
//    cube([length-4,4*width-4,10]);
//}
grid();
