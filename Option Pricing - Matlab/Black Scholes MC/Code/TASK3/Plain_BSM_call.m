% BSM call price  (h=r-q)

function Call_BSM_Plain=Plain_BSM_call(S,X,r,q,sigma,T,t)

d1=(log(S./X)+(r-q+0.5.*sigma.^2)*(T-t))./(sigma.*sqrt(T-t));
d2=d1-sigma.*sqrt(T-t);
% risk-neutral probabilities
N1=Norm_dist(d1);
N2=Norm_dist(d2);

Call_BSM_Plain=S.*exp(-q*(T-t)).*N1-X.*exp(-r.*(T-t)).*N2;

end
