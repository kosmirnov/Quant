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
sigma_bsm=sqrt((sigma_input)^2+lambda*((gamma-0.5*delta^2)^2+delta^2));            %   Stop Value of your N-Loop since with N=50 it almost reaches 0


column=1;
for S=0:1:100
Call_BSM(1,column)=BSM_Call(S,X,r_input,sigma_bsm,T);
Call_MJ(1,column)=MJ_Call(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans); 
S_graph(1,column)=S;

column=1+column;
end
figure;
plot(S_graph,Call_MJ,':xr',S_graph,Call_BSM);
h=legend('Jump Diffusion','Standard BSM');
set(h, 'Interpreter', 'none')
ylabel('Put Price');
xlabel('Stock Price');
title('Standard BSM vs. Jump-Diffusion');



