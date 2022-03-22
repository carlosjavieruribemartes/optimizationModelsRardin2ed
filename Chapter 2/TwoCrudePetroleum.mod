/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Lenovo
 * Creation Date: Apr 29, 2021 at 2:39:28 PM
 *********************************************/

 dvar float+ x1;
 dvar float+ x2;
 
 minimize 20*x1+15*x2;
 
 subject to {
   0.3*x1 + 0.4*x2 >=2.0;
   0.4*x1 + 0.2*x2 >=1.5;
   0.2*x1 + 0.3*x2 >=0.5;
   x1 <= 9;
   x2 <= 6;
 }