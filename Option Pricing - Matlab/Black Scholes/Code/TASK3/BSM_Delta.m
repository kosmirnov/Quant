% Function for Delta Calculation / Standard BSM

function Delta_BSM=BSM_Delta(S,X,r_input,sigma_bsm,T)
d1=(log(S./X)+(r_input+0.5.*sigma_bsm.^2)*(T))./(sigma_bsm.*sqrt(T));

N1=Norm_dist(d1);

Delta_BSM=N1-1;