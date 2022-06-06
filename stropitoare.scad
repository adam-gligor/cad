// 26.5 .. inner diam
// 1.5mm

D = 26.5;
R = D/2;
W = 1.5;
$fn=100;

module shape()
    polygon([
        [0,0], [R+W,0], 
        [R+W, 15], 
        [1.5*R+W , 30],  
        [1.5*R, 30],
        [R-0.3, 15], [R , 0] // tight fit !
    ]);

union()
{
    
    translate([0,0,30 +2])
    rotate([0,180,0])
    rotate_extrude(angle = 360)
    shape();

    diameter = 1.5*D +2*W;
    linear_extrude(2)
        difference() {
            circle(d = diameter);
            circle(d = 4);
            for(j = [1:1:4])
            for(i = [0 :6 * (j+1): 360 ])
              rotate(i+1*j)
                translate([22-4*j, 0])
                  circle(d = 2.2);
     
            
        }
        
}