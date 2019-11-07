// By: Kurtis Alessi
// Model is of a parametric Buret Clamp
use <polyScrewThread_r1.scad> // Made by aubenc (Poor man's openscad screw library)
use <roundedcube.scad> // Made by Dan Upshaw
PI = 3.141592/1;


// VALUES TO CHANGE:
holdTwoBurettes = "YES"; // "YES" makes it hold two burettes

twoScrewHoles = "NO"; // LEGACY...DON'T USE..."YES" to enable two screw holes for main rod, anything else, won't enable
nut = "YES"; // "YES" to enable nut
screwCount = 1; // [0:3]Number of screws to show

rodHoleDiameter = 16; // Recomended making larger than actual size of rod
measuredBuretteDiameter = 15; // This value was found to work with a typical scientific burette

holeTolerance = 2;
screwHoleTolerance = 1.1; // Tolerance for screw-holes. (Scaled up by a factor of 1.1)

resolution = 100;
screwRes = PI/3;


//-------------Enable / Disable Specific Features in model-------------
body(); // toggle main body

//accessories(); // toggle additional fittings

//----------------------------------------------------------------

// Body dimensions
clampWidth = 80;
clampDepth = 30;
clampHeight = 34;

// Main hole dimensions
cutHeight = 50;
centerHoleRad = rodHoleDiameter/2;

// buret hole dimensions
buretteDiameter = measuredBuretteDiameter + (holeTolerance/4);
buretRad = buretteDiameter / 2;

//thread dimensions
od = 15;
st = 5;
lf0 = 55;
lt = 40;
cs = 2;

// Main Body
module body() {
    difference() {
        union() {
        //minkowski() {
            
        if (holdTwoBurettes != "YES") { // If not double clamp, remove extra material
            difference() {
                translate ([-clampWidth/2, -clampDepth/2, 0])cube([clampWidth, clampDepth, clampHeight]);
                translate([5, -25, -1]) cube([50, 50, 50]);
            }
        } else {
            translate ([-clampWidth/2, -clampDepth/2, 0])cube([clampWidth, clampDepth, clampHeight]);
        }

        baretTab();
        if (holdTwoBurettes != "YES") { // Eliminate plastic, make round if single
                translate([3, 0, 0]) cylinder(clampHeight, clampDepth/2, clampDepth/2);
        } 
        if (holdTwoBurettes == "YES") {
            translate([0,0,clampHeight]) rotate([180, 0, 180]) baretTab();
        }

       // rotate([0, 0, 45]) cube(16, $fn = resolution);
       // }
        }
        
        
        // Hole for center pole
        translate([0, 0, -5]) cylinder(cutHeight, centerHoleRad, centerHoleRad, $fn = resolution);
        
        // Hole for left buret
        translate([-clampWidth/1.8, 0, -5]) cylinder(cutHeight, buretRad, buretRad, $fn = resolution);
        
       // Slot cut out of tab 
       translate([-90, -6/2, -1]) cube([70, 6, 70]);
       translate([-85, -12/2, -1]) cube([40, 12, 70]);  
        
        if (holdTwoBurettes == "YES") {
            translate([clampWidth/1.8, 0, -5]) cylinder(cutHeight, buretRad, buretRad, $fn = resolution);  
        }
        
         // SCREW CUTOUTS MAIN
        translate([0, 0, 5]) scale([screwHoleTolerance, screwHoleTolerance, screwHoleTolerance]) rotate([0, 270 + 45, 90]) screw_thread(od,st,lf0,lt,screwRes,cs); // front main body screw hole

        if (twoScrewHoles == "YES") {
        translate([0, 0, 5]) scale([screwHoleTolerance, screwHoleTolerance, screwHoleTolerance]) rotate([0, 90 - 45, 90]) screw_thread(od,st,lf0,lt,screwRes,cs); // rear main body screw hole
       }
        
        //Trim Corners off main body
        //rotate([0, 0, 45]) translate([-clampWidth/1.35, clampWidth / 8, -1]) cube([clampHeight + 2, clampHeight + 2, clampHeight + 2]); // Front Left
        
      //  %rotate([0, 0, 45]) translate([-clampWidth + 70, -clampWidth - 75, -1]) cube([clampHeight + 2, clampHeight + 2, clampHeight + 2]); // Front Left
              
       // Remove unnecessary material
       translate([-26, -50, -1]) cylinder(clampHeight + 2, 42, 42, $fn=resolution);
       translate([-26, 50, -1]) cylinder(clampHeight + 2, 42, 42, $fn=resolution);

    if (holdTwoBurettes == "YES") {
        translate([26, -50, -1]) cylinder(clampHeight + 2, 42, 42, $fn=resolution);
        translate([26, 50, -1]) cylinder(clampHeight + 2, 42, 42, $fn=resolution);
        
        // Slot cut out of tab burette 2 
        translate([90, 6/2, -1]) rotate([180, 180, 0]) cube([70, 6, 70]);
        translate([85, 12/2, -1]) rotate([180, 180, 0]) cube([40, 12, 70]);
    }
        
    }
    difference() {
        //Cylinder for extended screw threads
        translate([0, 0, 5]) scale([screwHoleTolerance, screwHoleTolerance, screwHoleTolerance]) rotate([0, 270 + 45, 90]) cylinder(30, 8.5, 8.5);
        
        // Hole for center pole
        translate([0, 0, -5]) cylinder(cutHeight, centerHoleRad, centerHoleRad, $fn = resolution);
        
        // SCREW CUTOUTS MAIN
        translate([0, 0, 5]) scale([screwHoleTolerance, screwHoleTolerance, screwHoleTolerance]) rotate([0, 270 + 45, 90]) screw_thread(od,st,lf0,lt,screwRes,cs); // front main body screw hole

        if (twoScrewHoles == "YES") {
        translate([0, 0, 5]) scale([screwHoleTolerance, screwHoleTolerance, screwHoleTolerance]) rotate([0, 90 - 45, 90]) screw_thread(od,st,lf0,lt,screwRes,cs); // rear main body screw hole
       }
    }
}

