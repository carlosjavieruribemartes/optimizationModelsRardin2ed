/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 4/05/2022 at 12:38:24 p. m.
 *********************************************/
 
 {string} Beverages = {"Lemonaide", "Tanks"};
 {string} Scenarios = {"Sunny", "Cold"};
 
 float Probability[Scenarios] = [0.70, 0.30];
 int Demand[Beverages][Scenarios] = [[3,1],[1,3]];
 
 dvar float+ x[Beverages]; // Number of tanks pre-ordered per beverage
 dvar float+ w[Beverages][Scenarios]; // Number of tanks ordered after weather is known per beverage
 dvar float+ z[Beverages][Scenarios]; // Number of tanks of beverage sold on type s days
 
 maximize sum(s in Scenarios) Probability[s]*sum(i in Beverages) z[i][s];
 
 subject to {
   sum(i in Beverages) x[i] == 3;
   forall(s in Scenarios, i in Beverages) x[i]+w[i][s] >= z[i][s];
   forall(s in Scenarios) sum(i in Beverages) w[i][s] ==1;
   forall(s in Scenarios, i in Beverages) z[i][s]<=Demand[i][s];
 }
 
