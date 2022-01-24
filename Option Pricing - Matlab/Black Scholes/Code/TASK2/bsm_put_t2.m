% BSM-Put Option Price for TASK 2 for Vanilla-Plain BSM
function Put_BSM=bsm_put_t2(S,X,T,t,r,sigma)

d1=(log(S./X)+(r+0.5.*sigma.^2)*(T-t))./(sigma.*sqrt(T-t));
d2=d1-sigma.*sqrt(T-t);

N1=norm_dist(-d1);
N2=norm_dist(-d2);

Put_BSM=X.*exp(-r.*(T-t)).*N2-S.*N1;
