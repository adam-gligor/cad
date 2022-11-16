RS = 25/2; // mm - outer size of start (fits the car)
RE = 28; // mm - outer size of the end
ROFS = 1.2; //mm - wall thickness 

H1=50;
H2=70;
$fn=100;


module cylinder2(r, tx=0, roty=0, h=0.1) {
    rotate([0,roty,0]) 
        linear_extrude(height=h) 
            translate([tx,0])
                circle(r=r);
}


module cylinder3(rs, re, h, ofs=ROFS, ofe=ROFS, roty=0){
    difference(){
        //outer wall
        hull(){
            cylinder2(rs, tx=rs);
            translate([0,0,h]) cylinder2(re,tx=re, roty=roty);
        }
        // innter wall
        hull(){
            cylinder2(rs-ofs, tx=rs);
            translate([0,0,h+0.01]) cylinder2(re-ofe,tx=re, roty=roty);
        }
    }

}

module funel(){
    // bottom part
    translate([0,0,-H1]) 
    difference(){
        cylinder2(RS, tx=RS, h=H1);
        cylinder2(RS-ROFS, tx=RS, h=H1);
    }

    // filter holder
    translate([0,0,-5]) {
    cylinder3(RS,RS,2, ofe=ROFS+1.4);
    translate([0,0,+2])
    cylinder3(RS,RS,1, ofs=ROFS+1.4, ofe=ROFS+1.4);
    }

    // funel
    cylinder3(RS,RE, H2, roty=30);
}


module filter(){
    hf = 1.2;
    rf = RS-ROFS-0.4; // <=RS
    
    //
    //translate([RS,0,0]) cylinder(r=0.5,h=2);
    
    //rim
    color("red")
    translate([RS,0,0])
    difference(){
        cylinder(r=rf,h=hf+0.8);
        cylinder(r=rf-1, h=hf+0.8);
    }

    
    difference(){
        //pattern
        translate([0,-RS,0])
        union(){
            for (x =[0:4:2*RS]){
                translate([0,x,0]) cube([2*RS,1,hf]);
                translate([x,0,0]) cube([1,2*RS,hf]);
            }
        }

        //mask
        difference(){
            translate([0,-RS,0]) cube([2*RS,2*RS,hf]);
            translate([RS,0,0]) cylinder(r=rf,h=hf);
        }
    }
}

//funel();
//translate([0,0,-2])
filter();