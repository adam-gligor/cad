for (i=[0:10])
   translate([0,0,2*i])
     cube(size=[10 -(0.1 *i), 10 -(0.1 *i) , 2] , center = false);



translate([0,20,0]){
for (i=[0:10])
   translate([0,0,2*i])
     cube(size=[10 -(0.2 *i), 10 -(0.2 *i) , 2] , center = false);

}