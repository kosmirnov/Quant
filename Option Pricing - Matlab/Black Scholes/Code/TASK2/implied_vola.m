% Newton-Rapthon Calculation for Implied Vola

function [vola,vola_smile]=implied_vola(S,X,T,t,r,put)
sigma = 0.50;                                        % start value for sigma for NR-Method
bsm_put= 0;                                          % start value for put for NR-Method
tol=0.00000000001;                                   % Tolerance for while-loop to calculate the implied vola for NR-Method
while abs(bsm_put - put) > tol,         
   sig_it = sigma;
   bsm_put =bsm_put_t2(S,X,T,t,r,sig_it);           % Put Price Calculation
   vega_put=vega(S,X,T,t,r,sig_it);                 % Vega Function 
    
   sigma = sig_it - (bsm_put - put) ./ vega_put;    %Newton-Raphson equation
	

end

vola = sigma;                                      %Implied Volatiliy Vector
figure;

money=X./S;                                         %Moneyness
vola_smile=plot(money,vola,'ro');
xlabel('Moneyness');
ylabel('Implied Volatility');
title('Volatility Smile for data set #2');
saveas(gcf,'t2_volasmile.jpg');





