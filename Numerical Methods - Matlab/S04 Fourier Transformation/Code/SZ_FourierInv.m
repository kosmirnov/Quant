

function yyy=SZ_FourierInv(S,K,T,t,r,kp,sg,th,rh,vt,phmax,heston)
N1 = InvIntegral_SZ(1,S,K,T,t,r,kp,sg,th,rh,vt,phmax,heston);
N2 = InvIntegral_SZ(2,S,K,T,t,r,kp,sg,th,rh,vt,phmax,heston);


yyy = S.*N1 - K.*exp(-r.*(T-t)).*N2;

end