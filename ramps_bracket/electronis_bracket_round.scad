
sh=4; //stub height
sd=6; //stub outer diameter
sid= 2.7;//stub inned diameter
od=5; //outer distance
br=5; //braket radius
id=-5.5; //inner distance
m3i=15; //M3 in (from the sides)
bh=4.5;   // bracket height
bbh=2;   //bottom bracket height

// holes position
hp = [
    [5.08,50.8],
    [87.63,50.8],
    [11.43,2.54],
    [86.36,2.54],
];
    
    module roundedCube(d,r){
    hull(){
    translate([+r,+r,0]) cylinder(r=r,h=d[2]);
    translate([d[0]-r,+r,0]) cylinder(r=r,h=d[2]);
    translate([+r,d[1]-r,0]) cylinder(r=r,h=d[2]);
    translate([d[0]-r,d[1]-r,0]) cylinder(r=r,h=d[2]);
    }
    }
module hexM3screw (h){
   cylinder(d=3.5,h=h);
    translate([0,0,h-3.5])
        cylinder(d=6,h=3.5);
} 

module backet (S){
    holepos=[1/3,2/3];
    difference(){
        //cube(S);
        hull(){
            for (i = holepos){
                translate([0,S[1]*i,S[2]/2]) rotate([0,90,0])
                  cylinder(d=S[2],h=S[0]);
            }
            for (i=[0,S[1]-1]){
                translate ([0,i,0]) cube([S[0],1,bbh]);
            }
        }
        //bracet Holes
        for (i = holepos)  {
            translate([-1,S[1]*i,S[2]/2]) 
                rotate([0,90,0]) hexM3screw(h=S[0]+1.1);
        }
    }
}
    
module boardHull(hp, h, d=0,r=0){
    maxx = max([for (i=hp) i[0]]);
    maxy = max([for (i=hp) i[1]]);
    linear_extrude(height=h) 
        offset(r=r) offset(delta=d) 
            square([maxx,maxy]);
}
    
%translate([0,0,sh])boardHull(hp,1.5,r=3.5);
maxy = max([for (i=hp) i[1]]);
difference(){
    union(){
        translate([0,0,-bbh])
            boardHull(hp,bbh,od-br,br);
        for (p=hp){
            translate([p[0],p[1],0]) cylinder(d=sd,h=sh);
        }
        translate([-od-bh,-od+br,-bbh]) 
        backet([bh,maxy+od*2-2*br,m3i]);
    }
    // open bottom
    translate([0,0,-bbh-1])
        boardHull(hp,bbh+2,r=id);
    //passthrough holes
    for (p=hp){
        translate([p[0],p[1],-bbh-1]) cylinder(d=sid,h=sh+bbh+2);
    }
}