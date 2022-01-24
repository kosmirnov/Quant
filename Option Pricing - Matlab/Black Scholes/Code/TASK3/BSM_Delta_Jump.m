% Function for Delta Calculation / Standard BSM

function Delta_BSM_Jump=BSM_Delta_Jump(S,X,r,sigma,T)
d1=(log(S./X)+(r+0.5.*sigma.^2)*(T))./(sigma.*sqrt(T));

N1=Norm_dist(d1);

Delta_BSM_Jump=N1-1;