/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 27/03/2022 at 12:28:44 p. m.
 *********************************************/
 
 tuple assignment {
   int product;
   int mill;
 }
 
 {assignment} Assignments = {<1,1>,	<1,2>,	<1,3>,	<1,4>,
 <2,1>,	<2,2>,	<2,3>,	<2,4>,
 <3,1>,	<3,2>,	<3,3>,	<3,4>,
 <4,1>,	<4,2>,	<4,3>,	<4,4>,
 <5,1>,	<5,2>,	<5,3>,	<5,4>,
 <6,1>,	<6,2>,	<6,3>,	<6,4>,
 <7,2>,	<7,3>,	<7,4>,
 <8,2>,	<8,3>,	<8,4>,
 <9,1>,	<9,2>,	<9,4>,
 <10,1>,	<10,2>,	<10,4>,
 <11,1>,	<11,2>,	<11,4>,
 <12,1>,	<12,2>,	<12,4>,
 <13,1>,	<13,2>,	<13,4>,
 <14,1>,	<14,2>,	<14,4>,
 <15,2>,	<15,4>,
 <16,2>,	<16,4> };
 
 
 range Products = 1..16;
 range Mills = 1..4;
 
 // Parameters
 float Cost[Assignments] = ...;
 float ProcessingTime[Assignments] = ...;
 float WeeklyDemand[Products] = ...;
 float ProductionCapacity[Mills] = ...;
 
 // Decision variables
 dvar float+ x[Assignments];
 
 dexpr float TotalCost = sum(i in Assignments) Cost[i]*x[i];
 
 minimize TotalCost;
 
 subject to {
   forall(p in Products) sum(i in Assignments: i.product == p) x[i] >= WeeklyDemand[p];
   forall(m in Mills) sum(i in Assignments: i.mill == m) x[i]*ProcessingTime[i] <= ProductionCapacity[m];
 }
 
 
