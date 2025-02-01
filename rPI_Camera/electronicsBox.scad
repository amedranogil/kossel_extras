
function tn(a) = (a==0)?1:-1;

module rbox(size=[1,1,1],r=1,center=false){
    translate ((center)?-size/2:[0,0,0])
    hull()
        for(i=[0:1],j=[0:1],k=[0,1])
           translate( 
        [i*size[0]+tn(i)*r,
         j*size[1]+tn(j)*r,
         k*size[2]+tn(k)*r]) sphere(r);
}

module open_rbox(size=[1,1,1],r=1,center=false, w=2){
    difference() {
        rbox(size+[0,0,r],r,center);
        translate((center?0:1)*[w,w,w])
            rbox(size-2*[w,w,w]+[0,0,r*4],r,center);
        translate((center?0.5:1)*[0,0,size[2]])
            cube([size[0],size[1],r],center);
        }
}


module bottomBox(size=[1,1,1],r=1,center=false, w=2, dd=0.5, clips=[1,0]){
    //outer
    open_rbox(size,r,center,w/2-dd);
    //inner
    open_rbox(size-[0,0,w+dd],r,center,w);
    //clips
    for(i=[0:clips[0]-1], j=[0:1])
            translate([
        size[0]-w+dd*2-(1+i)*(size[0]-w+dd*2)/(clips[0]+1),
        w/2+j*(size[1]-w),
        size[2]-w/2])
        rotate([0,90,0]) cylinder(d=w/2,h = (size[0]-w+dd*2)/(clips[0]+3),center=true);
}
module topBox(size=[1,1,1],r=1,center=false, w=2, dd=0.5, clips=[1,0]){
    //inner
    translate((center?0:1+dd)*[w,w,0]/2)
    difference(){
        open_rbox(size-[1,1,0]*(w+dd*2),r,center,w/2-dd);
        for(i=[0:clips[0]-1], j=[0:1])
            translate([
        size[0]-w+dd*2-(1+i)*(size[0]-w+dd*2)/(clips[0]+1),
        j*(size[1]-w-dd*2),
        size[2]-w/2])
        rotate([0,90,0]) cylinder(d=w/2+dd/2,h = (size[0]-w+dd*2)/(clips[0]+3),center=true);
    }
    //outer
    open_rbox(size-[0,0,w+dd],r,center,w);
}

module stud (or=2, ir=1, h=5){
    difference() {
        union() {
        cylinder(r=or,h=h,$fn=20);
        cylinder(r1=or*2, r2=or, h=or,$fn=20);
    }
    translate([0,0,ir])
    hull(){
        sphere(ir);
        translate([0,0,h])
        sphere(ir);
    }
}
}

translate([0,49,38+4*$t]) rotate([180,0,0])
topBox(size=[92,49,12],r=5,center=false, w=2, dd=0.25);
bottomBox(size=[92,49,26],r=5,center=false, w=2, dd=0.25);