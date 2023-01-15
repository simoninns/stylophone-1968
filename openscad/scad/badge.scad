/************************************************************************

    badge.scad
    
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

module logotype(toPrint)
{
    originx = toPrint ? 0:-34;
    originy = toPrint ? 0:3;
    originz = toPrint ? 1.5:12;
    rotation = toPrint ? 180:0;

    move([originx,originy,originz]) rotate([rotation,0,0]) {
        rotate([0,0,90]) {
            linear_extrude(height=1) {
                import("slogotype_70s.svg");
            }
        }

        // Add mounting tabs for the logotype
        move([0.2,12,-0.5]) cuboid([0.75,4,1]);
        move([4.33,12,-0.5]) cuboid([0.75,4,1]); // *
        move([3.7,32,-0.5]) cuboid([0.75,1.5,1]); // *
        move([1,38.5,-0.5]) cuboid([0.75,1.5,1]);
        move([3.7,48,-0.5]) cuboid([0.75,1.5,1]); // *
        move([3.75,60,-0.5]) cuboid([0.75,1.5,1]);
    }
}

module badge(toPrint)
{
    originx = toPrint ? 0:-32.5;
    originy = toPrint ? 0:34.5;
    originz = toPrint ? 0.5 + 0.125:11.5;
    rotation = toPrint ? 180:0;

    move([originx,originy,originz]) rotate([rotation,0,0]) {
        difference() {
            union()  {
                cuboid([13,70,1.25]);
                move([0,0,-1]) cuboid([13 - 6,70 - 6.5, 2]);
            }

            // Add mounting holes for the logotype
            move([-1.5,-31.5,0]) {
                move([0.2,12,-0.5]) cuboid([0.75,4,10]);
                move([4.33,12,-0.5]) cuboid([0.75,4,10]); // *
                move([3.7,32,-0.5]) cuboid([0.75,1.5,10]); // *
                move([1,38.5,-0.5]) cuboid([0.75,1.5,10]);
                move([3.7,48,-0.5]) cuboid([0.75,1.5,10]); // *
                move([3.75,60,-0.5]) cuboid([0.75,1.5,10]);
            }
        }

        // Add clips to affix the badge to the speaker grill
        move([+3.5,23,-3]) {
            cuboid([1,10, 1], chamfer=0.5);
            move([-0.4,0,0.25]) cuboid([0.8,10,1.5], chamfer=0.5, edges=EDGES_X_BOT);
        }
        move([+3.5,0,-3]) {
            cuboid([1,10, 1], chamfer=0.5);
            move([-0.4,0,0.25]) cuboid([0.8,10,1.5], chamfer=0.5, edges=EDGES_X_BOT);
        }
        move([+3.5,-26,-3]) {
            cuboid([1,8, 1], chamfer=0.5);
            move([-0.4,0,0.25]) cuboid([0.8,8,1.5], chamfer=0.5, edges=EDGES_X_BOT);
        }

        move([-3.5,0,-3]) {
            cuboid([1,62, 1], chamfer=0.5);
            move([0.4,0,0.25]) cuboid([0.8,62,1.5], chamfer=0.5, edges=EDGES_X_BOT);
        }
    }
}

module render_logotype(crend, toPrint)
{
    if (crend) color(c_silver()) logotype(toPrint); else logotype(toPrint);
}

module render_badge(crend, toPrint)
{
    if (crend) color(c_black()) badge(toPrint); else badge(toPrint);
}