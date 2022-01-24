%% Assignment #4: Option Valuation using Fourier Transform Methods %%
%% Problem 2: Sample Calculation of SZ-Model %%
%% by Konstantin Smirnov / 3980253 %%


clear;
clc;
close all;

S=100;
K=95;
T=0.5;
t=0;
r=0.0953;
kp=4;
sg=0.1;
th=0.3;
rh=-0.5;
vt=0.2;
q=0;
h=r-q;

% phi_max=10
price_10 =SZ_FourierInv(S,K,T,t,r,kp,sg,th,rh,vt,10,1);

% phi_max=25
price_25 =SZ_FourierInv(S,K,T,t,r,kp,sg,th,rh,vt,25,1);

% phi_max=50
price_50 =SZ_FourierInv(S,K,T,t,r,kp,sg,th,rh,vt,50,1);