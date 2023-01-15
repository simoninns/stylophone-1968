/************************************************************************

    speaker_bracket.scad
    
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

function speakerx() = -16;
function speakery() = -46;
function speakerz() = 6;

module speaker_bracket()
{
    move([speakerx(), speakery(), speakerz()]) rotate([180,0,223]) {
        difference() {
            union() {
                cyl(h=4, d=49 + 8); // Speaker is 57mm dia

                hull() {
                    rotate([0,0,0]) move([33.5,0,1]) cyl(h=2, d=8);
                    move([0,0,1]) cyl(h=2, d=8);
                }

                hull() {
                    rotate([0,0,-95]) move([33.5,0,1]) cyl(h=2, d=8);
                    move([0,0,1]) cyl(h=2, d=8);
                }

                hull() {
                    rotate([0,0,104]) move([33.5,0,1]) cyl(h=2, d=8);
                    move([0,0,1]) cyl(h=2, d=8);
                }
            }

            move([0,0,-2]) cyl(h=4, d=49 + 4);
            cyl(h=6, d=49);

            rotate([0,0,0]) move([33.5,0,1]) cyl(h=4, d=3.5);
            rotate([0,0,-95]) move([33.5,0,1]) cyl(h=4, d=3.5);
            rotate([0,0,104]) move([33.5,0,1]) cyl(h=4, d=3.5);

            // Counter sink
            rotate([0,0,0]) move([33.5,0,1]) cyl(h=3, d1=2, d2=7);
            rotate([0,0,-95]) move([33.5,0,1]) cyl(h=3, d1=2, d2=7);
            rotate([0,0,104]) move([33.5,0,1]) cyl(h=3, d1=2, d2=7);
        }
    }
}

module render_speaker_bracket(crend)
{
    if (crend) color(c_black()) speaker_bracket();
    else speaker_bracket();
}

module speaker_mount()
{
    difference() {
        cyl(h=4, d=8);
        cyl(h=6, d=2.5);
    }

    // This end cap is to prevent supports being placed
    // inside the mount
    move([0,0,1.75 + 0.125]) cyl(h=0.25, d=2.25);
}

module render_speaker_mounts()
{
    move([speakerx(), speakery(), speakerz() + 2.5]) rotate([180,0,223]) {
        rotate([0,0,0]) move([33.5,0,1]) speaker_mount();
        rotate([0,0,-95]) move([33.5,0,1]) speaker_mount();
        rotate([0,0,104]) move([33.5,0,1]) speaker_mount();
    }
}