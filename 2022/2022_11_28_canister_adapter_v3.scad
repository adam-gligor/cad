include <Thread_Library.scad>


RS = 25/2; // mm - outer size of start (fits the car)
H = 55;
$fn=100;
WALL = 3;


tube();
 
//ring();

capThread();


module tube(){
translate([0,0,10])
difference(){
    union(){
        cylinder(r=RS, h=H);
        cylinder(r1=RS+WALL+1.4,r2=RS, h=5);
    }
    cylinder(r=RS-3, h=H);
}
}

module capThread() 
{
    d=27; // thread outer diameter

    length=10;
    pitch=2.7;
    pitchRadius=d/2; 

    tooth_height=1.35;
    cubesize=35;

    difference(){
        cylinder(r=RS+WALL+1.4, h=length);
        union(){
            cylinder(r1=RS+WALL-1,r2=RS+WALL-3, h=3);
            trapezoidThread
            (
                length=length,
                pitch=pitch,
                pitchRadius=pitchRadius,
                threadHeightToPitch=tooth_height/pitch,
                profileRatio=0.4,
                threadAngle=20, 
                RH=true,
                clearance=0.1,
                backlash=0.0,
                stepsPerTurn=48
                //showVertices=false
            );
        }
    }
}

module ring(){
    d = 24.5;
    r = d/2;
    h = 1.4;
    translate([0,0,10-h])
    color("red"){
        difference(){
            cylinder(r=r, h=h);
            cylinder(r=r-WALL, h=h);
        }
    }
}