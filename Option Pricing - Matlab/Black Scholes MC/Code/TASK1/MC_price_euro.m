%% Function for Task 1B : Option valuation with MC for European Options


function [S,disc_payoff,MC_price]=MC_price_euro(S0,X,T,t,r,q,sigma,n_stop)

epsilon=randn(n_stop,1);                                                    % generate random vector
S=zeros(n_stop,1);                                                          % pre-defining stock price vec for efficiency

for n=1:1:n_stop;                                                           % one-step stock price evolution
S(n,:)=S0.*exp(((r-q)-0.5.*sigma.^2).*T+...
             sigma.*sqrt(T).*epsilon(n,1));
end

     
Payoff=max(0,S(:,end)-X);                                                   % payoff vector
disc_payoff=exp(-r*(T-t))*Payoff;
Exp_Payoff=mean(Payoff);    
MC_price=exp(-r*(T-t))*Exp_Payoff;                                          % get discounted MC price


  
