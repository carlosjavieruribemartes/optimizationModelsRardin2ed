/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 22/03/2022 at 11:14:02 a. m.
 *********************************************/
 
 {string} Courses = ...; //List of courses to prepare
 
 //Maximum number of study Hours to allocate
 int TotalHoursAvailable = ...; 
 
 //Maximum number of study hours in a single course
 int MaxHour = ...; 
 
 //Percentage of increase in grades per course
 int BenefitPerHour[Courses] = ...; 
 
 //Hours spent in courses
 dvar float+ hCourse[Courses];
 
 //Total gain
 dexpr float Gain = sum(i in Courses) BenefitPerHour[i]*hCourse[i];
 
 //Declare objective
 maximize Gain;
 
 //Declare constraints
 subject to {
   Allocation: sum(i in Courses) hCourse[i] == TotalHoursAvailable;
   
   forall(i in Courses: i!="Operations Research") 
   		hCourse["Operations Research"] >= hCourse[i];
   
   forall(i in Courses)
     	hCourse[i] <= MaxHour;
 }
 