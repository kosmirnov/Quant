%% Vega Calculation
function Vega_Put=vega(S,X,T,t,r,sigma)   

d1=(log(S./X)+(r+0.5.*sigma.^2).*(T-t))./(sigma.*sqrt(T-t));
n1=(1./sqrt(2.*pi)).*exp(-0.5.*d1.^2);

Vega_Put=S.*sqrt(T-t).*n1;
