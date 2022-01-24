%% Monte-Carlo Call Price Calculation for EEO

function [MC_price_EEO,CI_up,CI_down,Payoff]=MC_EEO(S0_1,S0_2,r,q1,q2,sigma1,sigma2,rho,T,N_stop)


VC_Mat=[sigma1^2 sigma1*sigma2*rho; sigma1*sigma2*rho sigma2^2];            % Choletzky Decomposition 
C=chol(VC_Mat,'lower');

Z1=randn(1,N_stop);
Z2=randn(1,N_stop);
Z=[Z1;Z2];
epsilon=C*Z;                                                                % Create Variance-Covariance Matrix for the values
S_1T=zeros(N_stop,1);
S_2T=zeros(N_stop,1);
for N=1:1:N_stop
S_1T(N,:)=S0_1.*exp(((r-q1)-0.5.*sigma1.^2).*T+...                                         
sqrt(T).*epsilon(1,N));
S_2T(N,:)=S0_2.*exp(((r-q2)-0.5.*sigma2.^2).*T+...                                         
sqrt(T).*epsilon(2,N));
end

Payoff=max(0,S_1T-S_2T);
disc_payoff=exp(-r*(T))*Payoff;
Exp_Payoff=mean(Payoff);
MC_price_EEO=exp(-r*(T))*Exp_Payoff;
sigma_hat=sqrt(var(disc_payoff));                     
CI_up=MC_price_EEO+1.959963985*sigma_hat/sqrt(N_stop);
CI_down=MC_price_EEO-1.959963985*sigma_hat/sqrt(N_stop);
        

