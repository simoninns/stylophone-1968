/************************************************************************

    metal_grill.scad
    
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

module metal_grill()
{
    move([0,0,11]) {
        difference() {
            // Render the grill
            union() {
                grill_width = 147;
                grill_height = 50;

                difference() {
                    union() {
                        move([-42.5,0,0]) {
                            for (y = [0:51/20:50.5 - 1]) {
                                move([y,0,0]) rotate([90,0,0]) cyl(h=grill_width, d=2, $fn=16);
                            }
                        }

                        move([-17.75,-73,0]) {
                            for (x = [0:147/27:147 - 1]) {
                                move([0,x + 3,0]) rotate([0,90,0]) cyl(h=grill_height, d=1, $fn=16);
                            } 
                        }
                    }            

                    // Slice the base
                    move([-18.5,0,-1]) {
                        cuboid([52,152,2]);
                    }
                }
            }

            // Cut out for badge
            move([-37 + 4.5, 34.5, 0]) {
                cuboid([13.5,70.5,6]);
            }
        }
    }
}

module render_metal_grill(crend)
{
    if (crend) color(c_silver()) metal_grill(); else metal_grill();
}