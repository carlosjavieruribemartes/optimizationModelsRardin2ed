/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 12/05/2022 at 10:25:00 a. m.
 *********************************************/
 
 {string} investors = {"Investor 1", "Investor 2", "Clyde"};
 int businessRequirement = 100000;
 float alpha = 0.48; 
 /*
 With alpha less than or equal to 0.45 there is no feasible solution
 With alpha greather than or equal to 0.50 the problem in unbounded
 */
 
 float fraction[investors] = [0.5, alpha, 0.5-alpha];
 
 dvar float+ x[investors];
 
 maximize sum(i in investors) x[i];
 
 subject to {
   sum(i in investors) x[i] >= businessRequirement;
   x["Clyde"] <= 5000;
   forall(j in investors: j != "Clyde") x[j] - fraction[j]*sum(i in investors) x[i] == 0;
 }
