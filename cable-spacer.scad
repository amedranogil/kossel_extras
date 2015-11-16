l1=45;
l2=15;
l3=2.9;
w1=4;
w2=3.5;
w3=4;
h=35;

union(){
    cube([l1,w1,h],center=true);
    translate([0,w1/2+w2/2,0]) cube([l2,w2,h],center=true);
    translate([0,w1/2+w2+w3/2,0]) cube([l3,w3,h],center=true);
}