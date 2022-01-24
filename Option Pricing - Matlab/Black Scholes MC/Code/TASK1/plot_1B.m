%% Plots for 1B

function Task_1B_Plot=plot_1B(S0,X,T,t,r,q,sigma,n_steps)

N_Vec=1;


for n_stop=n_steps
    [~,disc_payoff,MC_price(N_Vec)]=MC_price_euro(S0,X,T,t,r,q,sigma,n_stop);    % call prices for 
    BSM_price(N_Vec)=BSMCall(S0,X,T,t,r,q,sigma);
    sigma_hat=sqrt(var(disc_payoff));                           % calculate corr. variance for Confis
    Confi_up(N_Vec)=MC_price(N_Vec)+1.959963985*sigma_hat/sqrt(n_stop);
    Confi_down(N_Vec)=MC_price(N_Vec)-1.959963985*sigma_hat/sqrt(n_stop);  
    N_Vec=N_Vec+1;
end

 
    
figure;
Task_1B_Plot=plot(n_steps,MC_price,n_steps,BSM_price,n_steps,Confi_up,'r',n_steps,Confi_down,'r','LineWidth',1.5);
xlabel('Number of realizations');
ylabel('Call price');
title('Plot 1B: Monte-Carlo prices for different numbers of realizations')
legend('Monte-Carlo price','theoretical BSM price','upper CI of MC','lower CI of MC');
saveas(gcf,'task_1b.jpeg');