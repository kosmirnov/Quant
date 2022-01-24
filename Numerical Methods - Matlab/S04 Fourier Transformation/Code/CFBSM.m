function [zzz, fff] = cfj(j,ph,S,T,t,r,q,sg)

if j==1
    a=1;
    
else a = -1;
    
end;

zzz = -0.5.*ph.^2.*sg.^2.*(T-t)+ 1i.*ph.*((r-q + 0.5.*a.*sg.^2).*(T-t)+ log(S));
fff = exp(zzz);
end