function xxx = InvIntegral_BSM(j,S,K,T,t,r,q,sg,phmax)

ph = eps: 0.0001 : phmax; % up to 5 since normal distribution in

[~, fff] = CFBSM(j,ph,S,T,t,r,q,sg);

intg = fff.*exp(-1i.*ph.*log(K))./(1i.*ph);

AA = trapz(ph,real(intg)); 
xxx = 0.5 + (1./pi).*AA;
end