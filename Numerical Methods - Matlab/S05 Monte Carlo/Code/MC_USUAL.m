%% Main Algorithm of the usual estimator
function [SZ_price,est_var]=MC_USUAL(S,K,T,t,r,vt,kp,th,sg,rh,err1,err2,nn,NN)

dt = (T-t)/nn;  % discretized time interval

SS = zeros(nn+1,NN);  % matrix of simulated stock prices
vv = zeros(nn+1,NN);  % matrix of simulated volatilities

dSS = zeros(nn,NN);   % changes in stock prices
dvv = zeros(nn,NN);   % changes in the volatilities


% starting values
SS(1,:) = S;
vv(1,:) = vt;

% Main loop of simulation 
for jj = 1:1:NN 
    dW1 = sqrt(dt).*err1(:,jj); %stock price path
    dW2 = rh.*dW1 + sqrt((1-rh.^2).*dt).*err2(:,jj); % volatility path
    
    % simulation of nn increments per path
    for ii = 1:1:nn 
        % Euler Approximation of a single path
        dSS(ii,jj) = r.*SS(ii,jj).*dt + vv(ii,jj).*SS(ii,jj).*dW1(ii);
        dvv(ii,jj) = kp.*(th - vv(ii,jj)).*dt +sg.*dW2(ii);
        
        SS(ii+1,jj) = SS(ii,jj) + dSS(ii,jj); 
        vv(ii+1,jj) = vv(ii,jj) + dvv(ii,jj);
    end
end

Y = exp(-r.*(T-t)).*max(SS(nn+1,:)-K,0); % using the simulated stock path

% MC simulated Call price 
SZ_price = mean(Y);
est_var= var(Y)./(NN);
end
