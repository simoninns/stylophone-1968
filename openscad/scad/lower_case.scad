/************************************************************************

    lower_case.scad
    
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

module battery_compartment()
{
    move([30.5,47 - 35,2 + (13/2)]) {
        // Shell is 1.5mm thick
        difference() {
            cuboid([31,57,12.5]);
            move([1.5,0,1.5]) cuboid([31,57 - 3,16]);
        }
    }
}

module lower_base()
{
    difference() {
        // Shell is 2.5mm thick
        prismoid(size1=[91,151], size2=[91 + 5,151 + 5], h=9);
        move([0,0,2.5]) prismoid(size1=[91 - 2.5,151 - 2.5], size2=[91 + 5 - 2.5,151 + 5 - 2.5], h=9);

        // Cut out for tuning pot.
        move([-45 + 38,75 - 53, 2.55 / 2]) {
            cyl(d=33, h=5);
        }
    }

    // Add the top lip
    move([0,0,9 + (2.5 / 2)]) {
        difference() {
            cuboid([91 + 5 - 2,151 + 5 - 2, 2.5]);
            cuboid([91 + 5 - 2 - 2,151 + 5 - 2 - 2, 5]);
        }
    }

    // Add the opening tab
    move([0,83,7.75]) rotate([90,0,0]) prismoid(size1=[10,2.5], size2=[11,3.5], h=6, shift=[0,-0.5]);

    // Add the retaining tabs
    move([30,76.25,7.5 + 4]) {
        cuboid([6.5,1.5,8]);

        difference() {
        move([0,0,2]) rotate([90,0,0]) cyl(l=2.75, d=4, fillet=1.25);
        move([0,-1,0]) cuboid([6.5,1.5,8]);
        }
    }

    move([-30,76.25,7.5 + 4]) {
        cuboid([6.5,1.5,8]);

        difference() {
        move([0,0,2]) rotate([90,0,0]) cyl(l=2.75, d=4, fillet=1.25);
        move([0,-1,0]) cuboid([6.5,1.5,8]);
        }
    }

    // Add the retaining clips
    move([36,-77,7.5 + 3]) {
        difference() {
            rotate([0,90,0]) cyl(d=2, h=6.5);
            move([0,0,-0.5]) cuboid([7,3,1]);
            move([0,1,-0.5]) cuboid([7,2,4]);
        }
    }

    move([-36,-77,7.5 + 3]) {
        difference() {
            rotate([0,90,0]) cyl(d=2, h=6.5);
            move([0,0,-0.5]) cuboid([7,3,1]);
            move([0,1,-0.5]) cuboid([7,2,4]);
        }
    }
}

module tuning_pot_cavity()
{
    move([-45 + 38,75 - 53, 0]) {
        difference() {
            difference() {
                cyl(d=35, h= 13.5 * 2, fillet = 13);
                move([0,0,-33/2]) cuboid([38,38,33.25]);
                cyl(d=11, h=40);
            }

            move([0,0,-1.5]) cyl(d=38 - 4, h= 13.5 * 2, fillet = 13);
        }
    }
}

module render_lower_case(crend)
{
    if (crend) {
        color(c_white()) move([0,0,-15]) {
            lower_base();
            battery_compartment();
            tuning_pot_cavity();
        }
    } else {
        move([0,0,-15]) {
            lower_base();
            battery_compartment();
            tuning_pot_cavity();
        }
    }
}