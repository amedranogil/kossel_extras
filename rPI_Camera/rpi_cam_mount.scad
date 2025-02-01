use <electronicsBox.scad>;
use <camera.scad>;

w=1.6;
boxmargin=1.1;
roundness=2;
conD=2*w+5.5;
conL=10;
dd=0.5;
$fn=20;
module BoxA(){
    difference() {
        union(){
            bottomBox(size=[24+2*w+boxmargin*2,25+2*w+boxmargin*2,2*w+5.5],r=roundness,center=false, w=w, dd=0.25);
            for ( i = [2,14.5], j=[2,23])
                translate([w+boxmargin+i,w+boxmargin+j,w]) stud (or=2, ir=1, h=w+2);
        }
        translate([24-5.75+w+boxmargin,2.75+w+boxmargin,w+2]) cube([30,19.5,4+w]);
    }
    for(i=[0,20+w])
    translate([24+w*2+boxmargin*2+conL-conD/2,1.75+w+boxmargin+i,conD/2]) rotate([-90,0,0]) {
            Dconnector(d=conD,l=conL);
            translate([-conL+conD/2-w,conD/2-w,-w/2]) cube([w,w,w]);
    }
    translate([24+w*2+boxmargin*2+conL-conD/2,1.75+w/2+boxmargin,conD/2]) rotate([90,0,0])nuttrap(od=conD);
}

module BoxB(){
    difference(){
        topBox([24+2*w+boxmargin*2,25+2*w+boxmargin*2,2*w+1.4],r=roundness,center=false, w=w, dd=0.25);
        translate([w+boxmargin+10.25+4,w+boxmargin+12.5,-1]) cylinder(d=8.5,h=w+2,$fn=16);
    }
}

module barHead(conD=conD,conL=conL){
    for(i=[0,20-w-dd])
    translate([0,i,0]) rotate([-90,180,0]) {
            Dconnector(d=conD,l=conL);
    }
    translate([conL-conD/2,-w/2,-conD/2]) cube([w,20-dd,conD]);
}

module Dconnector(d=10,l=15,w=w,id=3.4){
    translate([0,0,-w/2])
    difference(){
        union(){
            cylinder(d=d,h=w);
            translate([-l+d/2,-d/2,0]) cube([l-d/2,d,w]);
        }
        translate([0,0,-1])cylinder(d=id,h=w+2);
    }
}

module nuttrap (nd=5.4*2/sqrt(3)+dd*2,h=1.2,od=8,iw=0.8){
    difference(){
        cylinder(d1=od,d2=nd+iw*2,h=h);
        translate([0,0,-1]) cylinder($fn=6,d=nd,h=h+2);
    }
}

module crossbar(bw=conD,bl=50,w=4.7,) {
    intersection(){
        for (a= [45,-45])
            rotate([0,0,a]) cube([sqrt(2)*bw,w,bl],center = true);
        cube([bw,bw,bl],center = true);
    }
}

module conbar(L=20){
    barHead();
    translate([L/2+conL-conD/2+w,(20-w-dd)/2,0]) rotate([0,90,0]) crossbar(bl=L);
    for (i = [-1,1]*(w+dd))
    translate([L+conL-conD/2+w+conL-conD/2,(20-w-dd)/2+i,0]) rotate([-90,0,0]) Dconnector(d=conD,l=conL);
//    for (i = [-1,0,1]*(w+dd)*2)
//    translate([L+conL-conD/2+w+conD/2,(20-w-dd)/2+i,0]) rotate([-90,0,180]) Dconnector(d=conD,l=conL);
}

module arc
(r = 10,
 rd = -0.1,
angles = [45, 135])
{
points = [
    for(a = [angles[0]:5:angles[1]]) [r * cos(a), r * sin(a)], 
    for(a = [angles[1]:-5:angles[0]]) [(r+rd) * cos(a), (r+rd) * sin(a)]
];
    polygon(points);
}

module base(width=15, length=40,da=30,aa=30){
    //base plate
    difference(){
        minkowski(){
            linear_extrude(height = w/2)
            arc(r=0,rd=length-width,angles=[180-aa/2,180+aa/2]);
            cylinder(r=width/2,h=w/2);
        }
    //pivot hole
    translate([0,0,-1]) cylinder(d=3.4, h= w+2);
    //adjust hole
    translate([0,0,-1])linear_extrude(height = w+2)
            offset(r=3.4/2)
            arc(r=length-width,angles=[180-aa/2,180+aa/2]);
}
    // connector
    translate([-length/2+width/2,0,0]) rotate([0,0,da]) {
    for (i = [-1,0,1]*(w+dd)*2)
        translate([0,i,conL-conD/2]) rotate([-90,-90,0]) Dconnector(d=conD,l=conL);
    translate([0,(w+dd)*2+w+dd*3/4,conL-conD/2])rotate([90,0,0])nuttrap(od=conD);
    }
}


BoxA();
translate([24+w*2+boxmargin*2+conL-conD/2,1.75+w*2+dd/2+boxmargin,conD/2]) conbar();
translate([0,25+2*w+boxmargin*2,11.5+4*$t]) rotate([180,0,0])
//translate ([40,0,0])
BoxB();
%translate([boxmargin+w,boxmargin+w,w+4]) rpi_camera();

translate([0,50,0]) base();
