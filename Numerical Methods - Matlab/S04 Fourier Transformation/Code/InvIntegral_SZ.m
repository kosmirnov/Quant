function [xxx,intg] = InvIntegral_SZ(j,S,K,T,t,r,kp,sg,th,rh,vt,phmax,heston)

ph = (eps: 0.001 : phmax)';
if j==1
    [~, fff] = CFSZ1(S,T,t,r,kp,sg,th,rh,vt,ph,heston);
else
    [~, fff] = CFSZ2(S,T,t,r,kp,sg,th,rh,vt,ph,heston);
end

intg = fff.*exp(-1i.*ph.*log(K))./(1i.*ph);

AA = trapz(ph,real(intg));

xxx = 0.5 + (1./pi).*AA;
end