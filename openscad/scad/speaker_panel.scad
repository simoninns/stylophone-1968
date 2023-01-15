/************************************************************************

    speaker_panel.scad
    
    Stylophone case
    Copyright (C) 2022 Simon Inns
    
    This is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
    Email: simon.inns@gmail.com
    
************************************************************************/

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

include <colour_scheme.scad>

module speaker_panel()
{
    move([-14,0,4]) {
        difference() {
            // Main prismoid shape
            union() {
                prismoid(size1=[66.5,154.5], size2=[63, 151.5], h=8);
                move([33.5,0,-0.75]) right_triangle([0.5, 154.5, 1.5], center=true);
                move([0,0,-0.75]) cuboid([66.5,154.5,1.5]);
            }

            // Hollow the prismoid leaving a 1.5mm thick wall (allow 1mm for the toprecess)
            move([0,0,-1 - 1.5]) prismoid(size1=[66.5 - 3,154.5 - 3], size2=[63 - 3, 151.5 - 3], h=8);

            // Top 1mm recess for speaker grill
            move([-5.75 + 1.5,0,10 - 1]) cuboid([51.5,151.5 - 3, 4]);

            // Pen holder recess
            move([28 - 1.5, 9.75 + 1.5, 8]) cuboid([7,126,2]);
            move([28 - 1.5,-65.25 + 1.5, 8]) cuboid([7,21,2]); // Decoration left of pen holder

            // Cut slot for pen holder
            move([28 - 1.5, 13.5 - 2.25 + 9, 6]) cuboid([7,126 - 18,10]);

            // Badge cut-out
            move([-18.5, 34.5, 6.5]) {
                cuboid([7,64, 4]);
            }

            // Speaker cut-out
            move([speakerx() + 14, speakery(), 5.5]) { 
                difference() {
                    cyl(d=52, h=10);
                    cuboid([9.5,55,12]);
                    move([28.5,0,0]) cuboid([10,55,12]);
                }
                move([0,0,-5]) cyl(d=58, h=10);
            }
        }

        // Add some small tabs to position the grill correctly
        move([-27.225,-67.25,7.25]) cuboid([0.5,4.25,0.5]); // Top L
        move([-27.225,+68.8,7.25]) cuboid([0.5,4.25,0.5]); // Top R

        move([+18.7,-67.25,7.25]) cuboid([0.5,4.25,0.5]);
        move([+18.7,+68.8,7.25]) cuboid([0.5,4.25,0.5]);
    }
}

// Render the mounting tabs to assist fixing the panel to the upper-case
module panel_mounts()
{
    move([-14,0,4]) {
        // Side tabs
        move([+15,+76.5,-2.75]) cuboid([10,1.5,2.5]);
        move([-15,+76.5,-2.75]) cuboid([10,1.5,2.5]);
        move([-15,-76.5,-2.75]) cuboid([10,1.5,2.5]);

        // Back tabs
        move([-32.5, 50,-2.75]) cuboid([1.5,10,2.5]);
        move([-32.5,  0,-2.75]) cuboid([1.5,10,2.5]);
        move([-32.5,-50,-2.75]) cuboid([1.5,10,2.5]);

        // Front tabs
        move([32.75 - 0.125,50,-2.75]) cuboid([1.5,10,2.5]);
        move([32.75 - 0.125,0,-2.75]) cuboid([1.5,10,2.5]);
        move([32.75 - 0.125,-48,-2.75]) cuboid([1.5,10,2.5]);
    } 
}

module pen_holder()
{
    move([13,0,21 - 0.125 - 15]) {
        difference() {
            union() {
                move([-0.5,20 - 8 + 8.5,5-4.125]) cuboid([9,127 - 18,8.5]);

                // Add some filler to make the printing easier
                move([4.25, 20.5, 0]) cuboid([0.75,109,6.75]);
                move([-0.125, 75, -2 + 0.125]) cuboid([9.75,1.25,3]);
            }

            // Clearance for the speaker
            move([speakerx() - 12.5, speakery(), speakerz() - 7]) cyl(d=58, h=9.25);

            // Pen body recess
            move([-0.5,27.25,3.5]) {
                hull() {
                    cuboid([7,94,10]);
                    move([0,-57.5,0]) cyl(h=10, d=5);
                }
            }

            // Stylus cable hole
            move([-0.5,74.5 - 69,2.5]) {
                cyl(h=20, d=2.5);
            }
        }

        difference() {
            union() {
                // Stylus rocker raise
                move([-0.5,73.5 - 29, -1.5]) {
                    cyl(h=3, d=2.5, fillet=1);

                    move([4.5,0,2]) {
                        difference() {
                            cyl(h=8 - 0.1, d=3);
                            move([1,0,0]) cuboid([3,7,10]);
                        }
                    }
                    move([-4.5,0,2]) {
                        difference() {
                            cyl(h=8 - 0.1, d=3);
                            move([-1,0,0]) cuboid([3,7,10]);
                        }
                    }
                }

                // Stylus rocker pivot
                move([-0.5,73.5 - 69 - 6, -1.5]) {
                    rotate([0,90,0]) cyl(h=8, d=3);

                    move([4.5,0,2]) {
                        difference() {
                            cyl(h=8 - 0.1, d=3);
                            move([1,0,0]) cuboid([3,7,10]);
                        }
                    }
                    move([-4.5,0,2]) {
                        difference() {
                            cyl(h=8 - 0.1, d=3);
                            move([-1,0,0]) cuboid([3,7,10]);
                        }
                    }
                }
            }

            // Remove excess from raise and pivot
            move([-0.5,20, -3.5]) {
                cuboid([10,60,2]);
            }
        }

        // Guide for the speaker
        move([speakerx() - 12.5, speakery(), speakerz() - 3]) {
            arced_slot(r=59 / 2, h=1.5, sd=1, sa=33, ea=46);
        }
    }
}

module pcb_screw_mount()
{
    move([0,0,5]) difference() {
        cyl(h=10, d=8);
        cyl(h=11, d=2.5);
    }

    // This end cap is to prevent supports being placed
    // inside the mount
    move([0,0,0.125]) cyl(h=0.25, d=2.25);
}

module internal_screw_mounts()
{
    // Speaker screw mounts
    render_speaker_mounts();

    // PCB screw mounts
    move([-14.5,66.5,0]) pcb_screw_mount();
    move([-4.5,-13.5,0]) pcb_screw_mount();
}

module render_speaker_panel(crend)
{
    if (crend) color(c_black()) speaker_panel(); else speaker_panel();
    if (crend) color(c_black()) panel_mounts(); else panel_mounts();
    if (crend) color(c_black()) internal_screw_mounts(); else internal_screw_mounts();
    if (crend) color(c_black()) pen_holder(); else pen_holder();
}
