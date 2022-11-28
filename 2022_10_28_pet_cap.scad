include <Thread_Library.scad>

//mirror([0,0,180]) 
//makeIt();

RS = 25/2; // mm - outer size of start (fits the car)
H = 55;
$fn=100;
WALL = 4;

//translate([0,0,12])
//difference(){
//    union(){
//        cylinder(r=RS, h=H);
//        cylinder(r1=RS+WALL,r2=RS, h=5);
//    }
//    cylinder(r=RS-3, h=H);
//}
capThread();


module capThread() 
{
    d=27; // thread outer diameter

    length=12;
    pitch=2.7;
    pitchRadius=d/2; 

    tooth_height=1.35;
    cubesize=35;

    difference(){
        cylinder(r=RS+WALL, h=length);
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