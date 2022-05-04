/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 4/05/2022 at 7:57:14 a. m.
 *********************************************/
 
 int TotalDepots = ...;
 int TotalRegions = ...;
 int TotalScenarios = ...;
 range Depots = 1..TotalDepots;
 range Regions = 1..TotalRegions;
 range Scenarios = 1..TotalScenarios;
 
 float HoldingCost[Depots] = ...;
 float TransportationCost[Depots][Regions] = ...;
 
 float Probability[Scenarios] = ...;
 float Requirements[Scenarios][Regions] = ...;
 float AvgReq[Regions] = ...;
 
 dvar float+ x[Depots];
 dvar float+ z[Depots][Regions];
 
 minimize sum(i in Depots) HoldingCost[i]*x[i] + 4 * sum(i in Depots, j in Regions) TransportationCost[i][j]*z[i][j];
 
 subject to {
   sum(i in Depots) x[i] <= 1000;
   forall(j in Regions) sum(i in Depots) z[i][j] == AvgReq[j];
   forall(i in Depots) sum(j in Regions) z[i][j] <= x[i];
 }
