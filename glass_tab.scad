include <../kossel/configuration.scad>;

sticky_width = 25.4;
sticky_length = 25.4;
sticky_offset = 2.5;  // Distance from screw center to glass edge.
bed_dia=200;
bed_height=3.0;
t=6.3;
//m3_wide_radius= 3.5/2; 
// Make the round edge line up with the outside of OpenBeam.
screw_offset = sticky_width/2 - 7.5;
cube_length = sticky_length + sticky_offset - screw_offset;

module glass_tab() {
  difference() {
    translate([0, screw_offset, 0]) union() {
      cylinder(r=sticky_width/2, h=t, center=true);
      translate([0, cube_length/2, 0])
        cube([sticky_width, cube_length, t], center=true);
    }
    translate([0,-0.5,0])
    cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
    translate([0,sticky_offset+bed_dia/2,t/2-bed_height]) cylinder(d=bed_dia,h=bed_height+0.1,$fn=200);
  }

  // Horizontal OpenBeam.
  translate([0, 0, (15+t)/-2]) %
    cube([100, 15, 15], center=true);
}

translate([0, 0, t/2]) glass_tab();
echo (thickness);