%% Assignment #4: Option Valuation using Fourier Transform Methods %%
%% Problem 3: Heston trap %%
%% by Konstantin Smirnov / 3980253 %%

clear;
clc;
close all;

S=100;
K=120;
T=10;
t=0;
r=0.0953;
kp=4;
sg=2;
th=0.5;
rh=-0.8;
vt=0.15;
q=0;
h=r-q;

% SZ price without correction
% integrals to plot the CDF
[~,intg1_wrong] = InvIntegral_SZ(1,S,K,T,t,r,kp,sg,th,rh,vt,25,0);
[~,intg2_wrong] = InvIntegral_SZ(2,S,K,T,t,r,kp,sg,th,rh,vt,25,0);

price_wrong = SZ_FourierInv(S,K,T,t,r,kp,sg,th,rh,vt,25,0);

% SZ price with correction
[~,intg1_true] = InvIntegral_SZ(1,S,K,T,t,r,kp,sg,th,rh,vt,25,1);
[~,intg2_true] = InvIntegral_SZ(2,S,K,T,t,r,kp,sg,th,rh,vt,25,1);

price_true =SZ_FourierInv(S,K,T,t,r,kp,sg,th,rh,vt,25,1);


%% plots of the integers for illustration %%
ph = (eps: 0.001 : 25)';

plotn1=figure;
plot(ph,real(intg1_true),'LineWidth',1.5);
hold on;
plot(ph,real(intg1_wrong),'LineWidth',1.5);
xlabel('\phi');
ylabel('Real Value of Integer');
legend('corrected value','wrong value');
xlim([0 2]);
title('Integer of N1: Heston trap vs. Correction');
% saveas(gcf,'plot31.jpeg');

plotn2=figure;
plot(ph,real(intg2_true),'LineWidth',1.5);
hold on;
plot(ph,real(intg2_wrong),'LineWidth',1.5);
xlabel('\phi');
ylabel('Real Value of Integer');
xlim([0 2]);
legend('corrected value','wrong value');
title('Integer of N2: Heston trap vs. Correction');
% saveas(gcf,'plot32.jpeg');
