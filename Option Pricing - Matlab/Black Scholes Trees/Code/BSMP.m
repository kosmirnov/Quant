function [BSMP_Price] = BSMP(S,X,r,q,sg,t,T)
% S = stock price at t
h = r-q;
d1 = (log(S./X) + (h + 0.5.*sg.^2).*(T-t))./(sg.*sqrt(T-t));
d2 = d1 - sg.*sqrt(T-t);

N1 = N(d1); 
N2 = N(d2);
N3 = 1-N1;
N4 = 1-N2;

% BSMC_Price = S.*exp((h-r).*(T-t)).*N1 - X.*exp(-r.*(T-t)).*N2;
BSMP_Price = X.*exp(-r.*(T-t)).*N4 - S.*exp((h-r).*(T-t)).*N3;