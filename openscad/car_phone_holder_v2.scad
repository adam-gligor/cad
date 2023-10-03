R = 15/2;
L = 10.5;
LL = 4;
X = 33;

module shape(){
    polygon([
        [0,1],
        [X-3,1], [X-3,-3], 
        [X-5,-3], [X-5,-5], 
        [X,-5], [X,2], 
        [X-2,LL], 
        [X-8,LL], 
        [0,LL]
    ]);
}

translate([0,L/2,0])
rotate([90,0,0])
linear_extrude(height = L) {
    shape();
}


translate([0,0,0])
sphere(r=R, $fn=100);

//left side
translate([-8.6,-L/2,-L/2])
cube([9, L,L] );
//
////right side
//translate([0,-L/2,-LL/2])
//cube([27, L, LL] );
//

//stopper
//translate([X-2,-L/2,-LL])
//cube([2, L, LL] );

//shape();
