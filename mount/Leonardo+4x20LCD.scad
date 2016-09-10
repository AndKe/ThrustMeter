
//-----------------------------------------------------------
//--------------------BOTTOM----------------------------
//-----------------------------------------------------------


include <arduino.scad>
unoDimensions = boardDimensions( UNO );


module bottom() {
	
	difference () { 

		union(){
	    cube ([100,68,2], center=true);  //bottom
        	translate ([-47,-24,0])  //lower left display holder
            screwhole(34);
           	translate ([47,-24,0])   //lower right display holder
            screwhole(34);

            translate ([-47,31,0])  //upper left display holder
            screwhole(34);
           	translate ([47,31,0])   //upper right display holder
            screwhole(34);

        	rotate (270,[0,0,1])
            translate( [-(unoDimensions[0] - 33), -26, -1] ) union() {
            standoffs(LEONARDO, mountType=TAPHOLE, height=6);
            //boardShape(LEONARDO, offset = 3);
        }

		}
	
		}

    }





module screwhole(height) {
    	difference () { 
    	    
          cylinder (h=height, r=2.6,center=false,$fn=50); // 1.6=tight 3mm screw hole
          cylinder (h=(height+1), r=1.5,center=false,$fn=6); // 1.6=tight 3mm screw hole
	    }

    }
//-----------------------------------------------------------
//---------------------S100 Holder----------------------------
//-----------------------------------------------------------
module S100HOLDER() { 

$pt=3.2; //(plate thickness)
$bp=3.2; //bottom plate thickness
$hp=3; //holder plate thickness
$w = 107;  //camera width
$h1= 68.5; // height on bearing side
$h2= 68.5; // height on servo side


	translate ([0,0,-32])
	cube ([$w,20,$bp], center=true); //bottom plate

			
	translate ([$w/2-$pt*2.5+2,0,$h2/2+2])
	cube ([15,20,$hp], center=true); //servo side top camera-holder

	translate ([-$w/2+$pt*2.5-2,0,$h1/2+2.4])
	cube ([15,20,$hp], center=true); //bearing side top  camera-holder



	difference() {
		translate ([-$w/2,0,1])
		cube ([$pt,20,$h1], center=true); //right side (ball bearing)

		
		translate ([0.4-$w/2,0,3])
		rotate (90,[0,1,0])
		#F683zz(10);

	 }

	difference() {
		union() {
			translate ([$w/2,0,1])
			cube ([$pt,20,$h2], center=true); //left side, (servo)
	        }

		translate ([$w/2,0,3])
		rotate (270,[0,1,0])
	   	#cylinder (h=14, r=1.5,center=true,$fn=6); // 1.6=tight 3mm screw hole

	}




}

//-----------------------------------------------------------
//---------------------S100----------------------------
//-----------------------------------------------------------
// ring on lens increased in length.
module S100() {

	
		color ([ 0.1,0.1,0.1,0.8])
		translate ([0,0,0])
		cube ([100,20,61], center=true); 
		
		translate ([-56,-5,14.5])
		color ([ 0.2,0.2,0.2,0.8])
		cube ([18,7,10], center=true); //USB plug
	
		rotate (90,[1,0,0])
		translate ([13,0,14,])
		color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=25, h=8, center=true, $fn=40); //Lens
		
		rotate (90,[0,0,1])
		translate ([0,-11.5,-35,])
		color ([ 0.6,0.6,0.6,0.8])
		cylinder (r=3.8, h=10, center=true, $fn=10); //bottom screw


}




//-----------------------------------------------------------
//---------------------HS65----------------------------
//-----------------------------------------------------------

module HS65(bolts) {
	if (bolts > 0)  {  
		color ([ 0,0,0,0.8]) {
				cube ([12,32.5,2], center=true);   //plate with holes
		
				translate ([0,-14.3,0])
				cylinder (r=0.8, h=15, center=true, $fn=6); //left side center hole
				
				translate ([0,14.3,0])
				cylinder (r=0.8, h=15, center=true, $fn=6); //right side center hole

	if (bolts == 2)  {  

			translate ([0,6,13])
			rotate (180,[0,0,0])
			MXLPulley();
			}
		}
	}
else
	{
		color ([ 0,0,0,0.8]) {
			difference() {
				cube ([12,32.5,2], center=true);   //plate with holes
		
				translate ([0,-14.3,0])
				cylinder (r=1.2, h=10, center=true, $fn=6); //left side center hole
				
				translate ([0,14.3,0])
				cylinder (r=1.2, h=10, center=true, $fn=6); //right side center hole
		
			}
		}

	}

	translate ([0,0,-8.15])
			cube ([12,24,20.4], center=true);   //main body (real y=24.5)
		
			translate ([0,4.2,5.3])
			cube ([12,15.2,6.5], center=true);  //gearbox
	
