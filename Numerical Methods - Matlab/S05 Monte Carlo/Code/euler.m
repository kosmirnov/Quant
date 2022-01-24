%% MAIN EULER ALGORITHM%%
 function [S_Euler,S_Euler_Last,timer]=euler(S0,t,T,r,eta,nn,nn22,err01)


mm = nn/nn22;
err22 = nan(1,nn22);
 
for ii = 1:nn22
    err22(ii)=sum(err01(round(mm*ii):-1:round((mm*ii-(mm-1)))));
end 
err22=err22/sqrt(mm);

dt2 = (T-t)/nn22;
dW22 = sqrt(dt2).*err22;
S_Euler = nan(1,nn22);

S_Euler(1) = S0;

% discretized path according to Euler
tic;
for ii = 1:nn22 % Simulation of a single path using Euler
    S_Euler(ii+1) = S_Euler(ii) + r.* S_Euler(ii).*dt2 + eta.*S_Euler(ii).*dW22(ii);
end
timer=toc;
S_Euler_Last = S_Euler(end);
