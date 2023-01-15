/************************************************************************

    main.scad
    
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

// Local includes
include <lower_case.scad>
include <upper_case.scad>
include <speaker_panel.scad>
include <pcb.scad>
include <speaker_bracket.scad>
include <metal_grill.scad>
include <badge.scad>
include <stylus.scad>

// Rendering resolution
$fn=50;

// Select rendering parameters
use_colour = "Colour"; // [Colour, No colour]
for_printing = "Display"; // [Display, Printing]
display_speaker_panel = "Yes"; // [Yes, No]
display_upper = "Yes"; // [Yes, No]
display_lower = "Yes"; // [Yes, No]
display_grill = "Yes"; // [Yes, No]
display_badge = "Yes"; // [Yes, No]
display_logotype = "Yes"; // [Yes, No]
display_pcb = "Yes"; // [Yes, No]
display_bracket = "Yes"; // [Yes, No]
display_stylus = "Yes"; // [Yes, No]

// Render the required items
module main()
{
    crend = (use_colour == "Colour") ? true:false;
    toPrint = (for_printing == "Printing") ? true:false;

    dspeaker = (display_speaker_panel == "Yes") ? true:false;
    dupper = (display_upper == "Yes") ? true:false;
    dlower = (display_lower == "Yes") ? true:false;
    dgrill = (display_grill == "Yes") ? true:false;
    dbadge = (display_badge == "Yes") ? true:false;
    dlogotype = (display_logotype == "Yes") ? true:false;
    dpcb = (display_pcb == "Yes") ? true:false;
    dbracket = (display_bracket == "Yes") ? true:false;
    dstylus = (display_stylus == "Yes") ? true:false;

    if (dlower) {
        move([0,0,-9 - 0]) render_lower_case(crend);
    }

    if (dspeaker) {
        render_speaker_panel(crend);
    }

    if (dupper) {
        render_upper_case(crend);
    }

    if (dgrill) {
        render_metal_grill(crend);
    }

    if (dbadge) {
        render_badge(crend, toPrint);
    }

    if (dlogotype) {
        render_logotype(crend, toPrint);
    }

    if (dpcb) {
        render_pcb(crend);
    }

    if (dbracket) {
        render_speaker_bracket(crend);
    }

    if (dstylus) {
        render_stylus(crend, toPrint);
    }
}

main();