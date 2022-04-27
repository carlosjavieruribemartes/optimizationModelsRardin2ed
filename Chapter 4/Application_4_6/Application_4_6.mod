/*********************************************
 * OPL 20.1.0.0 Model
 * Author: CarlosJavier
 * Creation Date: 27/04/2022 at 9:18:17 a. m.
 *********************************************/
 
 int total_weeks = ...; // Planning period
 range weeks = 1..total_weeks; // Indexed in t
 
 float cash_sales[weeks] = ...;
 float accounts_receivable[weeks] = ...;
 float accounts_payable[weeks] = ...;
 float expenses[weeks] = ...;
 
 dvar float+ g[weeks]; // Amount borrowed in week t against the line of credit
 dvar float+ h[weeks]; // Amount of line of credit debt paid off in week t
 dvar float+ w[weeks]; // Amount of accounts payable in week t delayed until week t + 3 at a loss of discounts
 dvar float+ x[weeks]; // Amount invested in short-term money markets during week t 
 dvar float+ y[weeks]; // Cumulative line of credit debt in week t
 dvar float+ z[weeks]; // Cash on hand during week t
 
 dexpr float Net_interest = 0.002*sum(t in weeks) y[t] + 0.02*sum(t in weeks) w[t] - 0.001*sum(t in weeks) x[t];
 
 minimize Net_interest;
 
 subject to {
   cash_balance_first_week: forall(t in weeks: t==1) g[t]-h[t]-x[t]+cash_sales[t]-expenses[t]+accounts_receivable[t]-0.98*(accounts_payable[t]-w[t])==z[t];
   cash_balance_second_and_third_week: forall(t in weeks: 1<t<4) z[t-1]+g[t]-h[t]+x[t-1]-x[t]+0.001*x[t-1]-0.002*y[t-1]+cash_sales[t]-expenses[t]+accounts_receivable[t]-0.98*(accounts_payable[t]-w[t])==z[t];
   cash_balance_other_weeks: forall(t in weeks: t>=4) z[t-1]+g[t]-h[t]+x[t-1]-x[t]+0.001*x[t-1]-0.002*y[t-1]+cash_sales[t]-expenses[t]+accounts_receivable[t]-0.98*(accounts_payable[t]-w[t])-w[t-3]==z[t];
   debt_balance_first_week: forall(t in weeks: t==1) g[t]-h[t]==y[t];
   debt_balance_other_weeks: forall(t in weeks: t>1) y[t-1]+g[t]-h[t]==y[t];
   credit_limit: forall(t in weeks) y[t]<=4000;
   bank_rule: forall(t in weeks) z[t]>=0.20*y[t];
   payable_limits: forall(t in weeks) w[t]<=accounts_payable[t];
   safety_balance: forall(t in weeks) z[t]>=20 ;
 }