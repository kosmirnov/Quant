function [BBSR]=Binomial_BBSR(S,X,r,q,sig,T,n,flg,ind)
% The function calculates the price for a European or an American
% put or call option (depending on the value of ind and of flg) with the BBS method 
% with Richardson extrapolation.

if flg==-1 %Put
    if ind == 1 %American 
        C2=Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
        C1=Binomial_JR_BBS(S,X,r,q,sig,T,n/2,-1,1);
        BBSR=2*C2-C1;
    elseif ind == 0 %European
        C2=Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,0);
        C1=Binomial_JR_BBS(S,X,r,q,sig,T,n/2,-1,0);
        BBSR=2*C2-C1;
    end
elseif flg==1 %Call
     if ind == 1 %American 
        C2=Binomial_JR_BBS(S,X,r,q,sig,T,n,1,1);
        C1=Binomial_JR_BBS(S,X,r,q,sig,T,n/2,1,1);
        BBSR=2*C2-C1;
    elseif ind == 0 %European
        C2=Binomial_JR_BBS(S,X,r,q,sig,T,n,1,0);
        C1=Binomial_JR_BBS(S,X,r,q,sig,T,n/2,1,0);
        BBSR=2*C2-C1;
    end
end
    