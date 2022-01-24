%% Plot for different rho's
function [plot_2B_rho,plot_2B_rho_diff]=plot_2B(S0_1,S0_2,r,q1,q2,sigma1,sigma2,rho_length,T,t,N_stop)
n=1;
for rho=rho_length    
[MC_price_EEO(n),CI_up(n),CI_down(n),~]=MC_EEO(S0_1,S0_2,r,q1,q2,sigma1,sigma2,rho,T,N_stop);
Theo_price_EEO(n)=THEO_EEO(S0_1,S0_2,q1,q2,sigma1,sigma2,rho,T,t);
diff(n)=MC_price_EEO(n)-Theo_price_EEO(n);
n=n+1;
end;

figure;
plot_2B_rho=plot(rho_length,MC_price_EEO,rho_length,Theo_price_EEO,rho_length,CI_up,rho_length,CI_down,'LineWidth',1.5);
xlabel('Correlation coefficient');
ylabel('EEO price');
title('Plot 2B: MC EEO price vs. threotical EEO price  ')
legend('Monte-Carlo EEO price','theoretical EEO price','upper CI of MC','lower CI of MC');
saveas(gcf,'plot_2B.jpeg');


figure;
plot_2B_rho_diff=plot(rho_length,diff);
xlabel('Correlation coefficient');
ylabel('EEO price difference');
title('Plot 2B: MC EEO price vs. threotical EEO price  ')
saveas(gcf,'plot_2B_diff.jpeg');    