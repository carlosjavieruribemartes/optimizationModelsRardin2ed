/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 1/05/2022 at 1:40:20 p. m.
 *********************************************/
 
 range Facilities = 1..5;
 range New_facilities = 1..2;
 range Old_facilities = 3..5;
 range Coordinates = 1..2;
 
 float Material_handling_cost[Facilities][New_facilities]=...;
 float Current_location[Old_facilities][Coordinates]=...;
 
 dvar float+ Location[New_facilities][Coordinates];
 dvar float+ Positive_diff[Facilities][New_facilities][Coordinates];
 dvar float+ Negative_diff[Facilities][New_facilities][Coordinates];
 
 dexpr float Objective_function = sum(i in Facilities, j in New_facilities, k in Coordinates) 
 									Material_handling_cost[i][j]*(Positive_diff[i][j][k]+Negative_diff[i][j][k]);
 
 minimize Objective_function;
 
 subject to {
   forall(i in Facilities, j in New_facilities, k in Coordinates: i<3) Location[j][k] - Location[i][k] == Positive_diff[i][j][k]-Negative_diff[i][j][k];
   forall(i in Facilities, j in New_facilities, k in Coordinates: i>=3) Location[j][k] - Current_location[i][k] == Positive_diff[i][j][k]-Negative_diff[i][j][k];
 }
 
 