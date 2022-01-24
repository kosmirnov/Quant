%% Calculation of implied Vola via r= -log((S-Call+Put)./X)*(T-t);
function [r_implied_mean,r_vec]=r_implied(S,call,put,X,T,t)
r_vec= -log((S-call+put)./X)*(T-t);
r_implied_mean= mean(r_vec);