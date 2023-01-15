/************************************************************************

    pcb.scad
    
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

module pcb_keyboard(isCutout)
{
    thickness = isCutout ? 0.5:0.25;
    depth = isCutout ? 0:-0.25;

    move([47 - 4,-46 - 5,depth]) {
        // Orientate by left lower edeg
        move([-10.5,6.25,0]) {
            // Each flat key is 9.5mm with a .5mm gap
            // There are 12 normal keys
            difference () {
                union() {
                    for (x = [0:120/12:120 - 1]) {
                        move([0,x,0]) cuboid([21, 9.5, thickness]);
                    }

                    move([0,-0.5,0]) cuboid([21, 10.5, thickness]);
                    move([0,110 + 0.5,0]) cuboid([21, 10.5, thickness]);
                }

                // // Clear material for the sharp keys
                for (x = [0:120/12:110 - 1]) {
                    if (x != 1*(120/12) && x != 4*(120/12)  && x != 8*(120/12)) {
                        move([-6,x + 5,0]) cuboid([12, 10.25, 2], chamfer = 1.5, edges=EDGES_Z_RT);
                    }
                } 
            }

            // // Add sharp/flat keys
            for (x = [0:120/12:110 - 1]) {
                if (x != 1*(120/12) && x != 4*(120/12)  && x != 8*(120/12)) {
                    move([-5.5,x + 5,0]) cuboid([10, 9.5, thickness], chamfer = 1.5, edges=EDGES_Z_RT);
                }
            }
        }
    }
}

// Note: L shaped cutout is a simplification of the original shape
module pcb()
{
    difference() {
        union() {
            move([0,0,(-1.75/2)]) {
                difference() {
                    cuboid([93,153,1.75]); // Actual micrometer measurement was 1.66mm
                    move([-25 - 1,-54 - 1,0]) cuboid([93 - 52 + 1,153 - 109 + 1,4]);
                } 
            }
        }

        // Screw holes
        move([-14.5,66.5,-1]) cyl(h=5, d=3);
        move([-4.5,-13.5,-1]) cyl(h=5, d=3);

        // Remove material for keyboard
        pcb_keyboard(true);
    }
}

module pcb_switch()
{
    // 10x23x1
    difference() {
        cuboid([23,10,1]); // Main body
        move([9.5 - 1,0,0]) cuboid([4,7,2]);
        move([-9.5 + 1,0,0]) cuboid([4,7,2]);
    }

    move([0,0,3]) cuboid([5,5,5]); // Knob
}

module pcb_switches()
{
    move([35,-71.25,0.75]) pcb_switch();
    move([35,-71.25 + 10.75,0.75]) pcb_switch();
}

module pcb_jack_body()
{
    move([-0.5,-68.75,-6.75]) cuboid([10,15.5,10]);
}

module pcb_jack_socket()
{
    move([-0.5,-78,-7.5]) {
        difference() {
            rotate([90,0,0]) cyl(h=3, d=6);
            move([0,-1,0]) rotate([90,0,0]) cyl(h=3, d=4);
        }
    }
}

module pcb_jack(crend)
{
    if (crend) color(c_black()) pcb_jack_body(); else pcb_jack_body();
    if (crend) color(c_silver()) pcb_jack_socket(); else pcb_jack_socket();
}

module pcb_tuning_pot()
{
    move([46.5 - 53,76.5 - 55,-10]) cyl(h=17, d=5.5);
}

module render_pcb(crend)
{
    if (crend) color(c_pcb()) pcb(); else pcb();
    if (crend) color(c_black()) pcb_switches(); else pcb_switches();
    if (crend) color(c_silver()) pcb_keyboard(false); else pcb_keyboard(false);
    pcb_jack(crend);
    if (crend) color(c_black()) pcb_tuning_pot(); else pcb_tuning_pot();
}