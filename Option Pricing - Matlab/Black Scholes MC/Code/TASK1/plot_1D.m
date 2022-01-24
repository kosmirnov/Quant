
%% Calculaiton of BSM-Call by using Monte Carlo Simulation for antithetic variates
% clear;
% clc;
% seed=127;                                                                                                               
% rng(seed);
% S0=40;
% X=35;
% T=1;
% r=0.02;
% q=0.05;
% sigma=0.22;
% t=0;
% n_stop=300000;                                                              % Number of realizations
% n_steps=5000:5000:300000;       


function [TASK_1D_plot_var,TASK_1D_plot_confi]=plot_1D(S0,X,T,t,r,q,sigma,n_steps)
n=1;                                                                        % number of subintervals, since we deal with a simple European option, which is not path-depending                                                                             % we use the exact approach (1-step approach)    
dt=(T-t)/n;                                                                 % is equal to Time to maturity
row=1;                                                                      % count variable


for N=n_steps
    S1=nan(N, n+1);
    S2=nan(N, n+1);
    S1(:,1)=S0;
    S2(:,1)=S0;


        S1(:,2)=S0.*exp(((r-q)-0.5.*sigma.^2).*dt+...
            sigma.*sqrt(dt).*randn(N,1));
        
        S2(:,2)=S0.*exp(((r-q)-0.5.*sigma.^2).*dt+...
            sigma.*sqrt(dt).*-randn(N,1));
        
                         
         X_j= (S1(:,2)+S2(:,2))/2;
         disc_xj=exp(-r*(T-t))*X_j;
         mean_xj=mean(disc_xj);
 
         
            var_at(row,1)=sum((disc_xj-mean_xj).^2)./(N-1);
            se_at(row,1)=sqrt(var_at(row,1));
            Payoff=max(0,S1(:,end)-X);
            disc_payoff=exp(-r*(T-t))*Payoff;
            MC_call(row,1)=mean(disc_payoff);
            var_mc(row,1)=var(disc_payoff);
           

        Confi_up(row, 1)=MC_call(row,1)+1.959963985*sqrt(var_mc(row,1)/N);
        Confi_down(row, 1)=MC_call(row,1)-1.959963985*sqrt(var_mc(row,1)/N);
        
        Confi_newu(row, 1)=MC_call(row,1)+1.959963985*(se_at(row,1)/sqrt(N));
        Confi_newd(row, 1)=MC_call(row,1)-1.959963985*(se_at(row,1)/sqrt(N));
        
        Call_BSM(row,1)=BSMCall(S0,X,T,t,r,q,sigma);
        
    
    row=row+1;
        
              
    end
    
    
    
  

%2D-plot of call prices (BSM-Call vs MC-Call in dependence of the number of
%simulation paths.

figure;
TASK_1D_plot_var=plot(n_steps,var_at,n_steps, var_mc);

xlabel('N');
ylabel('Variance');
title('TASK 1D: Antithetic Variates Technique: Variance Reduction');
legend('Variance without AVT','Variance with AVT');
saveas(gcf,'task_1d_var.jpeg');


figure;
TASK_1D_plot_confi=plot(n_steps,Call_BSM,n_steps,MC_call,n_steps,Confi_up,'r',n_steps,Confi_down,'r',n_steps,Confi_newd,'b',n_steps,Confi_newu,'b');

xlabel('N');
ylabel('Variance');
title('TASK 1D: Antithetic Variates Technique: Confidence Intervals');
legend('theoretical BSM price','simulated BSM price', 'CI without AVT','~','CI with AVT');
saveas(gcf,'task_1d_var.jpeg');

