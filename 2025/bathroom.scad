// Input parameters
gap_size = 5;

wall_width = 200;   // Width of the wall
wall_height = 100;  // Height of the wall
tile_width = 40 + gap_size;    // Width of each tile
tile_height = 20 + gap_size;   // Height of each tile
//
//// Function to create a tile
module tile(x,y) {
    
    translate([x+(gap_size/2) , y+(gap_size/2) , 0])
    
    cube([tile_width-gap_size, tile_height-gap_size, 2]); // 1 unit thickness for the tile
    
    //translate([x,y, 0])
    
    //cube([tile_width, tile_height, 2]); // 1 unit thickness for the tile

}
//
//// Calculate the number of tiles needed
num_tiles_x = floor(wall_width / tile_width); // Number of tiles in X direction
num_tiles_y = floor(wall_height / tile_height); // Number of tiles in Y direction
//
//// Calculate the total dimensions of the tiled area
//total_width = num_tiles_x * tile_width;
//total_height = num_tiles_y * tile_height;
//
//// Calculate the starting position to center the tiles on the wall
//start_x = (wall_width - tile_width) /2 ;
//start_y = (wall_height - tile_height) / 2 ;
//
//// Create the wall with centered tiles
//translate([start_x, start_y, 0]) {
//    //for (x = [0 : num_tiles_x - 1]) {
//     //   for (y = [0 : num_tiles_y - 1]) {
//                tile( tile_width, tile_height);
//      //  }
//   // }
//}


tx = ceil(num_tiles_x/2);
ty = ceil(num_tiles_y/2);


color("gray")
cube([wall_width, wall_height,1]);

start_x = (wall_width - tile_width) /2 ;
start_y = (wall_height - tile_height) / 2 ;
//translate([start_x,start_y,0])

offset_x = 0;//tile_width/2 ;
offset_y = 0;


for (x = [-tx-1 :1: tx]) {
    for (y = [-ty-1 :1: ty]) {
        ox = offset_x + start_x + x * tile_width;
        oy = offset_y + start_y + y * tile_height;
        tile(ox, oy);
    }
}


// put a tile in the middle , start_x_y .. then twice for [- ... +]