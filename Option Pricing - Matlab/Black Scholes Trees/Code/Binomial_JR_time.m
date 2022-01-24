function [Price_JR] = Binomial_JR_time(S,X,r,q,sig,T,n,flg,ind)
% This function creates a matrix of the evolution of the option prices,
% both for call and put options (depending on the value of the input flg)
% and for European and American options (depending on the valeu of the
% input ind)

% Step 1: creation of the matrix of the evolution of stock prices. We
% recall the function S_JR
Stock = S_JR(S,T,r,q,sig,n);


delta_T = T./n; % Time increment

% Step 2: calculation of the option value at maturity and of the the
% corresponding BSM one.
% flg identifies whether the option consididered is a European call or put,
% while ind identifies if the option is of European or American type.

if ind == 0 %European type
    if flg == -1 %Put
        DerivatePrices(1:n+1,n+1) = max(X - Stock(1:n+1,n+1),0);
        
    else %Call
        DerivatePrices(1:n+1,n+1) = max(Stock(1:n+1,n+1)-X,0);
        
    end;

p = 0.5; % prob for an up move with JR Method


% Step 3: backward iteration in the calculation of the option price at each
% time step delta_T
for j = n:-1:1 %backward iteration for columns
    for i = 1:j
        %price of the options depending on the probabilities of an up or down movement.
        % p is equal for both movements
     DerivatePrices(i,j) = ...
         p.*DerivatePrices(i,j+1)+(1-p).*DerivatePrices(i+1,j+1); 
     % discount of the prices found
     DerivatePrices(i,j) = exp(-r.*delta_T).* DerivatePrices(i,j);
     
    end; 

end;
     

Price_JR = DerivatePrices(1,1);


elseif ind == 1 %American type
    if flg == -1 %Put
        DerivatePrices(1:n+1,n+1) = max(X - Stock(1:n+1,n+1),0);
     
    else %Call
        DerivatePrices(1:n+1,n+1) = max(Stock(1:n+1,n+1)-X,0);
        
    end;

p = 0.5; % prob for an up move with JR Method


% Step 3: backward iteration in the calculation of the option price at each
% time step delta_T
for j = n:-1:1 %backward iteration for columns
    for i = 1:j
        %price of the options depending on the probabilities of an up or down movement.
        % p is equal for both movements
     DerivatePrices(i,j) = ...
         p.*DerivatePrices(i,j+1)+(1-p).*DerivatePrices(i+1,j+1); 
     % discount of the prices found
     DerivatePrices(i,j) = exp(-r.*delta_T).* DerivatePrices(i,j);
     % For the American case check whether the previous price is higher
     % than the option payoff in each step
        if flg == -1 % Put
            DerivatePrices(i,j) = max(DerivatePrices(i,j),max(X-Stock(i,j),0));
        else %Call
            DerivatePrices(i,j) = max(DerivatePrices(i,j),max(Stock(i,j)-X,0));
        end
    end; 

end;
Price_JR = DerivatePrices(1,1);

end
end