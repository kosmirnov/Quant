%% Assignment #5: Monte Carlo Approach %%
%% Problem 2b: Accuracy and Efficiency discussion for increasing N %%
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
nn=5000;

jjj=7777;
[stream1, stream2] = RandStream.create('mrg32k3a','NumStreams',2,'Seed',jjj);

%% Proove of the Efficiency Factor 
NN_Simu=1000;

CVT_err1 = randn(stream1,nn,NN_Simu);
CVT_err2 = randn(stream2,nn,NN_Simu);
[MC_price_CVT,Var_CVT,AA]=MC_CVT(S,K,T,t,r,vt,kp,th,sg,eta,rh,CVT_err1,CVT_err2,nn,NN_Simu);
% Theoretical Efficiency improvement : N/1-rho^2 
corrXY=corrcov(AA); % AA is the Cov(X,Y)
corrXY=corrXY(1,2);
Efficiency_Factor=1./(1-corrXY.^2);
% The Efficiency Factor in around 30.49. This means that the CVT need 30x
% less simulations sample path simulations n then the usual estimator.

% This is proven here:
NN_EF=round(NN_Simu./(1-corrXY.^2));

% to achieve the same variance as the CVT with N=1000,  the usual estimator
% needs N=30491 simulations
U_err1 = randn(stream1,nn,NN_EF);
U_err2 = randn(stream2,nn,NN_EF);
[MC_price_usual,Var_usual]=MC_USUAL(S,K,T,t,r,vt,kp,th,sg,rh,U_err1,U_err2,nn,NN_EF);
% as you can see, the variance of both estimates is (almost) equal.


%% 2a) Control-Variate Technique: Comparison for increasing number of simulated stock paths N

% Output Vectors of the usual 
% 1st colum: Number of Simulations
% 2nd colum: true price (8.243)
% 3rd column: estimated price
% 4th column: error
% 5th column: estimated variance
% 6th & 7th columns: 95% - CI's
% 8th column: meisured computational time

NN_Vec1=(100:100:1000)';
NN_Vec2=(2000:1000:10000)';
NN_Vec=[NN_Vec1;NN_Vec2];
SZ_usual=zeros(length(NN_Vec),8);
SZ_CVT=zeros(length(NN_Vec),8);

SZ_usual(:,1)=NN_Vec;
SZ_CVT(:,1)=NN_Vec;

% Loop for MC for SZ-Model WITHOUT CV for increasing N
for ii=1:length(SZ_usual)
% generate random errors
U_err1 = randn(stream1,nn,NN_Vec(ii));
U_err2 = randn(stream2,nn,NN_Vec(ii));
% write true price into 1st column
SZ_usual(ii,2)=8.243;
% estimate price and variance
tic;
[SZ_usual(ii,3),SZ_usual(ii,5)]=MC_USUAL(S,K,T,t,r,vt,kp,th,sg,rh,U_err1,U_err2,nn,NN_Vec(ii));
% meisure time
SZ_usual(ii,8)=toc;
% compute error
SZ_usual(ii,4)=SZ_usual(ii,2)-SZ_usual(ii,3);
% compute 95% CI's
SZ_usual(ii,6)=SZ_usual(ii,3)+1.96*sqrt(SZ_usual(ii,5));
SZ_usual(ii,7)=SZ_usual(ii,3)-1.96*sqrt(SZ_usual(ii,5));
end


% same for CVT
for ii=1:length(NN_Vec)
CVT_err1 = randn(stream1,nn,NN_Vec(ii));
CVT_err2 = randn(stream2,nn,NN_Vec(ii));
SZ_CVT(ii,2)=8.243;
tic;
[SZ_CVT(ii,3),SZ_CVT(ii,5)]=MC_CVT(S,K,T,t,r,vt,kp,th,sg,eta,rh,CVT_err1,CVT_err2,nn,NN_Vec(ii));
SZ_CVT(ii,8)=toc;
SZ_CVT(ii,4)=SZ_CVT(ii,2)-SZ_CVT(ii,3);
SZ_CVT(ii,6)=SZ_CVT(ii,3)+1.96*sqrt(SZ_CVT(ii,5));
SZ_CVT(ii,7)=SZ_CVT(ii,3)-1.96*sqrt(SZ_CVT(ii,5));
end


