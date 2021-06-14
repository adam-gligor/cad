// A customizable laptop stand 


// Module naming convenitions:
//  - xxx_shape is a 2D shape 
//  - xxx_part is a 3D part
//  - the stand is made of one `lower_rail_part` and two `upper_rail_part`s
//  - the upper rail's front section, that stops the laptop from falling is called the `tip`
//  - the lower rail's section for inserting the upper rail is called `shoe`  


//Input parameters:

ANGLE=45; // the angle
LENGTH = 170; //the total length of the base
WIDTH = 200; //the total width of the base

//side of the triangle calculated from the other side and an angle
HEIGHT = sqrt((LENGTH*LENGTH*sin(ANGLE)*sin(ANGLE))/(1-sin(ANGLE)*sin(ANGLE)));

echo(HEIGHT);
echo(sqrt(LENGTH*LENGTH+HEIGHT*HEIGHT));


//Parameters to tweak:

//the size of the rails
THICK1 = 10;
THICK2 = 20;

//offsets for the socket
SHOE_OFFS1 = 5;
SHOE_OFFS2 = 3;
SHOE_SPACER = 0.2;

//extra height for the tip section
TIP_OFFS = 2; 


module upper_rail_shape() {
    
    difference(){
        hull(){
            offset(THICK1/5, $fn=50)
            offset(-THICK1/5)
                polygon([[0,0], [0,HEIGHT], [LENGTH,0]]);
            
            square([0.001,0.001]);
            translate([LENGTH,0])
                square([0.001,0.001]);
        }
        
        //the side of the triangle having height=THICK1
        OFFS = THICK1/sin(90-ANGLE);
        
        hull(){    
            offset(THICK1,, $fn=50)
            offset(-2*THICK1)
            polygon([[0,0], [0,HEIGHT], [LENGTH, 0]]);

            translate([THICK1,-OFFS])
            square([0.001,0.001]);
            translate([LENGTH,-OFFS])
            square([0.001,0.001]);
        }
        //5 mm shorter for the shoe 
        square([THICK1,5]);
    }
    
    translate([LENGTH,0])
    rotate(-ANGLE)
    translate([-THICK1,0])
    tip_shape();
}


module tip_shape(){
    union(){
        //the lower rounding
        translate([-THICK1,0])
        difference(){
            square([THICK1, THICK1]);
            translate([0, THICK1]) circle(r=THICK1, $fn=50);
        }

        // the upper rounding
        translate([0,THICK1+TIP_OFFS])
        intersection(){
            square([THICK1, THICK1]);
            circle(r=THICK1, $fn=50);
        }
        
        square([THICK1,THICK1+TIP_OFFS]);
    }
}


module upper_rail_part(){
    linear_extrude(height=THICK2)
        upper_rail_shape();
}


module shoe_part(){
    translate([SHOE_OFFS1,SHOE_OFFS1])
    difference(){
        hull(){
           translate([-SHOE_OFFS1,-SHOE_OFFS1,0])
           scale([(THICK1+2*SHOE_OFFS1)/THICK1, (THICK2+2*SHOE_OFFS1)/THICK2,1])
           cube([THICK1,THICK2,0.001]);

           translate([-SHOE_OFFS2,-SHOE_OFFS2, THICK2])
           scale([(THICK1+2*SHOE_OFFS2)/THICK1, (THICK2+2*SHOE_OFFS2)/THICK2,1])
           cube([THICK1,THICK2,0.001]);
       }
       
       //the cutout + 0.2 spacer
       translate([0,0,5])
       scale([(THICK1+2*SHOE_SPACER)/THICK1, (THICK2+2*SHOE_SPACER)/THICK2,1])
       cube([THICK1,THICK2,THICK2]);
    }
}

module lower_rail_part(){
    
    SHOE_WIDTH = THICK2+2*SHOE_OFFS1;
    
    shoe_part();    
    translate([0, WIDTH-SHOE_WIDTH])
        shoe_part();
    
    //the cross rail
    translate([SHOE_OFFS1, SHOE_WIDTH-SHOE_OFFS2, 0])
    cube([THICK1, WIDTH - 2* (SHOE_WIDTH - SHOE_OFFS2), THICK2]);
}

module demo() {
    
    lower_rail_part();
    
    translate([SHOE_OFFS1,THICK2+SHOE_OFFS1,0])
    rotate([90,0,0])
    upper_rail_part();
    
    translate([SHOE_OFFS1,WIDTH-SHOE_OFFS1,0])
    rotate([90,0,0])
    upper_rail_part();
}


//uncomment here to print the parts
upper_rail_part();
//lower_rail_part();

//demo();