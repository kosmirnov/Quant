% DIC-Call price

function Call_DIC=DIC_call(S,X,r,sigma,q,T,t,H)

Lambda=(r-q+(sigma.^2)/2)./(sigma.^2);

y1=((log((H^2)/(S*X)))/sigma*sqrt(T-t))+Lambda*sigma*sqrt(T-t);
y2=y1-sigma*sqrt(T-t);



% risk-neutral probabilities
N1=Norm_dist(y1);
N2=Norm_dist(y2);


Call_DIC=S*exp(-q*(T-t))*N1*(H/S)^(2*Lambda)-X*exp(-r*(T-t))*N2*(H/S)^(2*Lambda-2);

end
