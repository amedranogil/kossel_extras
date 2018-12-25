
OB=15;
sw=3;
w=1.4;
HH=95;
difference(){
    cube([2*OB,OB,7]);
    translate([2*OB/5,OB/2,-1]) cylinder(d=3.5,h=7+2);
    translate([8*OB/5,OB/2,-1]) cylinder(d=3.5,h=7+2);
    translate([2*OB/5,OB/2,5]) cylinder(d=5.5,h=7+2);
    translate([8*OB/5,OB/2,5]) cylinder(d=5.5,h=7+2);
}

difference() {
 union(){
   intersection(){
    translate([OB,OB/2,HH/2]) rotate([0,0,60])
    {
            cube([w,OB*4,HH], center=true);
            translate([0,OB*2,HH/2]) rotate([90,0,0]) cylinder(d=w*2,h=OB*2,$fn=6);
    }
        cube([2*OB,OB,HH*2]);
    }
intersection(){
    translate([OB,OB/2,HH/2]) rotate([0,0,60-90])translate([-OB/2,OB,0]) cube([OB,OB*2,HH], center=true);
    cube([2*OB,OB,2*HH/3]);
}

}
           translate([OB,OB/2,HH/2]) rotate([0,0,180+60])
                translate([-OB,2*OB,-2*HH/4 ])
             rotate([20,0,0]) cube([2*OB,OB*4,HH*2]);
}
%rotate([0,0,-30]) translate([0,50,0]) cylinder(r=100,h=7, $fn=3);