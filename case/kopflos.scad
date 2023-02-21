/*
 * Kopflos Case
 * Copyright (c) 2022 Lone Dynamics Corporation. All rights reserved.
 *
 * required hardware:
 *  - 4 x M3 x 25mm countersunk bolts
 *  - 4 x M3 nuts
 *
 */

$fn = 100;

board_width = 60;
board_thickness = 1.5;
board_length = 70;
board_height = 1.6;
board_spacing = 2;

wall = 1.5;

top_height = 17;
bottom_height = 8;

//mds_board();

translate([0,0,15])
	mds_case_top();

//translate([0,0,-15])
//	mds_case_bottom();

module mds_board() {
	
	translate([wall, wall, 0]) {
		difference() {
			color([0,0.5,0])
				roundedcube(board_width,board_length,board_thickness,3);
			translate([5, 5, -1]) cylinder(d=3.2, h=10);
			translate([5, 65, -1]) cylinder(d=3.2, h=10);
			translate([55, 5, -1]) cylinder(d=3.2, h=10);
			translate([55, 65, -1]) cylinder(d=3.2, h=10);
		}	
	}
	
}

module mds_case_top() {
	
	difference() {
				
		color([0.5,0.5,0.5])
			roundedcube(board_width+(wall*2),board_length+(wall*2),top_height,2.5);

		// cutouts
		translate([2,9,-12])
			roundedcube(board_width-3,board_length-15,13.75,2.5);

		translate([2,9,-2])
			roundedcube(board_width-6,board_length-15,13.75,2.5);

		translate([9,3,-2])
			roundedcube(board_width-15,board_length-3,17.75,2.5);
		
		translate([wall, wall, 0]) {

			// vents
			translate([60/2-(30/2),60,0]) cube([30,1,20]);
			translate([60/2-(30/2),55,0]) cube([30,1,20]);
			translate([60/2-(30/2),50,0]) cube([30,1,20]);
					
			// Ethernet
			translate([40,18.5-(16/2),-1]) cube([30,16,14+1]);

			// USBA
			translate([40,38.5-(16/2),-1]) cube([30,16,15.7+1]);

			// USBC
			translate([40,55-(9.5/2),-1]) cube([30,9.5,3.5+1]);
		
			// SD
			translate([-5,25.3-(15/2),-1]) cube([30,15,2+1]);

			// PMODA
			translate([21.775-(15.6/2),-5,-1]) cube([15.6,30,5+1]);

			// PMODB
			translate([40.675-(15.6/2),65,-1]) cube([15.6,30,5+1]);

			// LED
			translate([-5,11.5-(1.5/2),3.5]) cube([25,1.5,1.5]);
				
			// bolt holes
			translate([5, 5, -21]) cylinder(d=3.5, h=40);
			translate([5, 65, -21]) cylinder(d=3.5, h=40);
			translate([55, 5, -20]) cylinder(d=3.5, h=40);
			translate([55, 65, -21]) cylinder(d=3.5, h=40);

			// flush mount bolt holes
			translate([5, 5, top_height-2]) cylinder(d=5, h=4);
			translate([5, 65, top_height-2]) cylinder(d=5, h=4);
			translate([55, 5, top_height-2]) cylinder(d=5, h=4);
			translate([55, 65, top_height-2]) cylinder(d=5, h=4);

			// eis text
			rotate(270)
				translate([-23.5,30-3,top_height-0.5])
					linear_extrude(1)
						text("K O P F L O S", size=5, halign="center",
							font="Ubuntu:style=Bold");

		}
		
	}	
}

module mds_case_bottom() {
	
	difference() {
		color([0.5,0.5,0.5])
			roundedcube(board_width+(wall*2),board_length+(wall*2),bottom_height,2.5);
		
		// cutouts
		translate([3,10,1.5])
			roundedcube(board_width-3,board_length-17,10,2.5);
				
		translate([10.5,2.5,1.5])
			roundedcube(board_width-17.5,board_length-2,10,2.5);

		translate([wall, wall, 0]) {
			
		// board cutout
		translate([0,0,bottom_height-board_height])
			roundedcube(board_width+0.2,board_length+0.2,board_height+1,2.5);

		translate([wall, wall, 0]) {

			// USB-C
			translate([39,55-(9.5/2),5]) cube([19.75,9.5,10.5+1]);
			
		}

		// bolt holes
		translate([5, 5, -11]) cylinder(d=3.2, h=25);
		translate([5, 65, -11]) cylinder(d=3.2, h=25);
		translate([55, 5, -11]) cylinder(d=3.2, h=25);
		translate([55, 65, -11]) cylinder(d=3.2, h=25);

		// nut holes
		translate([5, 5, -1]) cylinder(d=7, h=2.5+2, $fn=6);
		translate([5, 65, -1]) cylinder(d=7, h=2.5+2, $fn=6);
		translate([55, 5, -1]) cylinder(d=7, h=2.5+2, $fn=6);
		translate([55, 65, -1]) cylinder(d=7, h=2.5+2, $fn=6);

		}
		
	}	
}

// https://gist.github.com/tinkerology/ae257c5340a33ee2f149ff3ae97d9826
module roundedcube(xx, yy, height, radius)
{
    translate([0,0,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}
