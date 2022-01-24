% clear;
% clc;
% 
% S=34;                   % Stock Price
% X=30;                   % Excersise Price
% T=1.25;                 % Time to Maturity
% r_input=0.01;           % input interest Rate
% sigma_input=0.22;       % input sigma
% lambda=2;               % Number of Jumps
% gamma=-0.02;                
% delta=0.2;
% k= exp(gamma)-1;
% lambda_trans=lambda*(1+k);
% n=0;                    %   Start Value for your while loop
% n_stop=49;              %   Stop Value of your N-Loop since with N=50 it almost reaches 0
% sigma_bsm=sqrt((sigma_input)^2+lambda*((gamma-0.5*delta^2)^2+delta^2));            %   St
% MJ_Vec=zeros(n_stop,1);
% 
function Call_MJ=MJ_Call(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans)

for n=0:100;                      
    r=r_input-lambda*k+(n*gamma/T);
    Var_Jump=sigma_input^2+(n*delta^2)/T;
    sigma=sqrt(Var_Jump);
    Put_MJ_Calc=(((lambda_trans*T)^n)/factorial(n))*exp(-(lambda_trans*T))*BSM_Call_Jump(S,X,r,sigma,T);
    n=n+1;
    MJ_Vec(n,1)=Put_MJ_Calc;
end    
Call_MJ=sum(MJ_Vec);    