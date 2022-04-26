/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 26/04/2022 at 4:39:48 p. m.
 *********************************************/
 
 {string} Days = {"Monday", "Tuesday", "Wednesday","Thursday", "Friday"};
 range Patterns = 1..3;
 
 int Work_days[Patterns][Days] = [[1,0,1,1,1],[1,1,0,1,1],[1,1,1,0,1]];
 int Employees_needed[Days] = [10, 7, 7, 7, 9];
 
 dvar float+ x[Patterns];
 
 minimize sum(j in Patterns) x[j];
 
 subject to {
   forall(i in Days) sum(j in Patterns) Work_days[j][i]*x[j] >= Employees_needed[i];
 }
