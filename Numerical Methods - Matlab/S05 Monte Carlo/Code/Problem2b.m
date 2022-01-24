%% Assignment #5: Monte Carlo Approach %%
%% Problem 2b: Accuracy and Efficiency discussion for increasing n %%
%% by Konstantin Smirnov / 3980253 %%

clear;
clc;
close all;

S = 100;         % stock price
K = 100;         % Strike
T = 0.5;         % time to maturity 
t = 0;           % today
r = 0.0953;      % interest rate
vt = 0.2;        % volatility of volatility
kp = 4.0;        % kappa
th = 0.2;        % theta
sg = 0.1;        % sigma
rh = -0.5;       % rho / correlation coefficient 
eta = vt;
jjj=7777;
[stream1, stream2] = RandStream.create('mrg32k3a','NumStreams',2,'Seed',jjj);


for i=1:14;
    nn(i)=2^i;
end

NN=[1000,10000];
price_U=zeros(length(nn),length(NN));
price_CVT=zeros(length(nn),length(NN));
var_U=zeros(length(nn),length(NN));
var_CVT=zeros(length(nn),length(NN));
price_true=zeros(length(nn),1);

for i=1:length(price_U);
price_true(i)=8.243;
end

for kk=1:length(NN);
    for ii=1:length(nn);
err1 = randn(stream1,nn(ii),NN(kk));
err2 = randn(stream2,nn(ii),NN(kk));
[price_U(ii,kk),var_U(ii,kk)]=MC_USUAL(S,K,T,t,r,vt,kp,th,sg,rh,err1,err2,nn(ii),NN(kk));
[price_CVT(ii,kk),var_CVT(ii,kk)]=MC_CVT(S,K,T,t,r,vt,kp,th,sg,eta,rh,err1,err2,nn(ii),NN(kk));
    end
end
% Test 2: nn = 1000, NN= 1000;

%% Plots of 2b)%%

figure;
semilogx(nn,price_true,'k',...
         nn,price_U(:,1),...
         nn,price_CVT(:,1),...
         'LineWidth',1.5);
legend('True Value',...
        'Usual Estimator',...
        'CVT Estimator',...
       'Location','northwest');
xlabel('number of increments n (log-scale)');    
ylabel('Call Price');
xlim([10 10000]);
ax1=gca;
ax1.YTick=[7.6 7.8 8.0 8.2 8.4 8.6 8.8];
ylim([7.6 8.8]);
title('Time increment convergence for N=1000');
% saveas(gcf,'plot31.jpeg');

figure;
semilogx(nn,price_true,'k',...
         nn,price_U(:,2),...
         nn,price_CVT(:,2),...
         'LineWidth',1.5);
legend('True Value',...
        'Usual Estimator',...
        'CVT Estimator',...
       'Location','northwest');
xlabel('number of time increments n (log-scale)');    
ylabel('Call Price');
ax2=gca;
ax2.YTick=[7.6 7.8 8.0 8.2 8.4 8.6 8.8];
ylim([7.6 8.8]);
xlim([10 10000]);
title('Time increment convergence for N=10,000');
% saveas(gcf,'plot32.jpeg');


figure;
loglog(nn,sqrt(var_U(:,1)),...
         nn,sqrt(var_CVT(:,1)),...
         'LineWidth',1.5);
hold on;
loglog(nn,sqrt(var_U(:,2)),'o--',...
         nn,sqrt(var_CVT(:,2)),'o--',...
         'LineWidth',1.5);
legend( 'Usual Estimator with N=1000',...
        'CVT Estimator with N=1000',...
        'Usual Estimator with N=10,000',...
        'CVT Estimator with N=10,000',...
       'Location','northwest');
xlabel('number of time increments n (log-scale)');    
ylabel('estimated standard deviation (log-scale)');
xlim([10 10000]);
title('Time increment convergence: estimated standard deviation');
% saveas(gcf,'plot33.jpeg');

