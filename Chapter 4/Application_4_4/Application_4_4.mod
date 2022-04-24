/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 28/03/2022 at 2:34:41 p. m.
 *********************************************/
 
 // SETS
 {string} LogQ = {"G", "F"}; 					// Index q for log quality, "G" is for Good and "F" is for Fair
 {int} LogVendor = {1,2}; 						// Index v for log vendor number
 {string} VeneerThickness = {"1/16", "1/8"}; 	// Index t for veneer thickness 
 {string} VeneerGrade = {"A", "B", "C"};		// Index g for veneer grade
 {string} PlywoodThickness = {"1/4", "1/2"};	// Index p for plywood thickness
 //{string} PlywoodQ = {"AB", "AC", "BC"};
 
 // PARAMETERS
 float Log_availability_per_month[LogVendor][LogQ] = ...;
 float Cost_per_log[LogVendor][LogQ] = ...;
 float Yield_per_log[LogQ][VeneerThickness][VeneerGrade] = ...;
 float Green_veener_availability_per_month[VeneerThickness][VeneerGrade] = ...;
 float Cost_per_green_veener[VeneerThickness][VeneerGrade] = ...;
 float Plywood_price[PlywoodThickness][VeneerGrade][VeneerGrade] = ...;
 float Plywood_market_per_month[PlywoodThickness][VeneerGrade][VeneerGrade] = ...;
 float Plywood_pressing_time[PlywoodThickness][VeneerGrade][VeneerGrade] = ...;
 float Monthly_capacity_for_pressing = ...;
 float Green_veneer_yield = ...;
 float Composition[VeneerThickness][VeneerGrade][PlywoodThickness][VeneerGrade][VeneerGrade] = ...;
 float Balance_veneer[VeneerGrade][VeneerGrade] = ...;

 // DECISION VARIABLES
 dvar float+ w[LogQ][LogVendor][VeneerThickness]; 	// Number of logs of quality q bought from vendor v and peeled into green veneer of thickness t per month
 dvar float+ x[VeneerThickness][VeneerGrade];		// Number of square feet of thickness t, grade g green veneer purchased directly per month
 dvar float+ y[VeneerThickness][VeneerGrade][VeneerGrade];	// Number of sheets of thickness t veneer used as grade g´ after drying and processing from grade g green veneer per month
 dvar float+ z[PlywoodThickness][VeneerGrade][VeneerGrade];	// Number of sheets of thickness t, from veneer grade g, back veneer grade g´ plywood pressed and sold per month
 
 // OBJECTIVE FUNCTION
 dexpr float TotalMargin = 
 -sum(q in LogQ, v in LogVendor, t in VeneerThickness) Cost_per_log[v][q]*w[q][v][t]
 -sum(t in VeneerThickness, g in VeneerGrade) Cost_per_green_veener[t][g]*x[t][g]
 +sum(p in PlywoodThickness, g in VeneerGrade, h in VeneerGrade) Plywood_price[p][g][h]*z[p][g][h];
 
 maximize TotalMargin;
 
 // CONSTRAINTS
 subject to {
   forall(v in LogVendor, q in LogQ) sum(t in VeneerThickness) w[q][v][t]<=Log_availability_per_month[v][q]; 			// Log availability limits  
   forall(t in VeneerThickness, g in VeneerGrade) x[t][g]<= Green_veener_availability_per_month[t][g]; 					// Purchased veneer availabilities
   forall(p in PlywoodThickness, g in VeneerGrade, h in VeneerGrade) z[p][g][h] <= Plywood_market_per_month[p][g][h]; 	// Market sizes constrain
   sum(p in PlywoodThickness, g in VeneerGrade, h in VeneerGrade) z[p][g][h]*Plywood_pressing_time[p][g][h] <= Monthly_capacity_for_pressing; // Pressing capacity limit
   forall(t in VeneerThickness, g in VeneerGrade) x[t][g] + sum(q in LogQ, v in LogVendor) Yield_per_log[q][t][g]*w[q][v][t] >= sum(h in VeneerGrade) Green_veneer_yield*Balance_veneer[g][h]*y[t][g][h];
   forall(t in VeneerThickness, h in VeneerGrade) sum(g in VeneerGrade) Balance_veneer[g][h]*y[t][g][h] == sum(p in PlywoodThickness, g in VeneerGrade, j in VeneerGrade) Composition[t][h][p][g][j]*z[p][g][j];
 }
