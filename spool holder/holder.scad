
SpoolW = 95;
OB = 15.3;
width = 27;
wall= 5;
boltW=3.3;

module boltHoles(){
    h=3;
    cylinder(r=boltW/2, h = OB+2*wall, center=true);
    translate([0,0,(OB+2*wall-h)/2]) cylinder(r=5.5/2, h = h, center=true);
    translate([0,0,-(OB+2*wall-h)/2]) cylinder(r=5.5/2, h = h, center=true);
}
union(){
difference(){
hull(){
    translate([0,0,width/2]) rotate([90,0,0]) cylinder(r=width/2,h=SpoolW+2*wall);
    translate([-width/2,-SpoolW-wall*2,0]) cube([width, SpoolW+2*wall, wall]);
}
    translate([0,0,width/2]) rotate([90,0,0]) cylinder(r=width/2-wall,h=SpoolW+2*wall);
}
translate([0,0,width/2])
difference(){
     rotate([90,0,0]) cylinder(r=width/2+wall,h=wall);
     translate([-width/2,-wall-1,-width/2-wall]) cube([width,wall+2,wall]);
}
translate([0,-SpoolW-wall,width/2])
difference(){ 
     rotate([90,0,0]) cylinder(r=width/2+wall,h=wall);
     rotate([90,0,0]) cylinder(r=width/2-wall,h=wall+1);
     translate([-width/2,-wall-1,-width/2-wall]) cube([width,wall+2,wall]);
}
difference(){
    translate([-width/2,0,0]) cube([width, OB+wall, OB+2*wall]);
    translate([-width/2,wall,wall]) cube([width, OB, OB]);
    translate([width/6,wall+OB/2,(OB+2*wall)/2]) 
        boltHoles();
    translate([-width/6,wall+OB/2,(OB+2*wall)/2]) 
        boltHoles();
}
}