
module make_round_planter(d, h, t=2.5, top_offset=0.5, bottom_offset=0.1, tray_h=10, tray_separation=2.5, gap=0.5, show_planter=1, show_tray=1, td=0){
    
    td = (td) ? td : d;
    
    if(show_planter)
    union(){
        difference(){
            
            // main wall
            difference(){
                sphere(d=d, $fn=100);
                sphere(d=d-t*2, $fn=100);
            }
                
            // top cutoff
            translate([0,0,d-d*top_offset])
            cube([d,d,d], center=true);
        
            // bottom cutoff
            translate([0,0,-d+d*bottom_offset])
            cube([d,d,d], center=true);
            
        }
        difference(){
            
            // bottom wall
            intersection(){
                sphere(d=d, $fn=100);
                color("red")
                translate([0, 0, -d+d*bottom_offset + d/2 + t/2])
                cube([d*2,d*2,t], center=true);
            }
            
            // drainage hole
            translate([0,0,-d/2])
            cylinder(d=d*.1, h=d, center=true, $fn=50);

        }
    }
    
    //tray
    if(show_tray){
        //translate([d/2,0,0])
        translate([0, 0, -d+d*bottom_offset + d/2 +tray_h/2 - t - tray_separation])
        //translate([0,0,-tray_h/2])
        {
            difference(){
                cylinder(d=td, h=tray_h, center=true, $fn=100);
                translate([0,0,t])
                cylinder(d=td-t*2, h=tray_h, center=true, $fn=100);
            }
        }
        
        //tray groves
        difference(){
            intersection(){
                difference(){
                    intersection(){
                        cylinder(d=td-t*2, h=d, center=true, $fn=100);
                        union(){
                            for(i=[0:2])
                            rotate([0,0,90*i])
                            cube([2,d,d], center=true);
                        }
                    }
                    difference(){
                        sphere(d=d+gap, $fn=100);
                        translate([0,0,-d+d*bottom_offset+gap/2])
                        cube([d,d,d], center=true);
                    }
                }
                translate([0, 0, -d+d*bottom_offset + d/2 +tray_h/2 - t - tray_separation])
                cylinder(d=td, h=tray_h, center=true, $fn=100);
            }
            // grove center cutout
            cylinder(d=td*.5, h=d, center=true, $fn=100);
        }
    }
    
    
}

make_round_planter(d=100, td=90, h=5, top_offset=0.4, show_planter=1, show_tray=0);
//make_round_planter(d=100, td=90, h=5, top_offset=0.4, show_planter=0, show_tray=1);
