
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

x = 180;
y = 220;
tile_x = 40;
tile_y = 20;
gap = 0.4;

cube([x,y,1]);
translate([0,y,0]) rotate([90,0,0]) tiled_wall(x,100,tile_x, tile_y, gap, 0,0);


//tiled_wall(200,100,20, 20, 0.4, 0,0);

