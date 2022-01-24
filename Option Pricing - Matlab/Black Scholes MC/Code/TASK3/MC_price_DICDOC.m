% %Calculation of DOC and DIC 
% clear;
% clc;
% 
% %input data for problem 3
% 
% S0=160;         %stock price - start value
% X=150;          %strike price
% T=1;            %(T-t) - Time to maturity
% t=0;            %(T-t) - Time to maturity
% r=0.03;         %risk-free interest rate
% q=0.04;         %continous dividend yield
% sigma=0.3;      %different volatiliy levels
% H=140;          %barrier
% seed=77;
% rng(seed);
% 
% N=30000;        %number of stock paths
% n=1000;         %number of subintervals 

function [DOCall_MC,DICall_MC]=MC_price_DICDOC(S0,X,T,t,r,q,sigma,H,N,n)
seed=77;
rng(seed);
dt=(T-t)/n;     %length of one subinterval delta_t to delta_t+1
time=t:dt:T;    %steps until Time to maturity

S=nan(N, n+1);  %size of stock price matrix
S(:,1)=S0;      %first row of stock price matrix

%Calculation of stock price paths (step by step approach, since DOC and DIC
%are path depending)
for a=2:length(time)
    S(:,a)=S(:,a-1).*exp(((r-q)-0.5.*sigma.^2).*dt+...
        sigma.*sqrt(dt).*randn(N,1));
end



for j=1:1:N    %for-loop for checking the rows of the stock price matrix
    
    i=1;       %start value of count variable

    while S(j,i)>H && i<=n  %condition for DOC, since it has only a value  
                            %if S hits never the barrier    
        i=i+1;  %increase of count variable
        
    end
       
    
    
    if i==n+1                               %idea of while loop, if S is always greater than H the code should go 
        payoff_DOC=max(S(j,n+1)-X,0);       %until the end (n+1). This means if S is greater than X we have a payoff >0 
        payoff_DIC=0;                       %for DOC. And respectively the DIC never exist which is equivalent to
                                            %a payoff of zero for DIC.
    else
        payoff_DOC=0;                       %If the while loop does not reach the end. This mean the stock price path 
        payoff_DIC=max(S(j,n+1)-X,0);       %hit the barrier and DIC exists now. If S is greater than X we have a payoff
    end                                     %>0 for DIC. And respectively the DOC ceased to exist which is equilavent to
                                            %a payoff of zero for DOC.  
   
    
    DOC_payoff(j,1)=payoff_DOC;             %collecting all payoffs
    DIC_payoff(j,1)=payoff_DIC;             %collecting all payoffs
end

%DOC and DIC price using Monte Carlo Simulation
DOCall_MC=exp(-r*(T-t))*mean(DOC_payoff);   %we discount the mean of all payoffs to calculated the DOC with MC Simulation
DICall_MC=exp(-r*(T-t))*mean(DIC_payoff);   %we discount the mean of all payoffs to calculated the DOC with MC Simulation






 




