%% Closed-form calculation for European exchange option
function Theo_Price_EEO=THEO_EEO(S0_1,S0_2,q1,q2,sigma1,sigma2,rho,T,t)


sigma_head=sqrt(sigma1.^2+sigma2.^2-2.*rho.*sigma1.*sigma2);
d1=(log(S0_1./S0_2)+(q2-q1+(sigma_head.^2)/2).*(T-t))./(sigma_head.*sqrt(T-t));
d2=d1-sigma_head.*sqrt(T-t);
N1=norm_dist(d1);
N2=norm_dist(d2);
Theo_Price_EEO=S0_1*exp(-q1*(T-t)).*N1-S0_2.*exp(-q2*(T-t)).*N2;


