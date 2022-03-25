/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 24/03/2022 at 8:54:02 p. m.
 *********************************************/
 
 {string} Ingredients = ...; // Set of ingredients available
 {string} Elements = ...; // Set of elements composing the mix
 
 // PARAMETERS
 int cost[Ingredients] = ...; // Cost in kr per kg of ingredient added
 float available[Ingredients] = ...; // Number of kg held in inventory per ingredient
 
 float CompositionPercentage[Ingredients][Elements] = ...; // % of element in ingredient

 float minimumBlend[Elements] = ...;
 float maximumBlend[Elements] = ...;
 
 int totalCharge = ...;
 
 // DECISION VARIABLES
 
 dvar float+ x[Ingredients]; // Number of kg of ingredient to include in the mix
 
 dexpr float totalCost = sum(i in Ingredients) cost[i]*x[i]; // Total cost of the mix
 
 minimize totalCost;
 
 subject to {
   weight: sum(i in Ingredients) x[i] == totalCharge;
   
   forall(j in Elements) sum(i in Ingredients) x[i]*CompositionPercentage[i][j] >= minimumBlend[j]*totalCharge;
   forall(j in Elements) sum(i in Ingredients) x[i]*CompositionPercentage[i][j] <= maximumBlend[j]*totalCharge;
   
   forall(i in Ingredients) x[i] <= available[i];
    
 }
 
