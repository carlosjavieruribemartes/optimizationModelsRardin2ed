/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 28/04/2022 at 9:48:19 a. m.
 *********************************************/
 
 int Highway_segments_number = ...;
 range Segments = 1..Highway_segments_number; // Index j for segment in Segments
 int Officers_available = ...;
 int Upper_bound[Segments] = ...; // Upper bound on the number of officers assigned to segment j per week
 int Reduction_potential[Segments] = ...; // Reduction potential for suppressing speeding on segment j per officer assigned
 
 dvar float+ x[Segments]; // Number of officers per week assigned to patrol segment j
 
 maximize sum(j in Segments) Reduction_potential[j]*x[j];
 
 subject to {
   sum(j in Segments) x[j] <= Officers_available;
   forall(j in Segments) x[j] <= Upper_bound[j];
 }
