% BSM-Put Option Price

function Call_BSM=BSM_Call(S,X,r_input,sigma_bsm,T)

d1=(log(S./X)+(r_input+0.5.*sigma_bsm.^2)*(T))./(sigma_bsm.*sqrt(T));
d2=d1-sigma_bsm.*sqrt(T);

N1=Norm_dist(d1);
N2=Norm_dist(d2);

Call_BSM=S.*N1-X.*exp(-r_input.*T).*N2;