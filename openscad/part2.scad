
/*------------------Customizer View-------------------*/
// preview[view:north, tilt:top]
 
 
/*---------------------Parameters---------------------*/
 
// Seperation of Motor Mounting Bolts(mm) NEMA11 = 23 NEMA14 = 26 NEMA17 = 31 NEMA23 = 47.1 NEMA34 = 69.6  NEMA42 = 110
Hole_Seperation = 47.1; //[23:0.1:115]
// Stantion Height (mm) 
Stantion_Height = 27; //[3:1:40]
// Stantion Diameter (mm)
Stantion_Dia = 11; //[5:1:18]
// Bolt Ope Dia (mm) NEMA11 = 2.5 NEMA14 = 3 NEMA17 = 3 NEMA23 = 5.5 NEMA34 = 5.5  NEMA42 = 8.5
Bolt_Dia = 5.5; //[2.5:0.1:10]
// Shaft Opening (mm)
Main_Opening_Dia = 30; //[20:1:70]
// Plate Thickness (mm)
Plate_Height = 4; //[3:1:8]
 
/*-----------------------Execute----------------------*/
 
 create_plate ();
 
 
/*-----------------------Modules----------------------*/
 
module create_plate () {
    
    difference(){
        
        union() {
            
        //top hole 1
       translate ([-(Hole_Seperation/2),-(Hole_Seperation/2),(Stantion_Height/2)]) { cylinder( Stantion_Height,Stantion_Dia/2,Stantion_Dia/2,$fn=60,true);
        }
        //bottom hole 2
        translate ([(Hole_Seperation/2),(Hole_Seperation/2),(Stantion_Height/2)]) { cylinder( Stantion_Height,Stantion_Dia/2,Stantion_Dia/2,$fn=60,true);
        }
        //top hole 2
        translate ([(Hole_Seperation/2),-(Hole_Seperation/2),(Stantion_Height/2)]) { cylinder( Stantion_Height,Stantion_Dia/2,Stantion_Dia/2,$fn=60,true);
        }
        //bottom hole 1
        translate ([-(Hole_Seperation/2),(Hole_Seperation/2),(Stantion_Height/2)]) { cylinder( Stantion_Height,Stantion_Dia/2,Stantion_Dia/2,$fn=60,true);
        }
        
        //create overlapping cubes
        translate([0,0,(Plate_Height/2)]) cube ([Hole_Seperation+(Stantion_Dia*2),Hole_Seperation,Plate_Height],true);
        translate([0,0,(Plate_Height/2)]) cube ([Hole_Seperation,Hole_Seperation+(Stantion_Dia*2),Plate_Height],true);
        //end overlapping cubes
        
        //create corner circles
        translate ([-(Hole_Seperation/2),-(Hole_Seperation/2),(Plate_Height/2)]) { cylinder( Plate_Height,Stantion_Dia,Stantion_Dia,$fn=60,true);
        }
        translate ([-(Hole_Seperation/2),(Hole_Seperation/2),(Plate_Height/2)]) { cylinder( Plate_Height,Stantion_Dia,Stantion_Dia,$fn=60,true);
        }
        translate ([(Hole_Seperation/2),-(Hole_Seperation/2),(Plate_Height/2)]) { cylinder( Plate_Height,Stantion_Dia,Stantion_Dia,$fn=60,true);
        }
        translate ([(Hole_Seperation/2),(Hole_Seperation/2),(Plate_Height/2)]) { cylinder( Plate_Height,Stantion_Dia,Stantion_Dia,$fn=60,true);
        }
        //end coner circle
            
        //create supports
        translate ([(Hole_Seperation/48),(Hole_Seperation/2),(Stantion_Height/4)]) { cube([ Hole_Seperation,Stantion_Dia/2,Stantion_Height/2],true);
        }
        translate ([(Hole_Seperation/48),-(Hole_Seperation/2),(Stantion_Height/4)]) { cube([ Hole_Seperation,Stantion_Dia/2,Stantion_Height/2],true);
        }
        translate ([(Hole_Seperation/2),(Hole_Seperation/48),(Stantion_Height/4)]) { rotate ([0,0,90]) cube([ Hole_Seperation,Stantion_Dia/2,Stantion_Height/2],true);
        }
        translate ([-(Hole_Seperation/2),(Hole_Seperation/48),(Stantion_Height/4)]) { rotate ([0,0,90]) cube([ Hole_Seperation,Stantion_Dia/2,Stantion_Height/2],true);
        }
        //end create supports 
    } //end union
    
    //start hole removal
        translate ([-(Hole_Seperation/2),-(Hole_Seperation/2),Stantion_Height/2]) { cylinder( Stantion_Height+5,Bolt_Dia/2,Bolt_Dia/2,$fn=60,true);
        }
        //bottom hole 2
        translate ([(Hole_Seperation/2),(Hole_Seperation/2),Stantion_Height/2]) { cylinder( Stantion_Height+5,Bolt_Dia/2,Bolt_Dia/2,$fn=60,true);
        }
        //top hole 1
        translate ([(Hole_Seperation/2),-(Hole_Seperation/2),Stantion_Height/2]) { cylinder( Stantion_Height+5,Bolt_Dia/2,Bolt_Dia/2,$fn=60,true);
        }
        //top hole 2
        translate ([-(Hole_Seperation/2),(Hole_Seperation/2),Stantion_Height/2]) { cylinder( Stantion_Height+5,Bolt_Dia/2,Bolt_Dia/2,$fn=60,true);
        } 
        
     //tapper supports
       translate ([0,0,(Hole_Seperation/3)+Plate_Height]) {rotate ([0,90,0])  cylinder( Hole_Seperation*2,Hole_Seperation/3,Hole_Seperation/3,$fn=60,true);
       }
       translate ([0,0,(Hole_Seperation/3)+Plate_Height]) {rotate ([90,0,0])  cylinder( Hole_Seperation*2,Hole_Seperation/3,Hole_Seperation/3,$fn=60,true);
       }
    //end tappered supports
    
    //remove center hole with added if/else error checking
     if (Main_Opening_Dia<Hole_Seperation) {  
        cylinder( Plate_Height+5,Main_Opening_Dia/2,Main_Opening_Dia/2,$fn=60,true);
     }
     else
     {
         cylinder( Plate_Height+5,Hole_Seperation/2,Hole_Seperation/2,$fn=60,true);
     }//end if
         
    //end remove center hole  
    
    } //end differance
}
 
/*----------------------End Code----------------------*/