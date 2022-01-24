% %% Function for Task 1B : Option valuation with MC for European Options
% function MC_price_pv=MC_price_euro(S0,X,T,t,r,q,sigma,N)
% n=500; %number of subintervals, since we deal with a simple European option, which is not path-depending 
%      %we use the exact approach (1-step approach)
%      
% dt=(T-t)/n; %is equal to Time to maturity
% time=t:dt:T; %steps for until Time to maturity
% 
% S=nan(N, n+1);
% S(:,1)=S0;
% 
% for a=2:length(time)
%     S(:,a)=S(:,a-1).*exp(((r-q)-0.5.*sigma.^2).*dt+...
%         sigma.*sqrt(dt).*randn(N,1));
% end

function MC_price_pv=MC_price_euro(S0,X,T,t,r,q,sigma,N)

epsilon=randn(N,1);                                                    % generate random vector
S=zeros(N,1);                                                          % pre-defining stock price vec for efficiency

for n=1:1:N;                                                           % one-step stock price evolution
S(n,:)=S0.*exp(((r-q)-0.5.*sigma.^2).*T+...
             sigma.*sqrt(T).*epsilon(n,1));
end

     
Payoff=max(0,S(:,end)-X);                                                   % payoff vector
Exp_Payoff=mean(Payoff);    
MC_price_pv=exp(-r*(T-t))*Exp_Payoff;                                          % get discounted MC price


  
