//$fn = 20;
//
//h = 35;
//x = 17.5;
//y = 113;
//
//r = 380;
//
//
//module a (){
//difference(){
//    hull(){
//        cylinder (d = 1, h = h);
//        translate([0,y,0])cylinder (d = 5, h = h);
//        translate([x,y,0])cylinder (d = 5, h = h);
//    }
//
//    translate([r,0,0])
//        cylinder(r = r, h=h); 
//}
//}
//
//module b (){
//difference(){
//    offsx = 5;
//    offsy = 5; 
//    hull(){
//        translate([offsx,offsy+70,0]) cylinder (d = 1, h = h);
//        translate([offsx+2.5,y-offsy,0])cylinder (d = 5, h = h);
//        translate([x-offsx-2.5-3,y-offsy,0])cylinder (d = 5, h = h);
//    }
//
//    translate([r,0,0])
//        cylinder(r = r, h=h); 
//}
//}
//
//
//difference(){
//a();
//b();
//}

translate([-18,-80,0]) scale([0.115,0.115,0.115])
linear_extrude(height = 5) {
    import(file = "/home/adam/Downloads/xxx.svg");
}

cube([135,10,10]);