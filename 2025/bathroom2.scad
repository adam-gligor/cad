
module tiled_wall(wall_width, wall_height, tile_widthx, tile_heighty, gap_size, offset_x, offset_y, center_x, center_y) {
    
    points = [[0,0],[wall_width,0],[wall_width, wall_height], [0, wall_height]];
    tiled_poly_wall(wall_width, wall_height, points,tile_widthx, tile_heighty, gap_size, offset_x, offset_y, center_x, center_y);
}


// wall_width, wall_height - dimensions of a square wall
// points - pologon points for non square walls
// tile_widthx, tile_heighty, gap_size - tile and gap size
// offset_x, offset_y - offset to move tiles ... tip use center=true & offset = tile/2 to center differntly !
// center_x, center_y - when true will center the tiles 
//
// works by assuming a 1/2 gap_size margin along the edges of the tile 
module tiled_poly_wall(wall_width, wall_height, points, tile_widthx, tile_heighty, gap_size, offset_x, offset_y, center_x, center_y) {
    
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
        
        center_x = center_x ? (wall_width - tile_width) /2 : 0;
        center_y = center_y ? (wall_height - tile_height) / 2 : 0;

        tx = floor(num_tiles_x/2);
        ty = floor(num_tiles_y/2);

        x1 = center_x ? -tx-1 : 0; 
        x2 = center_x ? tx: num_tiles_x;
        
        y1 = center_y ? -ty-1 : 0; 
        y2 = center_y ? ty: num_tiles_y;
        
        
        for (x = [x1 :1: x2]) {
            for (y = [y1 :1: y2]) {
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
tile_x = 60;
tile_y = 20;
gap = 1;//0.4;

color("gray") {
//cube([x,y,1]);
    
  
y1 = 90; // shower
y2 = 100; //wc
y3 = 90; //sink
h1 = 120; // inclined wall
h = 220; //total h
points = [[0,0],[0,h1],[y1,h],[y1,0]];
//polygon(points);
    
// back 
translate([0,y,0]) rotate([90,0,0]) tiled_wall(x,h1,tile_x, tile_y, gap, tile_x/2,0, true, false);
    
//// inclined side 1     
translate([0,y,0]) 
rotate([90,0,-90]) 
tiled_poly_wall(y1, h, points, tile_x, tile_y, gap, tile_x/2, 0, true, false);

//// inclined side 2     
translate([x,y,0]) 
rotate([90,0,-90]) 
tiled_poly_wall(y1, h, points, tile_x, tile_y, gap, tile_x/2, 0, true, false);


// toilet wall
//
translate([x,y-y1,0]) rotate([90,-90,0]) cube([h,15,1]); 
//
translate([x-15,y1+y2,0]) 
rotate([90,0,-90])
tiled_wall(y2, h, tile_x, tile_y, gap, tile_x/2, 0, true, false);
 
////sink wall
//    
translate([x,y3,0]) rotate([90,-90,0]) cube([h,15,1]); 
//
translate([x,y3,0]) 
rotate([90,0,-90])
tiled_wall(y3, h, tile_x, tile_y, gap, tile_x/2, 0, true, false);


translate([0,y-90,0]) cube([x,10,5]);
tiled_wall(x, y-90, 45, 45, gap, 45/2, 0, true, false);


// floor 



}



//tiled_wall(200,100,20, 20, 0.4, 0,0);

