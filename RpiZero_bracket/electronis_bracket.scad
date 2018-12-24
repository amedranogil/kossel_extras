
sh=4; //stub height
sd=6; //stub outer diameter
sid= 2.7;//stub inned diameter
od=5; //outer distance
id=-3; //inner distance
m3i=15; //M3 in (from the sides)
bh=4;   // bracket height

hp= [   
[0,0],
[0,58],
[23,0],
[23,58]
];  // holes position
    
    module roundedCube(d,r){
    hull(){
    translate([+r,+r,0]) cylinder(r=r,h=d[2]);
    translate([d[0]-r,+r,0]) cylinder(r=r,h=d[2]);
    translate([+r,d[1]-r,0]) cylinder(r=r,h=d[2]);
    translate([d[0]-r,d[1]-r,0]) cylinder(r=r,h=d[2]);
    }
    }
    
module boardHull(hp, h, d=0,r=0){
    maxx = max([for (i=hp) i[0]]);
    maxy = max([for (i=hp) i[1]]);
    linear_extrude(height=h) 
        offset(delta=d) offset(r=r)
            square([maxx,maxy]);
}
    
%translate([0,0,sh])boardHull(hp,1.5,r=3.5);
maxy = max([for (i=hp) i[1]]);
difference(){
    union(){
        translate([0,0,-bh])
            boardHull(hp,bh,od);
        for (p=hp){
            translate([p[0],p[1],0]) cylinder(d=sd,h=sh);
        }
        translate([-od-bh,-od,-bh]) 
        cube([bh,maxy+od*2,m3i]);
    }
    // open bottom
    translate([0,0,-bh-1])
        boardHull(hp,bh+2,r=id);
    //passthrough holes
    for (p=hp){
        translate([p[0],p[1],-bh-1]) cylinder(d=sid,h=sh+bh+2);
    }
    //bracet Holes
    translate([-od-bh-1,-od+(maxy+od*2)/3,-bh+m3i/2]) 
        rotate([0,90,0]) cylinder(d=3.5,h=bh+2);
    translate([-od-bh-1,-od+2*(maxy+od*2)/3,-bh+m3i/2]) 
        rotate([0,90,0]) cylinder(d=3.5,h=bh+2);
}