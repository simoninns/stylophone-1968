/************************************************************************

    upper_case.scad
    
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

module upper_base()
{
    move([0,0, -15]) {
        difference() {
            // The base is slightly trapezoid and is 0.5mm narrower at the 
            // top than the bottom; walls are 2mm thick
            difference() {
                prismoid(size1=[98,158], size2=[97.5, 157.5], h=19);
                cuboid([94,154,50]);
            }

            // Top recess (for internal mount)
            move([0,0,18]) cuboid([94.5,154.5, 6]);

            // Jack socket od=10, id=6 and recess=1
            move([-0.5,-81, 7.5]) rotate([90,0,0]) {
                cyl(h=6, d=10);
                move([0,0,-2]) cyl(h=10, d=6.5); // Add 0.5mm to make it an easier fit
            }

            // These clip recesses must match the lower case
            move([0,0,-9]) {
                // Add the recesses for the retaining clips
                move([36,-77,7.5 + 3.5]) {
                    cuboid([6.5,1.5,1.5]);
                }
                move([-36,-77,7.5 + 3.5]) {
                    cuboid([6.5,1.5,1.5]);
                }

                // Add the retaining tabs
                move([30,76.25,7.5 + 4 + 2]) rotate([90,0,0]) cyl(l=2.75, d=4, fillet=1.25);
                move([-30,76.25,7.5 + 4 + 2]) rotate([90,0,0]) cyl(l=2.75, d=4, fillet=1.25);

                move([30,76.25,7.5 + 4]) rotate([19,0,0]) cuboid([8,1.5,8]);
                move([-30,76.25,7.5 + 4]) rotate([19,0,0]) cuboid([8,1.5,8]);
            }
        }

        // Add front clips to hold PCB under keyboard: 3x2mm, 1.5mm deep
        // Note: these are modified with a lower slope to assist printing
        move([46.5, 69 - 30, 14 - 1.5]) {
            cuboid([2,3,1]);
            move([0,0,-0.5]) rotate([180,0,180]) right_triangle([2, 3, 2], center=false);
        }
        move([46.5, -48 + 30, 14 - 1.5]) {
            cuboid([2,3,1]);
            move([0,0,-0.5]) rotate([180,0,180]) right_triangle([2, 3, 2], center=false);
        }
    }
}

// Internal mounting lip for speaker panel and PCB
module internal_mount()
{
    height = 3.75;

    // Internal lip for speaker panel/PCB
    difference() {
        union() {
            move([-14,0,height]) {
                move([0.5,0,-2.5]) {
                    difference() {
                        move([-1.5,0,0]) cuboid([67.5 - 3,154.5, 2.5]);
                        move([2.25 - 1,0,0.375]) cuboid([68.5 - 1.5,155 - 3.5, 6]);
                    }
                }
            }
        }

        // Remove material from slots
        move([-14,0,height]) {
            // Side tabs
            move([15,76.25 + 0.25,-2.5]) cuboid([10,2.5,2.51]);
            move([-15,76.25 + 0.25,-2.5]) cuboid([10,2.5,2.51]);
            move([-15,-76.25 - 0.25,-2.5]) cuboid([10,2.5,2.51]);

            // Back tabs
            move([-32.25 - 0.25,50,-2.5]) cuboid([1.75,10,2.51]);
            move([-32.25 - 0.25,0,-2.5]) cuboid([1.75,10,2.51]);
            move([-32.25 - 0.25,-50,-2.5]) cuboid([1.75,10,2.51]);
        }       
    }

    move([-14,0,height + 0.25]) {
        // Side tab surrounds
        move([ 15,  75.25,-2.75]) cuboid([14,1,2.5]); // 1mm Shorter to clear pen holder
        move([-15,  75.25,-2.75]) cuboid([14,1,2.5]);
        move([-15, -75.25,-2.75]) cuboid([14,1,2.5]);

        // Back tab cut-outs
        move([-31.25, 50,-2.75]) cuboid([1,14,2.5]);
        move([-31.25,  0,-2.75]) cuboid([1,14,2.5]);
        move([-31.25,-50,-2.75]) cuboid([1,14,2.5]);
    }
}

module keyboard_panel()
{
    // Keyboard is 154.5mm x 27.5mm x 2.5mm with a 1.5mm recess from the top lip
    difference() {
        union() {
            move([33.5,0,16.25 - 15]) cuboid([27.5, 154.5, 2.5]);

            // Lip to level with keyboard panel
            move([-14,0,4]) difference() {
                move([32.5,0,-2.75]) cuboid([2.75,154.5,2.5]);
                move([32.5,-65.5 - 0.125,-3.5]) cuboid([3,22.25,2.5]);
            }
        }

        // Cut-outs
        move([33.5,0,16.25 - 15])  {
            // Keyboard cut-out 120x20
            move([2.5 - 4,18 - 7.5,0]) hull() {
                move([5,0,0]) cuboid([12,120,10]);
                move([-5,0,0]) cuboid([8,112,10]);
            }

            // Switch cut-outs are 9x5
            move([9.5 - 10,-75 + 3.75,0]) {
                cuboid([9,5,10]);
                move([0,5 + 5.75,0]) cuboid([9,5,10]);
            }

            // Switch recess (thickness over switches is 1mm)
            move([-2.25,-65.5 - 0.125,-0.5 - 1]) cuboid([31, 22.25, 4]);
        }

        // Front tabs
        move([-14,0,4]) {
            move([32.75 - 0.125,50,-2.5 - 0.125]) cuboid([1.5,10,4]);
            move([32.75 - 0.125,0,-2.5 - 0.125]) cuboid([1.5,10,4]);
            move([32.75 - 0.125,-48,-2.5 - 0.125]) cuboid([1.5,10,4]);
        }
    }

    // Bumps for switches
    difference() {
        union() {
            move([11 + 11,-60.5,17 - 15]) {
                rotate([90,0,0]) cyl(h=6, d=1.5);
                move([22,0,0]) rotate([90,0,0]) cyl(h=6, d=1.5);

                move([0,-10.75,0]) {
                    rotate([90,0,0]) cyl(h=6, d=1.5);
                    move([22,0,0]) rotate([90,0,0]) cyl(h=6, d=1.5);
                }
            }
        }

        // Remove upper side of bumps
        move([32.5 + 1,0,16.25 - 15]) move([-1,-66.5,3]) cuboid([32, 24, 4]);
    }

    // Add a little material behind the front tabs for strength
    move([-16,0,4]) {
        move([33,50,-2.75]) cuboid([0.75,13,2.5]);
        move([33,0,-2.75]) cuboid([0.75,13,2.5]);
        move([33,-48,-2.75]) cuboid([0.75,13,2.5]);
    }
}

module render_upper_case(crend)
{
    if (crend) color(c_black()) upper_base(); else upper_base();
    if (crend) color(c_black()) internal_mount(); else internal_mount();
    if (crend) color(c_black()) keyboard_panel(); else keyboard_panel();
}