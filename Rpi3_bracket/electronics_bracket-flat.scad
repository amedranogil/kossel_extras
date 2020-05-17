include <raspberry.scad>

m3i = 15; //openbeam 15mm
maxy=85;
maxx=56;
angle = 0;
anglez=30;
w=1.8;
bw=3.7;
stud=1.7;
tops=bw-w-0.5;
ztrans=0.6;
xtrans=27;
d=0.3;

module rpitrans(a=0){
    translate([
    -xtrans,//w+tops,
    xtrans*tan(90-anglez),//maxy-sin(anglez)*(maxx-0),
    maxx*sin(a)+w+m3i-ztrans+d])
        rotate([-a,0,-90+anglez])
            children();
}

module ccubey(S,rem_ratio=0.5){
    sep = S[1]*(1-rem_ratio)/2+S[1]*rem_ratio/2;
    difference() {
        cube(S);
        hull(){
            for ( i = [sep, S[0] -sep])
            translate([i,sep,-1])
            cylinder(d=S[1]*rem_ratio,h=S[2]+2);
        }
    }
}


module bracket(a){
    braketwidth= xtrans*tan(90-anglez) + xtrans*tan(anglez);
    translate([0,0,ztrans])
    difference(){
        union(){
            intersection () {
                rpitrans(a) translate([0,0,-m3i-w]) cube([maxy,maxx,m3i]);
                translate([0,-bw*tan(90-anglez),0])
                cube([bw,braketwidth+bw*tan(90-anglez)+bw*tan(anglez),1*m3i-ztrans+d]); 
            }//nearest to beam
        
            rpitrans(a) translate([0,0,-w]) ccubey([maxy,maxx,w],0.25); //rpi backplane
        rpitrans(a) standoffs(boardType = BPLUS,height = stud);
        }
        //bracket holes
        yhs = braketwidth*0.235;
        for (i = [yhs,braketwidth-yhs], j = [0,2])
            translate([0,i,-ztrans+m3i/2+j*m3i]) rotate([0,90,0]) {  
                cylinder(d=3.5,h=w+tops);
                translate([0,0,bw]) cylinder(d=6.0,h=tops+maxx/2);
                translate([0,0,bw-1.5]) cylinder(d2=6.0,d1=3.5,h=1.5);
            }
         // rpi holes
           rpitrans(a) translate([0,0,-w-2]) holePlacement(boardType = BPLUS) cylinder(d=3.2,h=w+7);
         // rpi components
           rpitrans(a) translate([0,0,stud]) components( boardType = BPLUS, component = ALL, extension = 0, offset = 1 );
    }
}

//open bean positions
for (i = [0,2])
%translate([-m3i,-20,i*m3i]) cube([m3i,maxy,m3i]);
//buildplate()
%translate([220-m3i,maxy/2,3*m3i+3]) cylinder(r=220,h=3);
//rpi position
    translate([0,0,ztrans])
%rpitrans(angle) translate([0,0,stud]) raspberry(BPLUS);

bracket(angle);
    