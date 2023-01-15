/************************************************************************

    stylus.scad
    
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

module stylus_body()
{
    difference() {
        union() {
            cuboid([6.5,69,6.5], chamfer = 0.5, edges=EDGES_Y_ALL);

            // Hull to tip of stylus
            hull() {
                move([0,35,0]) cuboid([6.5,1,6.5], chamfer = 0.5, edges=EDGES_Y_ALL);
                move([0,35 + 30,0]) rotate([90,0,0]) cyl(h=1, d=5);
            }

            // Small hull on top of stylus
            hull() {
                move([0,-34,  0]) cuboid([6,1,6], chamfer = 0.5, edges=EDGES_Y_ALL);
                move([0,-35,  0]) rotate([90,0,0]) cyl(h=0.5, d=1);
            }
        }

        // Hollow out for cable and nib
        move([0,68.5 - 21 + 1.5,0]) rotate([90,0,0]) cyl(h=32+2, d=3);

        // Slot for cable
        move([0,59.5 - 32, 3.25]) cuboid([2.5,10,1]);
        move([0,59.5 - 32 ,2.75]) rotate([90 - 17,0,0]) cyl(h=17, d=2.5);
    }

    // Add in missing material behind cable slot
    move([0,59.5 - 32 - 7.5, 2.25]) cuboid([2.5,5,2]);
    
}

// Note: the internal dimensions of the nib are just guess work.
// I wasn't willing to break a stylus to find out the actual dimensions
// but if you have a broken stylus please measure the metal nib
// dimensions and let me know.
module stylus_nib()
{
    // Nib
    difference() {
        move([0,68.5 - 3,0]) rotate([90,0,0]) cyl(h=8, d=4, fillet = 2);
        move([0,68.5 - 7,0]) rotate([90,0,0]) cyl(h=8, d=6);
    }

    move([0,68.5 - 5,0]) rotate([90,0,0]) cyl(h=4, d=2);
}

module render_stylus(crend, toPrint)
{
    originx = toPrint ? 0:12.5;
    originy = toPrint ? 0:38;
    originz = toPrint ? 0:8.75;
    rotation = toPrint ? 180:0;

    move([originx,originy,originz]) rotate([180,rotation,0]) {
        if (crend) color(c_black()) stylus_body(); else stylus_body();

        if (!toPrint) {
            if (crend) color(c_nib()) stylus_nib(); else stylus_nib();
        }
    }
}