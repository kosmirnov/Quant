%% MAIN CONT. FUNCTION ALGORITHM%%
function [S,S_Last]=cont(S0,T,t,r,eta,nn,err01)

S=zeros(nn,1);
S(1) = S0;
dt = (T-t)/nn;

dW01 = sqrt(dt).*err01;



for ii = 1:1:nn % continous path
    S(ii+1) = S(ii) + r.*S(ii).*dt + eta.*S(ii).*dW01(ii);
end;


S_Last=S(end);

