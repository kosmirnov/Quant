function yyy = BSM_FourierInv(S,K,T,t,r,q,sg,phmax)
h = r-q;

N1 = InvIntegral_BSM(1,S,K,T,t,r,q,sg,phmax);
N2 = InvIntegral_BSM(2,S,K,T,t,r,q,sg,phmax);


yyy = S.*exp((h-r).*(T-t)).*N1 - K.*exp(-r.*(T-t)).*N2;
end
