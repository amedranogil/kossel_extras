
include <MCAD/units.scad>;

sh=4; //stub height
od=5; //outer distance
id=-8; //inner distance
m3i=15; //M3 in (from the sides)
bh=4;   // bracket height
trx=14; // holes translation x
try=2.5; // holes translation y
hp= [   
      [trx,try,0],
      [trx+82.55,try,0],
      [trx+1.3,try+48.2,0],
      [trx+74.9,try+48.2,0]
     ];  // holes position

module roundedCube(d,r){
    hull(){
        translate([+r,+r,0]) cylinder(r=r,h=d[2]);
        translate([d[0]-r,+r,0]) cylinder(r=r,h=d[2]);
        translate([+r,d[1]-r,0]) cylinder(r=r,h=d[2]);
        translate([d[0]-r,d[1]-r,0]) cylinder(r=r,h=d[2]);
    }
}
%translate([0,0,sh])cube([4*inch,2.1*inch,1.5]);
difference(){
    union(){
        difference(){
            translate([0,-od,-bh])
                cube([4*inch+od,2.1*inch+2*od,bh]);
            translate([-id,-id,-bh])
                roundedCube([4*inch+2*id,2.1*inch+2*id,bh],5);
        }
        translate([4*inch+od,-od,-bh])
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