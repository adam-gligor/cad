
//                polygon([[0,0],[hb_r+2,0],[ph_half_width+gd_width,total_h-5],[ph_half_width+gd_width,total_h],[0,total_h]]);

w=160;
w_half = w/2;
h = 140;
thick = 20;
thick_half = thick/2;

module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};

linear_extrude(height=25, center=false)
{
    copy_mirror([1,0,0])
    difference(){
        union(){
            difference(){
                polygon([[0,0],[w_half,0],[w_half,h],[0,h]]);

                color(){
                    //translate([w_half-thick,0,0]) square(size=[thick,thick]);
                    translate([w_half-thick,h-thick,0]) square(size=[thick,thick]);
                }
            }

            color(){
                translate([w_half-thick,thick,0]) circle(d=thick*2);
                translate([w_half-thick,h-thick,0]) circle(d=thick*2);
            }
        }

        color()
        minkowski(){
            color() {translate([thick+thick_half,thick*2]) circle(r=thick);}
            color() {translate([0,0]) square(size=[w_half-thick*2-thick-thick_half,h-4*thick]);}
        }
    }
}

//color("red") translate([0,0,-1]) linear_extrude(height=6) translate([0,120/2+thick+1,0])square(size=[120,h-thick],center=true);

color()  
    linear_extrude(height=3) {
        hull(){
            translate([-w_half,-thick,0])
                square(size=[w,thick*2]);
            color(){
              translate([-w_half+thick,-thick,0])
                circle(r=thick);
             translate([w_half-thick,-thick,0])
                circle(r=thick);
            }
        }
    }


