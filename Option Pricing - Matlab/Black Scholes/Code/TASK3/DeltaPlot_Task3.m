clear;
clc;

S0=75;                   % Stock Price
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
sigma_bsm=sqrt((sigma_input)^2+lambda*((gamma-0.5*delta^2)^2+delta^2)); % Combined Sigma for BSM-Calculation


column=1;
for S=0:1:S0*2
Delta_BSM(1,column)=BSM_Delta(S,X,r_input,sigma_bsm,T);
Delta_MJ(1,column)=MJ_Delta(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans,n,n_stop); 
S_graph(1,column)=S;

column=1+column;
end
figure;
plot(S_graph,Delta_MJ,':xr',S_graph,Delta_BSM);
h=legend('Jump Diffusion','Standard BSM');
set(h, 'Interpreter', 'none')
ylabel('Value of Delta');
xlabel('Stock Price');
title('Standard BSM vs. Jump-Diffusion');

