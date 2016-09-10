
//-----------------------------------------------------------
//--------------------BOTTOM----------------------------
//-----------------------------------------------------------



module LOADCELLHOLDER() {
	
	difference () { 

		   cube ([55,12.5,25.4], center=true);  //bottom
        	translate ([0,0,27.5])  //lower left display holder
            
         #LOADCELL();

        translate ([24,0,-1])   //left
        rotate (90,[1,0,0])
        #cylinder (50, r=1.7,center=true,$fn=50); // 1.6=tight 3mm screw hole

        translate ([10,0,3])   //2
        rotate (90,[1,0,0])
        #cylinder (50, r=1.7,center=true,$fn=50); // 1.6=tight 3mm screw hole
     
     
        translate ([-24,0,-1])   //right
        rotate (90,[1,0,0])
        #cylinder (50, r=1.7,center=true,$fn=50); // 1.6=tight 3mm screw hole

        translate ([-10,0,3])   //2
        rotate (90,[1,0,0])
        #cylinder (50, r=1.7,center=true,$fn=50); // 1.6=tight 3mm screw hole
        
        
    }
    
    


    }





module screwhole(height) {
    	difference () { 
    	    
          cylinder (h=height, r=2.6,center=false,$fn=50); // 1.6=tight 3mm screw hole
          cylinder (h=(height+1), r=1.5,center=false,$fn=6); // 1.6=tight 3mm screw hole
	    }

    }

//-----------------------------------------------------------
//---------------------LOADCELL---------------------------
//-----------------------------------------------------------

module LOADCELL() {

	
		color ([ 0.1,0.1,0.1,0.8])
		cube ([12.9,12.9,80.5], center=true); 
		
        translate ([0,0,35])   //top
        rotate (270,[0,1,0])
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=2.1, h=70, center=true, $fn=40); //bolt

        
        translate ([0,0,20])   //below top
        rotate (270,[0,1,0])
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=2.1, h=70, center=true, $fn=40); //bolt

        translate ([0,0,-20])   //above bottom
        rotate (270,[0,1,0])
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=2.5, h=70, center=true, $fn=40); //bolt
    
        translate ([0,0,-35])   //bottom
        rotate (270,[0,1,0])
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=2.5, h=70, center=true, $fn=40); //bolt

/*forsenkning
        
        translate ([0,0,-20])   //above bottom left
        rotate (270,[0,1,0])
        translate ([0,0,-25.3])   
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=4, h=4.5, center=true, $fn=40); //bolt
    
        translate ([0,0,-35])   //bottom
        rotate (270,[0,1,0])
        translate ([0,0,-25.3])   
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=4, h=4.5, center=true, $fn=40); //bolt

        translate ([0,0,-20])   //above bottom right
        rotate (270,[0,1,0])
        translate ([0,0,25.3])   
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=4, h=4.5, center=true, $fn=40); //bolt
    
        translate ([0,0,-35])   //bottom
        rotate (270,[0,1,0])
        translate ([0,0,25.3])   
	    color ([ 0.2,0.2,0.2,0.8])
		cylinder (r=4, h=4.5, center=true, $fn=40); //bolt
*/
}

module SLEDHOLDER() {

		difference () { 

    union() {
		   translate ([0,6,0])      
           cube ([20,63,12.5], center=true);  //pylon
           translate ([0,-30,0])   
           cube ([20,14,40], center=true);  //top part
  
           
        }
                

        translate ([6,34,0])   //lower screw hole
        #cylinder (50, r=1.7,center=true,$fn=50); // 1.6=tight 3mm screw hole

        translate ([-6,26,0])   //upper screw hole
        #cylinder (50, r=1.7,center=true,$fn=50); // 1.6=tight 3mm screw hole
        
        translate ([0,-30,0])   
        cube ([24,7,32], center=true);  //sled model

        translate ([0,-35,0])   
        cube ([24,7,23], center=true);  //sled grip top hole 

        translate ([7,-35,0])   
        #cube ([6,4,45], center=true);  //sled grip width reduction

        translate ([-7,-35,0])   
        #cube ([6,4,45], center=true);  //sled grip width reduction
    }
    
        
    }
        

