RS = 25/2; // mm - outer size of start (fits the car)
RE = 28; // mm - outer size of the end
WL = 1.4; //mm - default wall thickness 

H1=55;
H2=70;
$fn=100;


module cyl2(r, rot=[0,0,0], trans=[0,0,0]) {
    rotate(rot) 
        linear_extrude(height=0.1) 
            translate(trans)
                circle(r=r);
}


//makes a tube between a and b
module tube(
ra, // first radius  
rb, // second radius
h, // height
wa = WL, // wall thickness at a
wb= WL, // wall thickness at b
rota=[0,0,0], transa=[0,0,0], // rotate and translate a
rotb=[0,0,0], transb=[0,0,0], // rotate and translate b
){

    difference(){
        //outer
        hull(){
            cyl2(ra, rota, transa);
            translate([0,0,h]) cyl2(rb, rotb, transb);
        }
        // innter
        hull(){
            translate([0,0,-0.0001]) cyl2(ra-wa, rota, transa);
            translate([0,0,h+0.0001]) cyl2(rb-wb, rotb, transb);
        }
    }
}


// demo
//tube(ra=10, rb=10,h=10);
//tube(ra=10, rb=10,h=10, rota=[-20,-20,0],rotb=[20,20,0]);
//tube(ra=20, rb=10,h=10, wb=3, transb=[0,-10,0]); //ra-rb

module filter() {
    color("red")
    tube(ra=RS+2-2*WL,rb=RS+2-2*WL, wa=2,wb=2, h=1.6);
}


module funel(){
    // bottom part
    translate([0,0,-H1]) tube(ra=RS,rb=RS,wa=2*WL,wb=2*WL, h=H1);

    
    //middle part 
 
    translate([0,0,-3]) tube(ra=RS, rb=RS+2, wa=2*WL, wb=3*WL, h=3);

    
    // top part
    tube(ra=RS+2,rb=RE, wa=2*WL, h=H2, rotb=[0,30,0], transb=[RE-RS-4,0,0]);
}


funel();

//translate([0,0,-2.5]) 
//filter();