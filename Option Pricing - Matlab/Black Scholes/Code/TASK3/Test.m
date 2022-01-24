clear;
clc;


S=75;                   % Stock Price
X=70;                   % Excersise Price
T=0.25;                 % Time to Maturity
r_input=0.03;           % input interest Rate
sigma_bsm=0.40;       % input sigma


Put_BSM=BSM_Put(S,X,r_input,sigma_bsm,T);