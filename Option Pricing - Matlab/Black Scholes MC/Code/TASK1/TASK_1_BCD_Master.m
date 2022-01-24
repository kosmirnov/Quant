
% Task 1B: Calculate European Call Value with Monte Carlo with the given data set
%%  Input of data set #4
clear;
clc;
seed=127;                                                                                                               
rng(seed);
S0=40;
X=35;
T=1;
r=0.02;
q=0.05;
sigma=0.22;
t=0;
n_stop=300000;                                                              % Number of realizations
n_steps=5000:5000:300000;                                                   % realization steps for Task 1B

%% TASK 1B: Calculations & Plots
% Monte Carlo price calculation
[~,~,MC_price]=MC_price_euro(S0,X,T,t,r,q,sigma,n_stop);
% Theoretical BSM price calculation
BSM_price=BSMCall(S0,X,T,t,r,q,sigma);
% plot for different realizations
Task_1B_plot=plot_1B(S0,X,T,t,r,q,sigma,n_steps);

%% Task 1C: Plot the histogramm for different stock prices
[S,~,~]=MC_price_euro(S0,X,T,t,r,q,sigma,n_stop);
figure;
histogram(S);
xlabel('Stock price');
ylabel('Density');
title('Stock Price density for 300,000 realizations')
saveas(gcf,'task_1c.jpeg');


%% Task 1D:  Antithetic Variance Technique
[TASK_1D_plot_var,TASK_1D_plot_confi]=plot_1D(S0,X,T,t,r,q,sigma,n_steps);