			translate ([0,13,-14])
			cube ([7,3,5], center=true);  //cable output
	
	
	translate ([0,6,10])
			color ([ 1,1,1,0.7]) 
		 	cylinder (r=2.25, h=5, center=true, $fn=6); // drive shaft

}


//-----------------------------------------------------------
//---------------------F683zz----------------------------
//-----------------------------------------------------------
//3x7x3mm Shielded Bearing Sizes
//xtend variable prolongs the shaft
module F683zz($xtend) {    

$bore = 3; //Bore
$outer_d = 7.2; //Outer Diameter
$flange_o = 8.3;  //Flange Outer Diameter
$flange_w = 0.8; //Flange Width (part of the bearing width)
$width = 3;  //Bearing width


	color ([ 0.5,0.6,0.2,0.8])	{	
		cylinder (r=($outer_d/2), h=$width, center=true, $fn=24); // main body
		translate ([0,0,($width/2-$flange_w/2)])
   		cylinder (r=($flange_o/2), h=$flange_w, center=true, $fn=24); //Flange 
		cylinder (r=$bore/2, h=$width+$xtend, center=true, $fn=24); // intended ring
	}
}


//-----------------------------------------------------------
//---------------------MXLPulley----------------------------
//-----------------------------------------------------------

module MXLPulley() {   		
$bore = 3; //Bore
$outer_d = 20; //Outer Diameter
$flange_o = 25;  //Flange Outer Diameter
$flange_w = 1; //Flange Width (part of the bearing width)
$width = 8.8;  //Bearing width

difference() {
		union() {
				color ([ 0.5,0.6,0.2,0.8])	{	
				cylinder (r=($outer_d/2), h=$width, center=true, $fn=24); // main body
				translate ([0,0,($width/2-$flange_w/2)])
		   		cylinder (r=($flange_o/2), h=$flange_w, center=true, $fn=24); //Flange 
					}
	cylinder (r=$bore/2, h=$width+2, center=true, $fn=6); // intended ring

		}
	}
}
//-----------------------------------------------------------
//---------------------MXLRing----------------------------
//-----------------------------------------------------------

module MXLRing() {   		
$bore = 3; //Bore
$outer_d = 28; //Outer Diameter
$flange_o = 30;  //Flange Outer Diameter
$flange_w = 1; //Flange Width (part of the bearing width)
$width = 6;  //Belt area width

difference() {
		union() {
   	color ([ 0.5,0.6,0.2,0.8])	{	
		cylinder (r=($outer_d/2), h=$width, center=true, $fn=50); // main body
		translate ([0,0,($width/2-$flange_w/2)])
   		cylinder (r=($flange_o/2), h=$flange_w, center=true, $fn=50); //Flange 
		}
		}

		cylinder (r=$bore/2, h=$width+2, center=true, $fn=7); // hole
	 	translate ([0,0,-2])  
		cylinder (r=($outer_d/2-1.5), h=$width-3, center=true, $fn=50); // main body reduction
}
	}


//-----------------------------------------------------------
//---------------------Mounts----------------------------
//-----------------------------------------------------------
module MOUNTV3M() {    

	difference () {
		cube ([6,6,18], center=true); //
	 	translate ([0,0,7])  
	    cylinder (r=1.6, h=16, center=true, $fn=6); 
	
		translate ([5,0,-5])		
		rotate (40,[0,1,0])
		cube ([12,6.1,18], center=true); //

	}
}

//-----------------------------------------------------------
module MOUNT3M() {    

	difference()  {
			cube ([6,6,6], center=true);  //add lower mount
			cylinder (h=14, r=1.7,center=true,$fn=6); //3mm screw hole is 1.7
		}

}

//-----------------------------------------------------------
//---------------------BODY----------------------------
//-----------------------------------------------------------
module BODY(option) {


	if (option==1)  {  


		difference (){
			S100HOLDER(); 
		
			translate ([0,0,0.5])
			#S100();  //
			}		
				translate ([5,1,63])
				rotate (90,[1,0,0])
				topbar();  

	translate ([58.5,0,3.1])
	rotate (90,[0,1,0])
	MXLRing();

	translate ([5,-0.5,70])
	rotate (180,[0,1,0])
	Hanger();

	}

if (option==2)  {     //with topbar - printable

		difference (){
			S100HOLDER(); 
		
			translate ([0,0,0.5])
			#S100();  //

		}
				translate ([0,7,56])
				rotate (90,[1,0,0])
				topbar();  
	
	translate ([0,7,25])
	rotate (270,[1,0,0])
	MXLRing();

	rotate (90,[1,0,0])
	translate ([35,70,2.5])
	Hanger();

}
		

if (option==0)  {    //no topbar, printable

		difference (){
			S100HOLDER(); 
		
			translate ([0,0,0.5])
			#S100();  //
//				translate ([4.5,1,51])
//				rotate (90,[1,0,0])
//				topbar();  
	
 }
	rotate (90,[1,0,0])
	translate ([0,50,2.5])
	Hanger();

}
}

bottom();
