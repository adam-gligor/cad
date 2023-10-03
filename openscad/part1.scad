
/*------------------Customizer View-------------------*/
 
// preview[view:north, tilt:top]
 
/*---------------------Parameters---------------------*/
 
//board width in mm
board_width         =   75; //[1:1:500]
 
//board height in mm
board_height        =   75 ; //[1:1:500]
 
//board thickness in mm
board_thick         =     3; //[1:0.5:10]
 
//hole offset (1 inch or 25.6mm is standard)
hole_offset         =    25.60;//[10:0.1:30]
 
//hole diamiter (standard is 1/4 inch or 6.25mm)
hole_dia            =     6.25; //[5:0.25:8]
 
//Peg height for export 
hole_height         =     6.0; //[1:1:30]
 
//chamfer of of the board corners (will add to width)
chamfer             =     3; //[1:0.5:5]
 
//Pegboard = 1 Pegs Only = 0
type                =     1; //[0:1:1]
 
//roll dia in mm
roll_dia            =     36;
 
//slot width in mm
slot_width          =      5;
 
/*-----------------------Execute----------------------*/
 
main_module();
 
/*-----------------------Modules----------------------*/
 
module main_module(){ //create module
    difference() {
            union() {//start union
                
                    translate ([0,0,0]) rotate ([0,0,0]) board_module(board_width,board_height,board_thick,hole_offset,hole_dia,hole_height,chamfer,type);
                
                //create base
            translate ([((board_width/2)-((board_width-(round((board_width-(hole_offset-(hole_dia/2)))/hole_offset))*hole_offset)/2)),(-(hole_offset+chamfer)/2),(roll_dia/2)-(board_thick/2)]) rotate ([0,0,0]) bottom_holder (board_width,roll_dia,slot_width);
                //bottom_holder (board_width,roll_dia,slot_width);
                
                
            } //end union
 
    
     } //end difference
         
} //end module
           
 
module board_module(board_widtha,board_heighta,board_thicka,hole_offseta,hole_diaa,hole_heighta,chamfera,typea){ //create module
    difference() {
            union() {//start union
                
 
    if (type ==1) {
                    translate ([((board_widtha/2)-((board_widtha-(round((board_widtha-(hole_offseta-(hole_diaa/2)))/hole_offseta))*hole_offseta)/2)),((board_heighta/2)-((board_heighta-(round((board_heighta-(hole_offseta-(hole_diaa/2)))/hole_offseta))*hole_offseta)/2)),0]) rotate ([0,0,0]) rounded(board_widtha,board_heighta,board_thicka,chamfera,true);
                }else{
                    for (i=[0:round((board_widtha-(hole_offseta-(hole_diaa/2)))/                        hole_offseta)])
                                for (j=[0:round((board_heighta-(hole_offseta-(hole_diaa/2)))/                            hole_offseta)])translate ([i*hole_offseta,j*hole_offseta,0]) rotate ([0,0,0]) cylinder(hole_heighta,hole_diaa/2,hole_diaa/2,$fn=60,true);
 
            }; //end if union if tstaement
                
                        
                    } //end union
                            
    //start subtraction of difference
                     if (type ==1) {
                            for (i=[0:round((board_widtha-hole_offseta)/                        hole_offseta)])
                                for (j=[0:round((board_heighta-hole_offseta)/                            hole_offseta)])
                                    
                                {translate ([i*hole_offseta,j*hole_offseta,0]) rotate ([0,0,0]) cylinder(hole_heighta,hole_diaa/2,hole_diaa/2,$fn=60,true);
                   }
                                    
                }
             else{
 
 
                }; //end of diff if statement
                                               
    } //end difference
}//end module
 
module rounded(x,y,z,c,center) {
 
    // c = Chamfer amount this will add (in mm) to each axis
    
     //create overlapping cubes
        //cube one overlapps in the X axis with chamfer "c" being doubled
        cube ([x+(c*2),y,z],true);
        //cube two overlapps in the Y axis with chamfer "c" being doubled
        cube ([x,y+(c*2),z],true);
     //end overlapping cubes
        
     //create corner circles
        translate ([-(x/2),-(y/2),0]) { cube([c*2,c*2,z],true);
        }
        translate ([-(x/2),(y/2),0]) { cylinder( z,c,c,$fn=60,true);
        }
        translate ([(x/2),-(y/2),0]) { cube([c*2,c*2,z],true);
        }
        translate ([(x/2),(y/2),0]) { cylinder( z,c,c,$fn=60,true);
        }
     //end coner circle
    
} //end module
 
module bottom_holder (roll_w,roll_t,slot_w) {
        difference() {
                union() {//start union
                    
                translate ([0,0,0]) rotate ([0,90,0]) cylinder(roll_w+(chamfer*2),roll_t/2,roll_t/2,$fn=60,true);
                    
                } //end union
                translate ([0,roll_t/2,0]) rotate ([0,0,0]) cube([roll_w+(chamfer*4),roll_t,roll_t],true);
                translate ([0,3,0]) rotate ([0,90,0]) cylinder(roll_w+1,roll_t/2,roll_t/2,$fn=60,true);
                translate ([0,-(roll_t/2),0]) rotate ([0,0,0]) cube([roll_w,roll_t,slot_w],true);
    
         } //end difference
         
} //end module
           
/*----------------------End Code----------------------*/