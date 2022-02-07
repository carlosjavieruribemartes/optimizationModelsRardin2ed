/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Lenovo
 * Creation Date: 7/02/2022 at 2:06:42 p. m.
 *********************************************/

 int totalAnalysisAreas = ...;
 int totalPrescriptions = ...;
 
 range analysisAreas = 1..totalAnalysisAreas;
 range prescriptions = 1..totalPrescriptions;
 
 int thousandAcres[analysisAreas] = ...;
 int netPresentValue[analysisAreas, prescriptions] = ...; 
 int projectedTimberYield[analysisAreas, prescriptions] = ...; 
 float projectedGrazingCapability[analysisAreas, prescriptions] = ...;
 int wildernessIndex[analysisAreas, prescriptions] = ...;
 
 //number of thousands of acres in analysis area i managed by prescription j
 dvar float+ x[analysisAreas, prescriptions];
 
 //maximize total net present value
 maximize sum(i in analysisAreas, j in prescriptions) netPresentValue[i, j]*x[i, j];
 
 subject to {
   //all acres of each analysis area should be allocated
   forall(i in analysisAreas) sum(j in prescriptions) x[i,j] == thousandAcres[i];
   
   //performance requirement on timber
   sum(i in analysisAreas, j in prescriptions) projectedTimberYield[i, j]*x[i, j] >= 40000;
   
   //performance requirement on grazing
   sum(i in analysisAreas, j in prescriptions) projectedGrazingCapability[i, j]*x[i, j] >= 5;
   
   //wilderness index requirement
   1/788*sum(i in analysisAreas, j in prescriptions) wildernessIndex[i, j]*x[i, j] >= 70;
   
 }