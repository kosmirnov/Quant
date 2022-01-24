%Calculation of the Greeks

function [Delta_Put,Gamma_Put,Theta_Put,Vega_Put]=Greeks(S,X,T,t,r,q,sigma)   



d1=(log(S./X)+(r-q+0.5.*sigma.^2).*(T-t))./(sigma.*sqrt(T-t));
d2=d1-sigma.*sqrt(T-t);

N1=Norm_dist(d1);                   
N1_Theta=Norm_dist(-d1);
N2_Theta=Norm_dist(-d2);

n1=(1./sqrt(2.*pi)).*exp(-0.5.*d1.^2);

Delta_Put=exp(-q.*(T-t)).*(N1-1);
Gamma_Put=(n1.*exp(-q.*(T-t)))./(S.*sigma.*sqrt(T-t));
Theta_Put=(-(S.*n1.*sigma.*exp(-q.*(T-t)))./(2.*sqrt(T-t)))+(-q).*S.*exp(-q.*(T-t)).*N1_Theta+r.*X.*exp(-r.*(T-t)).*(N2_Theta);
Vega_Put=S.*sqrt(T-t).*n1.*exp(-q.*(T-t));



