/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 26/04/2022 at 8:31:33 a. m.
 *********************************************/
 
 // INDEXES
 
 range H = 11..21; // Working hours
 range HR = 11..13;	// Index h for shift start time for regular duty full-time shifts
 range HO = 11..12;	// Index h for shift start time for overtime duty full-time shifts
 range HP = 11..18;	// Index h for shift start time for regular duty part-time shifts
 
 // PARAMETERS
 
 int Full_time_shift_cost[HR] = ...;
 int Overtime_cost[HO] = ...;
 int Part_time_shift_cost[HP] = ...;
 int Machines_available = ...;
 int Arrivals[H] = ...;
 int Full_time_shift[H][HR] = ...;
 int Overtime_shift[H][HO] = ...;
 int Part_time_shift[H][HP] = ...;
 
 // VARIABLES
 
 dvar float+ x[HR]; // Number of full-time employees beginning a shift at hour h in {11,12,13}
 dvar float+ y[HO]; // Number of full-time employees with shift beginning at hour h who work overtime h in {11,12}
 dvar float+ z[HP]; // Number of part-time employees beginning a shift at hour h in {11, ..., 18}
 dvar float+ w[H]; // Uncompleted work backlog at hour h in thousands
 
 // OBJECTIVE FUNCTION
 
 dexpr float Daily_cost = sum(h in HR) Full_time_shift_cost[h]*x[h] 
 						+ sum(h in HO) Overtime_cost[h]*y[h]
 						+ sum(h in HP) Part_time_shift_cost[h]*z[h];
 
 minimize Daily_cost;
 						
 // CONSTRAINTS
 
 subject to {
   forall(h in H) sum(g in HR) Full_time_shift[h][g]*x[g] 
   				+ sum(g in HO) Overtime_shift[h][g]*y[g]
   				+ sum(g in HP) Part_time_shift[h][g]*z[g] <= Machines_available; 
   				
   forall(g in HO) y[g] <= 0.5*x[g];
   
   sum(g in HO) y[g] <= 20;
   
   forall(h in H: h<21) sum(g in HR) Full_time_shift[h][g]*x[g] 
   						+ sum(g in HO) Overtime_shift[h][g]*y[g]
   						+ sum(g in HP) 0.8*Part_time_shift[h][g]*z[g] >= Arrivals[h] + w[h] - w[h+1];
   
   forall(h in H: h==21) sum(g in HR) Full_time_shift[h][g]*x[g] 
   						+ sum(g in HO) Overtime_shift[h][g]*y[g]
   						+ sum(g in HP) 0.8*Part_time_shift[h][g]*z[g] >= Arrivals[h] + w[h];
   						
   forall(h in H) w[h] <= 20;
 }
