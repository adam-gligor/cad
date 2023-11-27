X = 2800; // 2.8m
Y = 1800; // 1.8m
Z = 2500; //2.5m

module room() {
//floor 

color([0.9,0.9,0.9]) { 
cube([X, Y, 1]);
cube ([1,Y, Z]);
translate([0,Y,0]) cube ([X,1, Z]);
    

// door 
translate([X,0,0]) 
        difference(){
        cube ([1,Y, Z]);
        translate ([-1,100,0]) cube ([10,900, 2000]);
        }

}

// shower glass
GX = 1000;
color([99/255, 227/255, 225/255, 0.3]) 
translate([900,Y-GX,0]) cube ([1,GX, 2000]);

MX = 1800;
MY = 150;
MZ = 1200;
color([0.9,0.9,0.9]) {
    
// mask 130 x 1800 x 1200

//translate([X-MX,Y-MY,0]) cube([MX,MY,MZ]);

// water mask

M2X = 1000;
M2Y = 150;
M2Z = 2500;
translate([900,Y-M2Y,0]) cube([M2X,M2Y,M2Z]);
}

// sink

SX = 900;
SY = 550+150; //700
SZ = 900;
translate([1900,Y-SY,0]) 
sink(SX,SY,SZ);

//wc

WX = 600;
WY = 150;
WZ = 1100;

WX1=380;
WY1 = 550;
WZ1 = 400;

translate([1100, Y-WY-1,0]) {
cube([WX,WY,WZ]);
translate([100,-WY1,0]) cube([WX1,WY1,WZ1]);
}

// cabinet 

//CX = 600;
CY = 150;
CZ = 600;
translate([X-SX,Y-CY,900+300]) 
{
    cube([SX,CY,CZ]);
    color([99/255, 227/255, 225/255, 0.3]) 
    translate([25,-2,25])cube([SX-50,1,CZ-50]);
}

}


module sink(x,y,z){
    //cube([x,y,z]);
    
    sr = 50; 
    sz = 100;
    
    // legs 
    translate([50,100,0]) cylinder(d=50,h=800);
    translate([x-50,y-50,0]) cylinder(d=50,h=800);
    translate([50,y-50,0]) cylinder(d=50,h=800);
    translate([x-50,100,0]) cylinder(d=50,h=800);
    // body 
    
    translate([0,50,100]) cube([x,y-50,30]);
    
    translate([0,50,400]) cube([x,y-50,30]);
    
    // top
    difference(){
        translate([0,0,z-sz*1.2])
        cube([x,y,sz*1.2]);
        
        translate([0,0,z-sz])
        minkowski(){
        translate([sr,sr,0])cylinder(r=sr,h=sz);
        translate([sr,sr,0])cube([600-2*sr,400-2*sr,sz]);
        }
    }
    
}

//sink(900,700,900);
room();