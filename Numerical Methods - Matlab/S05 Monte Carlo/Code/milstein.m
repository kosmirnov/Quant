%% MAIN MILSTEIN ALGORITHM%%
 function [S_Milstein,S_Milstein_Last,timer]=milstein(S0,t,T,r,eta,nn21,nn22,err01)



 mm = nn21./nn22;
 err22 = nan(1,nn22);
 
for ii = 1:nn22
     err22(ii)=sum(err01(round(mm*ii):-1:round((mm*ii-(mm-1)))));
end 
err22=err22/sqrt(mm);

dt2 = (T-t)/nn22;
dW22 = sqrt(dt2).*err22;
S_Milstein = nan(1,nn22);

S_Milstein(1) = S0;

% discretized path according to Euler
tic;
for ii = 1:nn22 % Simulation of a single path using Euler
    S_Milstein(ii+1) = S_Milstein(ii) + r.*S_Milstein(ii).*dt2 + eta.*S_Milstein(ii).*dW22(ii);
    S_Milstein(ii+1) = S_Milstein(ii+1)+0.5.*eta.^2.*S_Milstein(ii).*(dW22(ii).^2-dt2);
end
timer=toc;
S_Milstein_Last = S_Milstein(end);

