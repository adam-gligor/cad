
// tile_width, tile_height include 1/2 gap_size !
module tiled_wall(wall_width, wall_height, tile_widthx, tile_heighty, gap_size, offset_x, offset_y) {
    
    tile_width = tile_widthx + gap_size;
    tile_height = tile_heighty + gap_size;
 
//    color("gray")
    //cube([wall_width, wall_height, 1]);
   
    intersection(){
        //color("gray")
        cube([wall_width, wall_height, 2]);

        num_tiles_x = ceil(wall_width / tile_width); // Number of tiles in X direction
        num_tiles_y = ceil(wall_height / tile_height); // Number of tiles in Y direction
        
        center_x = (wall_width - tile_width) /2 ;
        center_y = (wall_height - tile_height) / 2 ;

        tx = floor(num_tiles_x/2);
        ty = floor(num_tiles_y/2);

        for (x = [-tx-1 :1: tx]) {
            for (y = [-ty-1 :1: ty]) {
                ox = offset_x + center_x + x * tile_width;
                oy = offset_y + center_y + y * tile_height;
                // draw tile 
                union(){
                translate([ox+(gap_size/2) , oy+(gap_size/2) , 0])
                //color("lightgray") 
                    cube([tile_width-gap_size, tile_height-gap_size, 2]);
                }
            }
        }
    }
        
}

module tiled_poly_wall(wall_width, wall_height, points, tile_widthx, tile_heighty, gap_size, offset_x, offset_y) {
    
    tile_width = tile_widthx + gap_size;
    tile_height = tile_heighty + gap_size;
 
//    color("gray")
    //cube([wall_width, wall_height, 1]);
   
    intersection(){
        //color("gray")
        //cube([wall_width, wall_height, 2]);
          polygon(points=points);

        num_tiles_x = ceil(wall_width / tile_width); // Number of tiles in X direction
        num_tiles_y = ceil(wall_height / tile_height); // Number of tiles in Y direction
        
        center_x = (wall_width - tile_width) /2 ;
        center_y = (wall_height - tile_height) / 2 ;

        tx = floor(num_tiles_x/2);
        ty = floor(num_tiles_y/2);

        for (x = [-tx-1 :1: tx]) {
            for (y = [-ty-1 :1: ty]) {
                ox = offset_x + center_x + x * tile_width;
                oy = offset_y + center_y + y * tile_height;
                // draw tile 
                union(){
                translate([ox+(gap_size/2) , oy+(gap_size/2) , 0])
                //color("lightgray") 
                    cube([tile_width-gap_size, tile_height-gap_size, 2]);
                }
            }
        }
    }
        
}



x = 180;
y = 280; // 90-100-100
tile_x = 50;
tile_y = 20;
gap = 1;//0.4;

color("gray") {
//cube([x,y,1]);
    
  
y1 = 90; // shower
y2 = 100; //wc
y3 = 90; //sink
h1 = 120; // inclined wall
h = 220; //total h
points = [[0,0],[0,y1],[h1,y1],[h,0]];

    
// back 
translate([0,y,0]) rotate([90,0,0]) tiled_wall(x,h1,tile_x, tile_y, gap, 0,0);
    
// inclined side 1     
translate([0,y-y1,0]) rotate([0,-90,0]) tiled_poly_wall(h,y1,points,tile_y, tile_x, gap, 0,tile_x/2);

// inclined side 2     
translate([x,y-90,0]) rotate([0,-90,0]) tiled_poly_wall(h,y1,points,tile_y, tile_x, gap, 0,tile_x/2);


// toilet wall

translate([x,y-y1,0]) rotate([90,-90,0]) cube([h,15,1]); 

translate([x-15,y1,0]) 
    rotate([0,-90,0]) tiled_wall(h,y2,tile_y, tile_x, gap, 0,tile_x/2);

 
//sink wall
    
translate([x,y3,0]) rotate([90,-90,0]) cube([h,15,1]); 
translate([x,0,0]) 
    rotate([0,-90,0]) tiled_wall(h,y3,tile_y, tile_x, gap, 0,tile_x/2);


// door wall

}



//tiled_wall(200,100,20, 20, 0.4, 0,0);

