/*
*******************************************
Objekt Info: Ständer für den Zauberwürfel

*******************************************
Version: 08.08.2022 khf
*******************************************
*/           

//***************   Auswahl   *************

//keine              

//*****************************************

//***************   Libraries  ************

//keine  

//*****************************************

//***************  Parmeter   *************

TL = 45;		// Obere Seitenlänge
BL = 80;		// Untere Seitenlänge
H = 14.8;	// Höhe
TH = 2.3;	// Dicke
LH = 1;		// Höhe der oberen Lippe
BH = 1;		// Tiefe der Sockelhöhe
BTH = 3.3;	// Bodentiefe 
F = 0.01;	// Fudge-Faktor zum Kombinieren von Objekten

//*****************************************

//**************   Programm  **************


module pyramid(l, l2, h)
{
	c = l / (2 * cos(30));
	b = l / 2;
	a = (l * sin(60)) - c;
	c2 = l2 / (2 * cos(30));
	b2 = l2 / 2;
	a2 = (l2 * sin(60)) - c2;
	polyhedron(	points=[ [0,c,0],[-b,-a,0],[b,-a,0],[0,c2,h],[-b2,-a2,h],[b2,-a2,h] ],
				triangles=[ [0,1,2],[1,0,3],[4,1,3],[0,2,5],[3,0,5],[2,1,4],[4,5,2],[5,4,3] ]);
}

union()
{
	// Build the main body.
	difference()
	{
		pyramid(BL, TL, H);
		translate(v = [0, 0, -F])
			pyramid(BL - (TH * 2), TL - (TH * 2), H + (F * 2));
	}

	// Build the bottom base.
	translate(v = [0, 0, F - BH])
	{
		difference()
		{
			pyramid(BL + (BTH * 2), BL + (BTH * 2), BH);
			translate(v = [0, 0, -F])
				pyramid(BL - (TH * 2), BL - (TH * 2), BH + (F * 2));
		}
	}

	// Build the top lip.
	translate(v = [0, 0, H - F])
	{
		difference()
		{
			pyramid(TL, TL, LH);
			translate(v = [0, 0, -F])
				pyramid(TL - (TH * 2), TL - (TH * 2), LH + (F * 2));
		}
	}
}