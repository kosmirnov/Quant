%TASK 3: Valuation of a DOC & DIC Call
%% Input
clear;
clc;
seed=77;
rng(seed);
S0=160;         %stock price
X=150;          %strike price
T=1;         %(T-t) - Time to maturity
t=0;            %(T-t) - Time to maturity
r=0.03;         %risk-free interest rate
q=0.04;         %continous dividend yield
sigma=0.3;      %volatility
H=140;          % Barrier
N=30000;        % Number of realizations

t_step=1000; %number of subintervals, since we deal with a simple European option, which is not path-depending 
     %we use the exact approach (1-step approach)
     
n=1000;



%% TASK 3A: Plain Vanilla vs. DOC & DIC (simulated)

PlainVanilla=MC_price_euro(S0,X,T,t,r,q,sigma,N);
[DOCall_MC,DICall_MC]=MC_price_DICDOC(S0,X,T,t,r,q,sigma,H,N,n);
% sum_call_mc=DOCall_MC+DICall_MC;   
%% Task 3B: Theoretical values
DICall_theo=DIC_call(S0,X,r,sigma,q,T,t,H);
DOCall_theo=DOC_call(S0,X,r,sigma,q,T,t,H);
%% Task 3C: Extension of Monte-Carlo 
[DOCall_MC_Ext,DICall_MC_Ext]=MC_price_DICDOC_Ext(S0,X,T,t,r,q,sigma,H,N,t_step);





