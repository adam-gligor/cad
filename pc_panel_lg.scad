length = 150;  // mm 
width = 42.8;



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


module gridlg(){
    stepx=6.14;
    stepy=6;
    grid_height = 2.4;
    difference(){
        cube([length, 4*width, grid_height]);
        union(){
            for (x=[0:stepx:length-2]) 
                for (y=[0:stepy:4*width])
                    translate([x+2,y+2,-2])
                        cube([stepx-0.8,stepy-0.8,5]); 
        }
    }
}


resize(newsize=[length+4-0.8,4*width-1,5+7]) {
    union(){
        difference(){
            union(){
                hull(hooks=false);
                translate([0,width,0])
                    hull(hooks=true);
                translate([0,2*width,0])
                    hull(hooks=true);
                translate([0,3*width,0])
                    hull(hooks=false);
            }
            translate([2,2,0])
            cube([length-4,4*width-4,10]);
        }
        gridlg();
        //gridlg2();
    }
}

// hull(hooks=true);
//grid();
