module prism(l, w, h){
   polyhedron( 
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
   );
}

module spacer_9mm(wall){
    rear_length=30;
    rear_offset_z=2;
    translate([0,-wall,0]){
        //the front piece
        translate([18,0,-3])
            rotate([0,0,90])
                prism(wall,18,10.4);
        //the rear piece
        translate([-rear_length,wall,rear_offset_z])
            rotate([0,0,-90])
                prism(wall,rear_length,5.4);        
        //fill-in bit
        translate([-rear_length,0,0])
            cube(size=[rear_length,wall,rear_offset_z]);        
    }
}

module mount_plate_side() {
    height = 7;
    width = 10;
    wall = 2;
    offset_x = 30;
    
    translate([-offset_x,0,-height]){
        difference(){
            cube(size=[width,wall,height]);
            translate([3,0,2])
                cube(size=[4,wall,2]);
        }
    }
}

module mount_plate(clipper_width){
    center_width =20;
    wall = 2;
    offset_x = 30;

    //the center piece
    translate([-offset_x,-wall,0])
        cube(size=[center_width,clipper_width+2*wall,wall]);
    //one side piece
    translate([0, -wall, 0])
        mount_plate_side();
    //the other side piece
    translate([0, clipper_width,  0]) 
        mount_plate_side();    
}

module clipper_comb_9mm() {
    width = 36;
    // the complete mount plate
    mount_plate(width);
    // the two sides (thicker)
    spacer_9mm(2);
    translate([0, width + 2,  0])
        spacer_9mm(2);
    // 5 more sides (thinner)
    for (i=[1:5])
        translate([0, i*6.2, 0])
            spacer_9mm(1.2); 
}

clipper_comb_9mm();