%% Plots of 2a)%%

% 0-Vec for plotting %
vec_0=zeros(length(NN_Vec),1);

figure;
semilogx(NN_Vec,SZ_usual(:,2),'k',...
         NN_Vec,SZ_usual(:,3),'-o',...
         NN_Vec,SZ_CVT(:,3),'-o',...
         NN_Vec,SZ_usual(:,6),'y--',NN_Vec,SZ_CVT(:,6),'r--',...
         NN_Vec,SZ_usual(:,7),'y--',NN_Vec,SZ_CVT(:,7),'r--',...
         'LineWidth',1.5);
legend('True Value',...
        'Usual Estimator',...
        'CVT Estimator',...
        'Confidence Interval: Usual',...
        'Confidence Interval: CVT','Location','northeast');
xlabel('number of simulations N (log-scale)');    
ylabel('Call price');
title('Accuracy of the CVT for increasing N - Usual Estimator vs. CVT');
% saveas(gcf,'plot21.jpeg');

figure;
semilogx(NN_Vec,sqrt(SZ_usual(:,5)),...
         NN_Vec,sqrt(SZ_CVT(:,5)),...
         'LineWidth',1.5);
legend( 'Usual Estimator',...
        'CVT Estimator',...
        'Location','northeast');
xlabel('number of simulations N (log-scale)');    
ylabel('estimated standard deviation');
title('Accuracy of the CVT for increasing N - Estimated Standard Deviation');
% saveas(gcf,'plot22.jpeg');

figure;
semilogx(NN_Vec,vec_0,'k',...
    NN_Vec,SZ_usual(:,4),...
    NN_Vec,SZ_CVT(:,4),...
    'LineWidth',1.5);
legend( 'True Value',...
        'Usual Estimator',...
        'CVT Estimator',...
        'Location','southeast');
xlabel('number of simulations N (log-scale)');    
ylabel('error');
title('Accuracy of the CVT for increasing N - Estimated Error');
% saveas(gcf,'plot23.jpeg');

figure;
semilogx(SZ_usual(:,8),SZ_usual(:,2),'k',...
    SZ_usual(:,8),SZ_usual(:,3),...
    SZ_CVT(:,8),SZ_CVT(:,3),...
    'LineWidth',1.5);
legend( 'True Value',...
        'Usual Estimator',...
        'CVT Estimator',...
        'Location','northeast');
xlabel('computational time (in sec)');    
ylabel('Call price');
xlim([0.1 10]);
title('Efficiency of the CVT for increasing N - Price Convergence');
% saveas(gcf,'plot24.jpeg');

figure;
semilogx(SZ_usual(:,8),sqrt(SZ_usual(:,5)),...
         SZ_CVT(:,8),sqrt(SZ_CVT(:,5)),...
        'LineWidth',1.5);
legend( 'Usual Estimator',...
        'CVT Estimator',...
        'Location','northeast');
xlabel('computational time (in sec and log scale)');    
ylabel('estimated standard deviation');
xlim([0.1 10]);
title('Efficiency of the CVT for increasing N - Estimated standard deviation');
% saveas(gcf,'plot25.jpeg');

figure;
semilogx(NN_Vec, SZ_CVT(:,8),...
         NN_Vec, SZ_usual(:,8),...
         'LineWidth',1.5);
legend( 'CVT Estimator',...
        'Usual Estimator',...
        'Location','northeast');
xlabel('number of simulations N (log-scale)');    
ylabel('computational time (in sec)');
title('Efficiency of the CVT for increasing N - absolute Computational Effort');
% saveas(gcf,'plot26.jpeg');



