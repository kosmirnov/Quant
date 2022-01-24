function Put = BSMP(S,X,T,t,h,r,sg)
 
d1 = (log(S./X)+(h+0.5.*sg.*sg).*(T-t))/(sg.*sqrt((T-t)));
d2 = d1 - sg.*sqrt((T-t));

Put = -S.*exp((h-r).*(T-t)).*N(-d1) + X.*exp(-r.*(T-t)).*N(-d2);