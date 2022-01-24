% TASK 3:       Mertons Jump Diffusion: Calculation
clear;
clc;

S=75;                   % Stock Price
X=70;                   % Excersise Price
T=0.25;                 % Time to Maturity
r_input=0.03;           % input interest Rate
sigma_input=0.35;       % input sigma
lambda=5;               % Number of Jumps
gamma=0;                
delta=0.1;
k= exp(gamma)-1;
lambda_trans=lambda*(1+k);
n=0;                    %   Start Value for your while loop
n_stop=49;              %   Stop Value of your N-Loop since with N=50 it almost reaches 0
sigma_bsm=sqrt((sigma_input)^2+lambda*((gamma-0.5*delta^2)^2+delta^2)); 

Put_MJ=MJ_Put(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans,n,n_stop);        % Merton Jump Function- Calculation
Put_BSM=BSM_Put(S,X,r_input,sigma_bsm,T);
% Delta_BSM=BSM_Delta(S,X,r_input,sigma_bsm,T);
% Delta_MJ=MJ_Delta(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans,n,n_stop);

