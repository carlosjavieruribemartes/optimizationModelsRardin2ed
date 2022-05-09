/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 9/05/2022 at 3:07:54 p. m.
 *********************************************/
 
 // Sets
 {string} sports = {"football", "soccer"};
 
 // Parameters
 int profit_per_trophy[sports] = [12, 9];
 int balls_in_stock[sports] = [1000, 1500];
 int required_plaques[sports] = [1,1];
 int base_requirement[sports] = [4,2];
 int plaques_in_stock = 1750;
 int wood_for_board_in_stock = 4800;
 
 // Decision variables
 dvar float+ x[sports]; // number of trophies to produce per sport
 
 // Objective function
 maximize sum(i in sports) profit_per_trophy[i]*x[i];
 
 // Constraints
 subject to {
   forall(i in sports) x[i] <= balls_in_stock[i]; // Maximum number of balls available
   sum(i in sports) required_plaques[i]*x[i] <= plaques_in_stock;
   sum(i in sports) base_requirement[i]*x[i] <= wood_for_board_in_stock;
   
 }
