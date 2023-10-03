// rails are 20 x 10


module side_shape(){
    // calculator https://www.calculator.net/right-triangle-calculator.html
    // 30 deg
    // 10 is the thickness everywhere
    y = 120;
    x = 207.8; 
    y1 = 110;
    x1 = 190.5;
    
    //the two sides
    union(){        
        //the top side
        difference(){
            polygon([[0,0], [0, y], [x,0]]);
            polygon([[0,0], [0, y1], [x1,0]]);        
        }
        //the vertical side (start at 5 mm from origin)
        translate([0,5])
        square([10,y-15]);
    }
    //the stopper 
    translate([x,0])
    rotate([0,0,-30])
    translate([-10,0])
    difference(){
        square([10,20]);
        difference(){
            square([10,20]);
            union(){
                square(10,10);
                translate([0,10]) circle(r=10);
            }
        }
    }
    
    //filler
    color("red")
    translate([x-20,0,0])
    polygon([[0,7], [10,0], [20,7]]);
    
}

module piece_one(){
    side_shape();

    translate([0,0,0])
    linear_extrude(height=20)
    side_shape();

//    color("red")
//    translate([3,0,3])
//    cube([10-6,10,20-6]);
}


module shoe(){
    // the leg
    intersection(){
        linear_extrude(height=30)
            polygon([[0,0],[5-1.5,20], [15+1.5,20], [20,0]]);

    
        translate([0,0,30]) rotate([0,90,0])    
            linear_extrude(height=20)
                polygon([[0,0],[5-1.5,20], [25+1.5,20], [30,0]]);
    }

}

module piece_two(){
    
    shoe();
    translate([5,0,5])
    cube([10,20,200]);
    translate([0,0,200])
    shoe();
}


module  full(){
    piece_one();
    translate([0,0,200])
    piece_one();

    translate([-5,0,-5])
    piece_two();
}


rotate([90,0,0])
full();
//translate([0,20,0])
//rotate([90,0,0])
//piece_one();
//piece_two();

