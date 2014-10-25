
include <MCAD/units.scad>;

sh=4;

trx=0;
try=0;

od=5;
id=-8;

m3i=15;

bh=4;

hp= [
      [trx,try,0],
      [trx+82.55,try,0],
      [trx+1.3,try+48.2,0],
      [trx+74.9,try+48.2,0]
     ];

module roundedCube(d,r){
    hull(){
        translate([+r,+r,0]) cylinder(r=r,h=d[2]);
        translate([d[0]-r,+r,0]) cylinder(r=r,h=d[2]);
        translate([+r,d[1]-r,0]) cylinder(r=r,h=d[2]);
        translate([d[0]-r,d[1]-r,0]) cylinder(r=r,h=d[2]);
    }
}
%translate([-14,-2.5,sh])cube([4*inch,2.1*inch,1.5]);
difference(){
    union(){
        difference(){
            translate([-14,-2.5-od,-bh])
                cube([4*inch+od,2.1*inch+2*od,bh]);
            translate([-14-id,-2.5-id,-bh])
                roundedCube([4*inch+2*id,2.1*inch+2*id,bh],10);
        }
        translate([4*inch+od-14,-2.5-od,-bh])
        difference(){
            cube([5,2.1*inch+2*od,15]);
            translate([-0.5, m3i, 15/2]) 
                rotate([0,90,0]) cylinder(r=3/2,h=6);
            translate([-0.5, 2.1*inch+2*od -m3i, 15/2]) 
                rotate([0,90,0]) cylinder(r=3/2,h=6);
        }
        for(p = hp) {
            translate(p) cylinder(r=3.0,h=sh);
        }
    }

    for(p = hp) {
        translate(p - [0,0,bh]) cylinder(r=1.2,h=sh+bh);
    }
}