%% TASK 2 Master
%% Inputs for Excersise 2
clear;
clc;


S0_1=110;
S0_2=130;
q1=0.06;
q2=0.02;
sigma1=0.2;
sigma2=0.4;
rho=-0.5;
r=0.04;
N_stop=500000;                                                              % number of realizations
T=1;
t=0;
% we assumed a time to maturity of 1
%% 2A: Monte-Carlo Calculation : Price, and confidence intervals
[MC_price_EEOT,CI_up,CI_down,Payoff]=MC_EEO(S0_1,S0_2,r,q1,q2,sigma1,sigma2,rho,T,N_stop);
%% 2B: theoretical/closed-form solution
rho_length=-0.99:0.01:0.99;          
Theo_Price_EEO=THEO_EEO(S0_1,S0_2,q1,q2,sigma1,sigma2,rho,T,t);
[plot_2B_rho,plot_2B_rho_diff]=plot_2B(S0_1,S0_2,r,q1,q2,sigma1,sigma2,rho_length,T,t,N_stop);
%% 2C: 3D plots for different stock prices
S_length=1:1:250;
[plot_3D_t,plot_3D_T]=plot_2C(S_length,q1,q2,sigma1,sigma2,rho,T,t);    
