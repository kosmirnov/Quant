function[Price_JR_BBS] = Binomial_JR_BBS(S,X,r,q,sig,T,n,flg,ind)
% This function creates a matrix of the evolution of the option prices,
% both for a European and American put and call options (which are determined by the
% input value ind)
% ind=0 -> European
% ind=1 -> American

% Step 1: creation of the matrix of the evolution of stock prices. We
% recall the function S_JR
Stock = S_JR(S,T,r,q,sig,n);


delta_T = T./n; % Time increment
DerivatePrices=zeros(n,n); %preallocation of the matrix dimension


p = 0.5; % prob for an up move with JR Method


%Step 2: calculate the value at the time step before maturity with the BSM
%price
if ind==1 %American
    if flg==-1 %Put
        for k=1:n
            DerivatePrices(k,n)=max(BSMP(Stock(k,n),X,r,q,sig,0,delta_T), X - Stock(k,n));
        end
    elseif flg==1
        for k=1:n
            DerivatePrices(k,n)=max(BSMC(Stock(k,n),X,r,q,sig,0,delta_T), Stock(k,n)-X);
        end
    end
elseif ind==0 %European
    if flg==-1 %put
        for k=1:n
            DerivatePrices(k,n)=BSMP(Stock(k,n),X,r,q,sig,0,delta_T);
        end
    elseif flg==1 %Call
        for k=1:n
            DerivatePrices(k,n)=BSMC(Stock(k,n),X,r,q,sig,0,delta_T);
        end
    end
end   

% Step 3: backward iteration in the calculation of the option price at each
% time step delta_T
if ind==1 % American
    if flg==-1 %put
        for j = n-1:-1:1
            for i = 1:j
                DerivatePrices(i,j) = max(exp(-r.*delta_T).*(p.*DerivatePrices(i,j+1) + (1-p).*DerivatePrices(i+1,j+1)) , X -Stock(i,j));
            end
        end
    elseif flg==1 %Call
        for j = n-1:-1:1
            for i = 1:j
                DerivatePrices(i,j) = max(exp(-r.*delta_T).*(p.*DerivatePrices(i,j+1) + (1-p).*DerivatePrices(i+1,j+1)) , Stock(i,j)-X);
            end
        end
    end


elseif ind==0 %European
    for j = n-1:-1:1
        for i = 1:j
            DerivatePrices(i,j) = exp(-r.*delta_T).*(p.*DerivatePrices(i,j+1) + (1-p).*DerivatePrices(i+1,j+1));
        end
    end

end

Price_JR_BBS =DerivatePrices(1,1);
end




