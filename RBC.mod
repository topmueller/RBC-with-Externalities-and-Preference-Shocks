////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tobias Mueller                                                                                                             //
// April 2020                                                                                                                 //
//                                                                                                                            //
// Replication of a Standard RBC Model with Different Labor Supply Assumptions and Externalities                              //
// 1) King–Plosser–Rebelo preferences                                                                                         //
// 2) Greenwood-Hercowitz-Huffman preferences                                                                                 //
//                                                                                                                            //
// 3) Baxter-King(1991): Productive Externalities and Business Cycles                                                         //
//                                                                                                                            //
// Dynare 4.6.1 and MATLAB R2019a are used for Computations                                                                   //
//                                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////
//                  Model Settings                   //
///////////////////////////////////////////////////////

//Switch On (1) and Off (0) between Various Model Settings
// KPR preferences vs. GHH preferences
// 0 = King–Plosser–Rebelo preferences
// 1 = Greenwood-Hercowitz-Huffman preferences
@#define preferences = 0

//Switch On (1) and Off (0) between Various Model Settings
// Baseline RBC vs. Baxter-King Productive Externalities
// 0 = Baseline RBC Model
// 1 = Externalities
@#define externalities = 1



// Endogenous variables
var
y                 (long_name='Output')
c                 (long_name='Consumption')
lambda            (long_name='Marginal Utility of Consumption')
h                 (long_name='Hours Worked')
k                 (long_name='Capital')
i                 (long_name='Investment')
w                 (long_name='Wages')
r                 (long_name='Capital Demand')
z                 (long_name='Technology')
g                 (long_name='Government Spending')
zeta              (long_name='Time-varying Preferences')
;

// Exogenous variables
varexo eta_z eta_g eta_zeta;

// Parameters
parameters s_H s_K s_C s_G epsilon_KH phi beta delta gamma rho_z rho_g rho_zeta sig_z sig_g sig_zeta;

// Initialization of parameters
s_H        = 0.67;       // Labor Share
s_K        = 0.33;       // Capital Share
s_C        = 0.65;       // Share of Consumption
s_G        = 0.20;       // Share of Government
epsilon_KH = 1;          // Allen Elasticity of Substitution
phi        = 0.25;       // Inverse Labor Supply Elasticity
beta       = 0.99;       // Discount Factor
delta      = 0.025;      // Depreciation Rate
gamma      = 1.5;        // Degree of Market Power

rho_z      = 0.99;       // AR(1) Technology
rho_g      = 0.90;       // AR(1) Government
rho_zeta   = 0.90;       // AR(1) Preferences
sig_z      = 1;          // Std of Technology Shock (in percent)
sig_g      = 1;          // Std of Government Shock (in percent)
sig_zeta   = -1;         // Std of Preference Shock (in percent)




//the model
model;
@#if preferences
lambda = (-1/ (s_C - (s_H/(1+phi) ))) * (s_C * c - s_H * h - (s_H/(1+phi)) * zeta); // Marginal Utility of Consumption
h      = 1/phi * (w - zeta);                                                        // Frisch Labor Supply
@#else
lambda = (-1) * c;                                                                  // Marginal Utility of Consumption
h      = 1/phi * (w + lambda - zeta);                                               // Frisch Labor Supply
@#endif

lambda = (1 - beta + beta * delta) * r(+1) + lambda(+1);                            // Euler Equation

@#if externalities
y      = s_K * gamma/epsilon_KH * k(-1) + s_H * gamma/epsilon_KH * (z + h);         // Production Function
r      = s_H * gamma * (z + h) + (s_K * gamma - 1) * k(-1);                         // Capital Demand
w      = s_K * gamma * k(-1) + s_H * gamma * z + (s_H * gamma -1) * h;              // Labor Demand
@#else
y      = s_K/epsilon_KH * k(-1) + s_H/epsilon_KH * (z + h);                         // Production Function
r      = s_H * (z + h - k(-1));                                                     // Capital Demand
w      = s_K * (k(-1) - h) + s_H * z;                                               // Labor Demand
@#endif

y      = s_C * c + s_G * g + (1 - s_C - s_G) * i;                                   // Aggregate Constraint
k      = (1-delta) * k(-1) + delta * i;                                             // Evolution of Capital

z      = rho_z * z(-1) + sig_z * eta_z;                                             // AR(1) Technology Shock
g      = rho_g * g(-1) + sig_g * eta_g;                                             // AR(1) Government Shock
zeta   = rho_zeta * zeta(-1) + sig_zeta * eta_zeta;                                 // AR(1) Preference Shock
end;


//assign steady state values
initval;
y       = 0;
lambda  = 0;
c       = 0;
i       = 0;
z       = 0;
k       = 0;
h       = 0;
r       = 0;
w       = 0;
g       = 0;
end;

// Compute the steady state
steady;

// Check for the roots (eigenvalues), i.e. the law of motion for the solution
check;


///////////////////////////////////////////////////////
//       Including Codes to Generate Figures         //
///////////////////////////////////////////////////////


//@#include "Technology_Shock.mod"
//@#include "Government_Spending_Shock.mod"
@#include "Preference_Shock.mod"
