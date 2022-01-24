%% Main Algorithm of the CVT estimator
function [SZ_price_cv,est_var,AA]=MC_CVT(S,K,T,t,r,vt,kp,th,sg,eta,rh,err1,err2,nn,NN)
% 
% err1 = randn(stream1,nn,NN);
% err2 = randn(stream2,nn,NN);

dt = (T-t)/nn;  % discretized time interval

SS = zeros(nn+1,NN);  % matrix of simulated stock prices
vv = zeros(nn+1,NN);  % matrix of simulated volatilities
SSc = zeros(nn+1,NN); % control path matrix

dSS = zeros(nn,NN);   % changes in stock prices
dvv = zeros(nn,NN);   % changes in the volatilities
dSSc = zeros(nn,NN);  % changes in the stock prices controlled paths

%dW1 = zeros(nn,NN);   % change in the Brownian Motion
%dW2 = zeros(nn,NN);   % another independent Brownian Motion Increment

% starting values
SS(1,:) = S;
vv(1,:) = vt;
SSc(1,:) = S;

% % random path generation, drawn from Gaussian standard normal
% err1 = randn(stream1,nn,NN);
% err2 = randn(stream2,nn,NN);

% Main loop of simulation 
for jj = 1:1:NN 
    dW1 = sqrt(dt).*err1(:,jj); %stock price path
    dW2 = rh.*dW1 + sqrt((1-rh.^2).*dt).*err2(:,jj); % volatility path
    
    % simulation of nn increments per path
    for ii = 1:1:nn 
        % Euler Approximation of a single path
        dSS(ii,jj) = r.*SS(ii,jj).*dt + vv(ii,jj).*SS(ii,jj).*dW1(ii);
        dvv(ii,jj) = kp.*(th - vv(ii,jj)).*dt +sg.*dW2(ii);
        
        dSSc(ii,jj) = r.*SSc(ii,jj).*dt + eta.*SSc(ii,jj).*dW1(ii);
        
        SS(ii+1,jj) = SS(ii,jj) + dSS(ii,jj); 
        vv(ii+1,jj) = vv(ii,jj) + dvv(ii,jj);
        SSc(ii+1,jj) = SSc(ii,jj) + dSSc(ii,jj);
    end
end

X = exp(-r.*(T-t)).*max(SSc(nn+1,:)-K,0); % using the control stock path
CALL_th = BSMC(S,K,T,t,r,r,eta); % theoretical Call price

Y = exp(-r.*(T-t)).*max(SS(nn+1,:)-K,0); % using the simulated stock path
 % MC simulated call price  
% call_eu = mean(Y);
% var_eu = var(Y); 

% Application of the control variate technique
AA = cov(Y,X);
b = AA(1,2)./AA(2,2);  % optimal beta coefficient which minimized the variance 
% of the control variate estimator


% MC simulated Call price using the control variate technique
SZ_price_cv = mean(Y - b.*(X - CALL_th)); 
est_var= var(Y - b.*(X - CALL_th))./(NN);

end
