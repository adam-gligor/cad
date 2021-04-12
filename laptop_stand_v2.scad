
// inputs
angle=35; 
length = 190; 
width = 200;

//calculated from `angle` anf `length` using
//see: https://www.calculator.net/right-triangle-calculator.html
height = 133;

//tweaks
//note: thicknesses 20x10
thick_1 = 10;
thick_2 = 20;

// leg settings
leg_offs_x1 = 5; // bottom offset
leg_offs_x2 = 3; // top offset

module upper_shape() {
    
    difference(){
        hull() {
            offset(thick_1)
            offset(-thick_1)
            polygon([[0,0], [0, height], [length,0]]);
            
            square([0.001,0.001]);
            translate([length,0])
            square([0.001,0.001]);
        }
        
        offs = thick_1/sin(90-angle);
    
        hull(){
        
            offset(thick_1)
            offset(-2*thick_1)
            polygon([[0,0], [0, height], [length,0]]);

            translate([thick_1,-offs])
            square([0.001,0.001]);
            translate([length,-offs])
            square([0.001,0.001]);
        }
    }
    
    //the front stopper

    translate([length -thick_1,0])

    union(){
        translate([0,thick_1*1.5]){
            corner_shape(type=0, r=thick_1);
        }
        square([thick_1,thick_1*1.5]);
        translate([-0.5*thick_1,0])
            square([0.5*thick_1,thick_1]);
        
    }

}

module upper_shape_old() {

    //the top section
    //note: need to get a triagle with `height`=offset1     
    offs = thick_1/sin(90-angle);
    difference(){
        polygon([[0,0], [0, height], [length,0]]);
            translate([0, -offs])
        polygon([[0,0], [0, height], [length,0]]);
    }
    
    //the side section (start at 5 mm from origin)
    translate([0,5])
    square([thick_1,height-thick_1-5]);
    
    //the front stopper
    translate([length,0])
    rotate([0,0,-angle])
    translate([-thick_1,-0.0001]) //note: not closed shape otherwise
    union(){
        translate([0,thick_1])
            corner_shape(type=0, r=thick_1);
        square([thick_1,thick_1]);
        
        rotate([0,0,90])
            corner_shape(type=1, r=thick_1);
    }

 
}

module upper_part(){
    linear_extrude(height=thick_2)
        upper_shape();
}

module corner_shape(type, r){
    if (type == 0){
        intersection(){
            square([r,r]);
            circle(r=r, $fn=50);    
        }
    }
    if (type == 1){
        difference(){
            square([r,r]);
            translate([r,r])
            circle(r=r,$fn=50);                
        }
    }
}


module leg_part(){
    
    y = thick_2; // the 2d height
    x1 = thick_1 + 2* leg_offs_x1; // 2d total len for thinner shape   
    x2 = thick_2 + 2* leg_offs_x1; // 2d total len for thicker shape
    
    difference(){
        translate([0,x2,0])
        rotate([90,0,0])
        intersection(){
            //the thinner piece
            linear_extrude(height=x2)
            polygon([[0,0],[leg_offs_x2,y], [x1-leg_offs_x2,y], [x1,0]]);

            //the thicker piece
            translate([0,0,x2])
            rotate([0,90,0])
            linear_extrude(height=x1)
            polygon([[0,0],[leg_offs_x2,y], [x2-leg_offs_x2,y], [x2,0]]);
        }

        //the cutout
        //todo: use offset command!
        // note: printer specific , 0.4 is too big
        spacer = 0.2;    
        translate([leg_offs_x1-spacer,leg_offs_x1-spacer,5])
        cube([thick_1+2*spacer, thick_2+2*spacer,thick_2]);
    }
}

module lower_part(){
    leg_width=thick_2+2*leg_offs_x1;
    
    //one leg
    leg_part();
    
    //the other leg
    translate([0,width-leg_width,0])
    leg_part();
  
    //the cross beam
    translate([leg_offs_x1, leg_width-leg_offs_x2, 0])
    cube([thick_1, width - 2* (leg_width - leg_offs_x2), thick_2]);
    
}


module demo(){
    
    lower_part();
    
    translate([leg_offs_x1,thick_2+leg_offs_x1,0])
    rotate([90,0,0])
    upper_part();
    
    translate([leg_offs_x1,width-leg_offs_x1,0])
    rotate([90,0,0])
    upper_part();
}



//try 1
//cube([20,  thick_2, thick_1]);
//translate([-2,-2,0])
//cube([2,24,10]);

// try 2
//intersection(){
//translate([170,0,0]) cube([40,30,10]);
//
//upper_part();
//}

//try 3
//leg_part();


upper_shape();
//demo();
//lower_part();
//upper_part();