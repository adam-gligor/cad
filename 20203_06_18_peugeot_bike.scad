
module rear_light_holder(){
R1=18/2;
H1=19;
#difference(){
cylinder(r=R1, h=H1);
cylinder(d=6,h=H1);
}



H2=R1+5;
H3=10;
H4=4;
//translate([R1-H4,0,(H1-R1)/2])
union(){
    cube([R1,R1,H3]);
    translate([R1-H4,0,0]) cube([H4,H2,H3]);
    translate([R1-H4,H2,H3/2]) rotate([0,90,0]) 
    difference(){
        cylinder(d=H3,h=H4);
        cylinder(d=6,h=H4);
    }
}
//6
//12 + ...

}

rear_light_holder();