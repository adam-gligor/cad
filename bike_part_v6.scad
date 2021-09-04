module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

module support() {
    // the piece that bolts on the frame tube

    DIA = 41; // the bicycle frame tube
    THK = 3; // the thickness of the piece 
    LEN = 34; // 37 the length of the piece
    WDT = 10; 
    
    difference() {  
        //the plate
        intersection() {
            //the arc
            translate([0,0,-DIA/2]) rotate([90,0,90]) 
            linear_extrude(LEN) arc(DIA/2, [75, 105], THK, fn=100);
            
            //the rounding
            translate([0,-WDT/2,-THK]) linear_extrude(height=THK*2) 
                offset(r=2,$fn=20) offset(r=-2,$fn=20) square([LEN, WDT]);
            
        }
        //the crew holes    
        R2 = 3.1; 
        R1 = 1.1;
        H = 3.1 ;
        OFS = 6; //offset of hole from the edge
    
        union(){
            //color("red") {
            translate([OFS,0, -0.1]) 
            cylinder(h=H,r1=R1,r2=R2, $fn=20);

            translate([LEN-OFS,0, -0.1])
            cylinder(h=H,r1=R1,r2=R2, $fn=20);
        }
    }
}


module stopper() {
    // the cable stopper

    LEN = 12+1; // mm length
    D1 = 5; // mm inner ring diam
    D2 = 10; // mm outer ring diam
    CCT = 1.5; // mm bowden cutout
    
    translate([0,0,0]) rotate([90,0,90])
    difference(){
    //color("red"){
        union() {
            //the outer ring
            cylinder(d=D2, h=LEN,$fn=50);
            // the lower stright part
            translate([-D2/2,-D2/2,0]) cube([D2,D2/2, LEN]);
        }
        // the inner ring 
        translate([0,0,3]) cylinder(d=D1, h=LEN, $fn=50);
        //the bowden cutout
        translate([-CCT/2,0,0]) linear_extrude(height=LEN) 
        offset(0.5) offset(-0.5) square([CCT,LEN]);
    }    
}


support();
translate([(34-13)/2,0,6])
stopper(); 