module baretTab() {
    tabDepth = rodHoleDiameter * 1.1;
    tabHeight = 34;
    tabWidth = buretteDiameter * 3.5;
    cornerRad = 8;
    difference () {
        // Tab w/ rounded corners
        translate ([-clampWidth, -(tabDepth)/2, 0]) roundedcube([tabWidth, tabDepth, tabHeight], false, 12, "y");

// Original Square TAB HERE!
      //  translate ([-clampWidth, -(tabDepth)/2, 0]) cube([tabWidth, tabDepth, tabHeight]);        


       // Hole for screw  
       rotate([90, 0, 0]) translate ([-65, tabHeight / 2, -40]) cylinder(40,17.5/2,17.5/2, $fn = resolution);
       
       // Hex Nut Cutout
       rotate([90, 0, 0]) translate ([-65, tabHeight / 2, 6+1.5]) scale([1.05, 1.05, 1.05]) hex_nut(20,10,6,55,15,0.5);
       
        rotate([90, 0, 0]) translate ([-65, tabHeight / 2, 0]) cylinder(40,19/2,19/2, $fn = resolution);
        
       // Slot cut out of tab 
       translate([-90, -6/2, -1]) cube([74, 6, 70]); // Doesn't do anything anymore
        
        
    }


}

// Screw to be used
module tightenScrew() {
    union() {
        screw_thread(od,st,lf0,lt,screwRes,cs);
        translate([-40/2,-10/2,0]) cube([40, 10, 8]);
        cylinder(8, 8, 8, $fn = resolution);
    }
}

// Nut to be used
module tightenNut() {
    difference() {
        union() {
            cylinder(9, 10, 10);
            hex_nut(20,9,6,55,15,0.5);
        }
        translate([0,0,-1]) scale([screwHoleTolerance, screwHoleTolerance, screwHoleTolerance]) screw_thread(od,st,lf0,lt,screwRes,cs);
    
    }
    
}

module accessories() {
    // Nut
    if (nut == "YES") translate ([-50, -50, 0]) tightenNut();
    
    // Tightening Screw
    if (screwCount == 1) translate ([0, -50, 0])tightenScrew();
    
    // Tightening Screw
    if (screwCount == 2) {
        translate ([0, -50, 0])tightenScrew();
        translate ([50, -50, 0])tightenScrew();
    }
    
    // Tightening Screw
    if (screwCount == 3) {
        translate ([0, -50, 0])tightenScrew();
        translate ([100, -50, 0])tightenScrew();
        translate ([50, -50, 0])tightenScrew();
    }
}

/* REFERENCE
 * 100mm long threaded rod.
 *
 * od,st,lf0,lt,rs,cs
 * screw_thread(15,   // Outer diameter of the thread
 *               4,   // Step, traveling length per turn, also, tooth height, whatever...
 *              55,   // Degrees for the shape of the tooth 
 *                       (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
 *             100,   // Length (Z) of the tread
 *            PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
 *               0);  // Countersink style:
 *                         -2 - Not even flat ends
 *                         -1 - Bottom (countersink'd and top flat)
 *                          0 - None (top and bottom flat)
 *                          1 - Top (bottom flat)
 *                          2 - Both (countersink'd)
 */

 