module MOTORMOUNT() {

difference () {
	union () { 
        
		color ([ 0.1,0.1,0.1,0.8])
		cylinder (r=20, h=2.5, center=true, $fn=200); //bolt
		
        //rotate (45,[0,0,45])    
        translate ([0,0,9])   //mount box
        cube ([14,30,18], center=true); 
          
        
    }
    
    
        translate ([0,0,10.3])   //mount box (horizontal slot)
        #cube ([6.5,30,18], center=true); 
	
        translate ([0,0,10.3])   //mount box (vertictal slot)
        cube ([30,20,18], center=true); 
	
    
        rotate (45,[0,0,45])    
        translate ([0,10,0])   //mount slot
        cube ([3,12,8], center=true); 
    
        rotate (45,[0,0,45])    
        translate ([0,-10,0])   //mount slot
        cube ([3,12,8], center=true); 
    
        rotate (135,[0,0,1])    
        translate ([0,10,0])   //mount slot
        cube ([3,12,8], center=true); 
    
        rotate (135,[0,0,1])    
        translate ([0,-10,0])   //mount slot
        cube ([3,12,8], center=true); 
    
    
        translate ([0,12.5,15])   //left locking pin
        rotate (90,[0,1,0])    
        #cylinder (r=1, h=50, center=true, $fn=40); 

        translate ([0,-12.5,15])   //rear locking pin
        rotate (90,[0,1,0])        
        #cylinder (r=1, h=50, center=true, $fn=40); 

        translate ([0,0,0])   //left locking pin
        #cylinder (r=4.5, h=10, center=true, $fn=40); 
    
}
}


module SLED() {

        
				
      difference() {
       
        translate ([0,0,93])   //main sled plate
        cube ([6,30,145], center=true); 
        
        translate ([0,12.5,33])   //front locking pin
        rotate (90,[0,1,0])    
        #cylinder (r=1, h=50, center=true, $fn=40); 

        translate ([0,-12.5,33])   //rear locking pin
        rotate (90,[0,1,0])    
        #cylinder (r=1, h=50, center=true, $fn=40); 
          
        translate ([0,0,27])   //motor-axle-slot
        #cube ([9.5,9.5,15], center=true); 
 
        translate ([0,0,108])   //loadcell-slot
        #cube ([14,14,30], center=true); 
 
        translate ([0,12.5,60])   //front locking slot 1
        #cube ([10,5,10], center=true); 
        translate ([0,-12.5,60])   //front locking slot 2
        #cube ([10,5,10], center=true); 

        translate ([0,12.5,145])   //rear locking slot 1
        #cube ([10,5,10], center=true); 
        translate ([0,-12.5,145])   //rear locking slot 2
        #cube ([10,5,10], center=true); 

     //   translate ([0,0,18]) 
  //     #MOTORMOUNT();

    }
        
        
		
}


////  UNCOMMENT INDIVIDUAL PARTS TO PRINT


module BODY(option) {

if (option==0)  {
rotate (90,[1,0,0])
LOADCELLHOLDER();
}

if (option==1)  {  
translate ([60,0,0])   
MOTORMOUNT();
}

if (option==2)  {
translate ([-60,0,0])
rotate (90,[0,1,0])
SLED();
}
		

if (option==3)  {
rotate (90,[0,1,0])
translate ([-120,0,0])
SLEDHOLDER();
}

if (option==4)  {

rotate (-90,[1,0,0])
translate ([-90,0,0])
SLEDHOLDER();

rotate (-90,[1,0,0])
translate ([-4,0,0])
SLEDHOLDER();

rotate (270,[0,1,0])
translate ([30,0,-56])
SLED();

rotate (-90,[0,1,0])
translate ([30,0,-38])   
MOTORMOUNT();
    
}
}







//number defines printable parts, or display
BODY(4); //0=LOADCELLHOLDER, 1=MOTORMOUNT, 2=SLED ,3=SLEDHOLDER, 4=assembled view

////