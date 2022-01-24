function [result, delta] = BSMCall(S,X,T,t,r,q,sg);
% Calculation of Black-Scholes-Merton Formula

d1 = (log(S./X) + (r - q + 0.5.*sg.^2).*(T-t))./(sg.*sqrt(T-t));
% d2 = (log(S./X) + (r - 0.5.*sg.^2).*(T-t))./(sg.*sqrt(T-t));
d2 = d1 - sg.*sqrt(T-t);

result = S.*exp(-q.*(T-t)).*N(d1) - X.*exp(-r.*(T-t)).*N(d2);
delta = exp(-q.*(T-t)).*N(d1);







