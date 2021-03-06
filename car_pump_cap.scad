// 3 cylinders 
// center rod 7mm
// ouside: 55mm
$fn=100;
SMALL_DIAM = 7.4;
LARGE_DIAM = 55;

HEIGHT_1 = 10;
HEIGHT_2 = HEIGHT_1 + 10;

difference(){
    cylinder(h=HEIGHT_2,d=LARGE_DIAM+3);
    cylinder(h=HEIGHT_2,d=LARGE_DIAM);
}

difference(){    
    cylinder(h=HEIGHT_1,d=LARGE_DIAM);    
    cylinder(h=HEIGHT_1,d=SMALL_DIAM);
}
