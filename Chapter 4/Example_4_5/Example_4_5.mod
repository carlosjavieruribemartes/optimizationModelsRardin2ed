/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 25/04/2022 at 3:23:32 p. m.
 *********************************************/
 
 // Variables
 
 dvar float+ x1; // Tons of orange squeezed for juice
 dvar float+ x2; // Tons of concentrate diluted for juice
 dvar float+ x3; // Tons of juice sold
 
 // Objective function
 
 maximize -200*x1 - 1600*x2 + 1500*x3; // Net income
 
 // Constraints
 subject to {
   x1 <= 10000; // Orange availability
   x3 <= 15000; // Sales limit
   0.2*x1 + 2*x2 == x3; // Balance
 }
