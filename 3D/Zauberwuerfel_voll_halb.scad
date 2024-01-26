/*
*******************************************
Objekt Info: Parametriebarer Zauberwürfel

*******************************************
Version: 27.07.2022 khf
*******************************************
*/           

//***************   Auswahl   *************

//          1:Würfel  2:Halber Würfel 

                  part = "1";            

//*****************************************

//***************   Libraries  ************

//keine

//*****************************************

//***************  Parmeter   *************
f = 30;   // Anzahl der Fragmente
d = 20;   // Abstand der Einzelteile 20 - Demo = 40
c = 0.25;  // Abstände der Einzelteile Test 1: 0.5
g = 0.25;  // Abstände für den Kern    Test 1: 0.5
b = 2-(c/2); // Rundung

//*****************************************

//**************   Programm  **************

s = 20-c;    // Konstante
module rubikCube() //Vollansicht 
{    
     // Kern
     translate([0,0,0])
        piece_0(); // Kern des Würfels
    
     // 6 Kern-Teile
     for(r = [[0,0,0],[0,0,90],[0,90,0],[0,0,180],[0,0,-90],[0,-90,0]])
        rotate(r) 
           translate([d,0,0])  
              rotate([0,-90,0]) 
                 piece_1(); // Mittelteile Zentrum
 
  
     // 12 Kernteile
     for(r = [[0,0,0],[0,0,90],[0,90,0],[90,0,90]])
        rotate(r) 
           translate([d,d,0])  
              rotate([90,0,-90]) 
                 piece_2(); // Mittelteile oben

     for(r = [[0,0,0],[0,0,90],[0,90,0],[90,0,90]])
        rotate(r) 
           translate([-d,-d,0])  
              rotate([90,0,90]) 
                 piece_2(); // Mittelteile unten

     for(r = [[0,0,90],[0,180,90],[0,0,-90],[0,180,-90]])
        rotate(r+[0,0,0]) 
           translate([0,d,d])  
              rotate([0,90,-90])
                 piece_2(); // Ecken Mitte
     // 8 Ecken
     for(r = [[0,0,0],[0,0,90],[0,90,0],[0,90,90]])
        rotate(r) 
           translate([-d,-d,-d])  
              piece_3(); // Ecken unten

