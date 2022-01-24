% Calculation of the Bounds
function [UB_Put,LB_Put]=Bounds(S,X,T,t,r,q,S_Length)

UB_Vec=ones(1,length(S_Length));                        % This Vec helos plotting the graph by saving the values
LB_Put=max((X.*exp(-r.*(T-t))-S.*exp(-q.*(T-t))),0);
UB_Put=X.*exp(-r.*(T-t))*UB_Vec;
end


