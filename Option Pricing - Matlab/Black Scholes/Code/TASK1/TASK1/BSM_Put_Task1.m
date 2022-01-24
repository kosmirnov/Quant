% BSM-Put Option Price with continous yield
function Put_BSM=BSM_Put_Task1(S,X,T,t,r,q,sigma)

d1=(log(S./X)+(r-q+0.5.*sigma.^2)*(T-t))./(sigma.*sqrt(T-t));
d2=d1-sigma.*sqrt(T-t);

N1=Norm_dist(-d1);
N2=Norm_dist(-d2);

Put_BSM=X.*exp(-r.*(T-t)).*N2-S.*exp(-q.*(T-t)).*N1;