     for(r = [[0,0,0],[0,0,90],[0,90,0],[0,90,90]])
        rotate(r) 
           translate([d,d,d])  
              rotate([0,180,90])
                 piece_3(); // Ecken oben
}
//---------------------------------------------------------|
module rubikCubeHalf() //Schnittansicht 
{
   difference()
   {
      rotate([0,0,360*$t])
         translate([0,0,0]) 
            rubikCube();
             translate([0,50,0])
             color( "Red", 1.0 ) 
             cube([100,100,100],center=true); 
   }
}
//---------------------------------------------------------|
module piece_0() // Kern 
{
   difference()
   {
      translate([0,0,0])    
         sphere(d=35-g,$fn=f);
      translate([0,0,0])    
         sphere(d=20,$fn=f);
      for(i=[[0,0,0],[0,90,0],[90,0,0],
             [0,180,0],[0,-90,0],[-90,0,0]])
         rotate([i[0],i[1],i[2]])
            translate([0,0,10])    
               sphere(d=14+g,$fn=f);
      for(i=[[0,0,0],[0,90,0],[90,0,0],
             [0,180,0],[0,-90,0],[-90,0,0]])
         rotate([i[0],i[1],i[2]])
            translate([0,0,15])    
               cylinder(h=5,d=10+g,center=true,$fn=f);
   }
}
//---------------------------------------------------------|
module piece_1() // Mittelteil
{
   union()
   {
      difference()
      {
         translate([0,0,0])  
             block(s,b); 
         translate([0,0,20]) 
            sphere(d=48+c,$fn=f);
      }
      translate([0,0,0]) 
         cylinder(h=18,d=10-c,center=true,$fn=f);
      difference()
      {
         translate([0,0,10])    
            sphere(d=14-c,$fn=f);
//         translate([0,0,20]) 
//            sphere(d=20+c,center=true,$fn=f);
      }
      translate([0,0,10])    
         support_1();
   }
}
//---------------------------------------------------------|
module piece_2() // Mitte außen
{
   difference()
   {
      union()
      {
         difference()
         {
            translate([0,0,0])  
               block(s,b); 
            translate([20,0,20]) 
               sphere(d=48+c,$fn=f);
         }
         intersection()
         {
            translate([20,0,20]) 
               sphere(d=48-c,$fn=f);
            translate([5,0,5]) 
               cube([20-c,10-c,20-c],center=true); 
         }
         translate([2.5,0,2.5]) 
            cube([15-c,10-c,15-c],center=true); 
      }
      translate([20,0,20]) 
         rotate([0,45,0]) 
            sphere(d=35+c,$fn=f);
   }    
}
//---------------------------------------------------------|
module piece_3() // Ecke
{
   difference()
   {
      union()
      {
         translate([0,0,0])  
            block(s,b); 
         intersection()
         {
            translate([20,20,20]) 
               sphere(d=48-c,,$fn=f);
            translate([5,5,5]) 
               cube([20-c,20-c,20-c],center=true);
         }
      }
      translate([20,20,20]) 
        sphere(d=35+c,$fn=f);
   }    
}
//---------------------------------------------------------|
module support_1() // Support 1
{
   union()
   {
      translate([0,0,0]) 
         cylinder(h=20,d=1,center=true,$fn=f);
      translate([0,0,0]) 
         rotate([0,90,0]) 
            cylinder(h=20,d=1,center=true,$fn=f);
      translate([0,0,0]) 
         rotate([90,0,0]) 
            cylinder(h=20,d=1,center=true,$fn=f);
   }
}
//---------------------------------------------------------|
module support_23() // Support 2 und 3
{
   for(x=[28,20,12,8,0,-8,-12,-20,-28])
      for(y=[28,-28])
         translate([x,y,0]) 
              cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[28,-28])
      for(y=[20,12,8,0,-8,-12,-20])
         translate([x,y,0]) 
            cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[20,12,8,-8,-12,-20,])
      for(y=[24,-24])
         translate([x,y,0]) 
              cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[24,-24])
      for(y=[20,12,8,-8,-12,-20])
         translate([x,y,0])
            cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[25,-25])
      translate([x,0,0])
         cylinder(h=30,d=1,center=true,$fn=f);
   for(y=[25,-25])
      translate([0,y,0])
         cylinder(h=30,d=1,center=true,$fn=f);
}
//---------------------------------------------------------|
module block( // Einzelwürfel 
   s = 20,    // Äußere Größe
   b = 2)     // Rundung
// - - - - - - - - - - - - - - - - - - - - - - - - - - -
{
   // Variablen 
   c = s - (b * 2); // Kerngröße
   h = c / 2;       // Kernhälfte 
   union()
   {
      // Äußere Ecken des Würfels
      for(r = [0:90:270])
         rotate([0,r,0])
            for(y = [h,-h])
               translate([h,y,h])
                  sphere(b,$fn=30); // Würfelecken
      // Würfel-Außenrand
      for(r = [0:90:270])
         rotate([0,r,0])
            for(y = [h,-h])
               translate([h,y,0])
                  cylinder(c,b,b,center=true,$fn=30); // Würfel Rand
      // Würfelaußengrenzen (Achse y)
      for(r = [0:90:270])
         rotate([0,r,0])
            translate([h,0,h]) 
               rotate([90,0,0])
                  cylinder(c,b,b,center=true,$fn=30); // Würfel Rand
      // Würfel-Außenwände
      for(r = [0:90:270])
         rotate([0,r,0])
            translate([b,0,0])
               cube([c,c,c],center=true); // Würfelflächen
      // Würfelaußenwände (Achse y)
      for(y = [b,-b])
         translate([0,y,0])
            cube([c,c,c],center=true); // Würfelflächen
   }
}
//---------------------------------------------------------|

print_part(); // Vollansicht / Schnittansicht

module print_part() 
 {
	if (part == "1") { 
       
        rubikCube();
       	} 
        
    else if (part == "2") {
        
        rubikCubeHalf();
        }    
 }            
//---------------------------------------------------------|

