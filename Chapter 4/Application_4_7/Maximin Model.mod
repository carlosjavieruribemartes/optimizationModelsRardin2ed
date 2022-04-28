/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 28/04/2022 at 10:03:50 a. m.
 *********************************************/
 
 int Highway_segments_number = ...;
 range Segments = 1..Highway_segments_number; // Index j for segment in Segments
 int Officers_available = ...;
 int Upper_bound[Segments] = ...; // Upper bound on the number of officers assigned to segment j per week
 int Reduction_potential[Segments] = ...; // Reduction potential for suppressing speeding on segment j per officer assigned
 
 dvar float+ x[Segments]; // Number of officers per week assigned to patrol segment j
 dvar float+ f; // Objective function
 
 maximize f;
 
 subject to {
   forall(j in Segments) f <= Reduction_potential[j]*x[j];
   sum(j in Segments) x[j] <= Officers_available;
   forall(j in Segments) x[j] <= Upper_bound[j];
 } 
