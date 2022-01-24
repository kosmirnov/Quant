% DOC-Call price

function Call_DOC=DOC_call(S,X,r,sigma,q,T,t,H)

Lambda=(r-q+(sigma.^2)/2)./(sigma.^2);

y1=((log((H^2)/(S*X)))/sigma*sqrt(T-t))+Lambda*sigma*sqrt(T-t);
y2=y1-sigma*sqrt(T-t);
d1=(log(S./X)+(r-q+0.5.*sigma.^2)*(T-t))./(sigma.*sqrt(T-t));
d2=d1-sigma.*sqrt(T-t);



% risk-neutral probabilities
N1=Norm_dist(y1);
N2=Norm_dist(y2);


% risk-neutral probabilities
N3=Norm_dist(d1);
N4=Norm_dist(d2);

Call_BSM=S.*exp(-q*(T-t)).*N3-X.*exp(-r.*(T-t)).*N4;


Call_DIC=S*exp(-q*(T-t))*N1*(H/S)^(2*Lambda)-X*exp(-r*(T-t))*N2*(H/S)^(2*Lambda-2);

Call_DOC=Call_BSM-Call_DIC;

end
