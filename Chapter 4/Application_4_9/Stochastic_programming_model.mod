/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 4/05/2022 at 9:14:22 a. m.
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
 dvar float+ z[Depots][Regions][Scenarios];
 
 minimize sum(i in Depots) HoldingCost[i]*x[i] + 4 * sum(k in Scenarios) Probability[k] * sum(i in Depots, j in Regions) TransportationCost[i][j]*z[i][j][k];
 
 subject to {
   sum(i in Depots) x[i] <= 1000;
   forall(i in Depots, k in Scenarios) sum(j in Regions) z[i][j][k] <= x[i];
   forall(j in Regions, k in Scenarios) sum(i in Depots) z[i][j][k] == Requirements[k][j];
 }
