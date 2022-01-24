% TASK 3:       Mertons Jump Diffusion: Calculation
clear;
clc;

S=165;                   % Stock Price
X=150;                   % Excersise Price
T=1;                 % Time to Maturity
r_input=0.01;           % input interest Rate
sigma_input=0.12;       % input sigma
lambda=7;               % Number of Jumps
gamma=0;                
delta=0.3;
k= exp(gamma)-1;
lambda_trans=lambda*(1+k);

sigma_bsm=sqrt((sigma_input)^2+lambda*((gamma-0.5*delta^2)^2+delta^2));            %   St

Call_MJ=MJ_Call(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans);        % Merton Jump Function- Calculation
Call_BSM=BSM_Call(S,X,r_input,sigma_bsm,T);
Call_BSM_Check=blsprice(S,X,r_input,T,sigma_bsm,0);
% Delta_BSM=BSM_Delta(S,X,r_input,sigma_bsm,T);
% Delta_MJ=MJ_Delta(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans,n,n_stop);

