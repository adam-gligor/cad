//rotate_extrude( angle=360)
//translate([2,0])
H1 =  (47- 35)/2;
H2 =  35/2;

T=3;

rotate_extrude( angle=360)
rotate([0,0,90])
translate([0,H2])
polygon([
    [0,H1],[7,H1],[10,H1-3], [10,0], [40,0], 
    [40,T], [10,T], [14,T], [8,H1+T], [0,H1+T]
]);