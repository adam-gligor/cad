include <arc.scad>;
//module arc(radius, thick, angle)
$fn=30;

ph_width = 75;  
ph_half_width = ph_width/2;
ph_height = 10;
hb_d = 30;  //handlebar
hb_r = hb_d/2;

gd_width=5;//guard
total_h=hb_r+20;//minus guard height

module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};

module horizontal_part(){

    linear_extrude(height=20, center=true)
    {
        copy_mirror([1,0,0])
        {

            difference(){
                
                //the main shape
                // 1 - 2
                //      \
                // |     3
                //       |
                // 5 -   4 
                polygon([[0,0],[hb_r+2,0],[ph_half_width+gd_width,total_h-5],[ph_half_width+gd_width,total_h],[0,total_h]]);
                circle(d=hb_d);
                translate([0,total_h-10]){
                    square(size=[10,total_h]);
                }
            }

            //guard werical part
            translate([ph_half_width,total_h,0])
                square(size=[gd_width,ph_height]);

            //guard upper curve
            translate([ph_half_width,total_h+ph_height,0]) 
                rotate([0,0,45]) 
                    arc(0,gd_width,90 );
            
            //guard end curve 
            translate([ph_half_width-2,total_h+ph_height+2.5,0]){
                hull(){
                    circle(r=2.5);
                    translate([2,0,0])
                        circle(r=2.5);
                }
            }
            

        }
    }
}

horizontal_part();


    