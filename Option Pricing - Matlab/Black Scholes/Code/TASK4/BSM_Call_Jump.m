% BSM Function with Jump-Diffusion
function Call_BSM=BSM_Call_Jump(S,X,r,sigma,T)

d1=(log(S./X)+(r+0.5.*sigma.^2)*(T))./(sigma.*sqrt(T));
d2=d1-sigma.*sqrt(T);

N1=Norm_dist(d1);
N2=Norm_dist(d2);

Call_BSM=S.*N1-X.*exp(-r.*T).*N2;


