RS = 25/2; // mm - outer size of start (fits the car)
RE = 28; // mm - outer size of the end
ROFS = 1.4; //mm - wall thickness 

H1=50;
H2=70;
$fn=100;


module cylinder2(r, tx=0, roty=0, h=0.1) {
    rotate([0,roty,0]) 
        linear_extrude(height=h) 
            translate([tx,0])
                circle(r=r);
}


module cylinder3(rs, re, h, ofs=ROFS, roty=0){

    difference(){
        //outer wall
        hull(){
            cylinder2(rs, tx=rs);
            translate([0,0,h]) cylinder2(re,tx=re, roty=roty);
        }
        // innter wall
        hull(){
            cylinder2(rs-ofs, tx=rs);
            translate([0,0,h+0.01]) cylinder2(re-ofs,tx=re, roty=roty);
        }
    }

}

// bottom part
//translate([0,0,-H1]) 
//difference(){
//    cylinder2(RS, tx=RS, h=H1);
//    cylinder2(RS-ROFS, tx=RS, h=H1);
//}
translate([0,0,-H1])
cylinder3(RS,RS, H1);



//filter holder
translate([0,0,-4])
difference(){
    cylinder2(RS, tx=RS, h=2);
    cylinder2(RS-3, tx=RS, h=2);
}


// funel
cylinder3(RS,RE, H2, roty=30);


