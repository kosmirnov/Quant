%% Assignment #3: Graphical Analysis of Characteristic Functions  %%
%%%%% by KONSTANTIN SMIRNOV %%%%%
%%
clear;
clc;
close all;

%% Problem 1: Exponential Function %%
[Plot1,Plot2,Plot3,Plot4,Plot5,Plot6]=cexp;   % plot all 6 illustrations of the complex exponential function




%% Problem 2: Characteristic Function of the normal distribution
%% 2.1. Plot the Characteristic Functions %%
% plots 24 figures
ph = eps:0.001:5;  
mu_vec=[0;1;4;16];
sg_vec=[0;1;2];
[znorm,wnorm]=cnorm(ph,mu_vec,sg_vec);

%% 2.2. Include the Characteristic Functions for given mu and sg into the exp. funct %%
% plots 18 figures
phi2=(0:0.01:1);  % Note that it doesn't make sense to plot for more phi's due to construction reasons
mu_vec2=[1;4;16]; % Note that the parameter 0 does not make sense due to construction since the grid is depended on that parameter
sg_vec2=[1;2];
[embed_imag,embed_real,embed_abs]=cnorm_embed(phi2,mu_vec2,sg_vec2);




%% Problem 3: Complex Log %%%
% to turn-off the 'movie' function, choose 'N' as an input parameter
[Plot9,Plot10,Plot11,Plot12,Plot13,Plot14,Plot15]=clog('Y');



%% Problem 4: Characteristic Function for Stochastic Volatility
% parameters are given in the assignment %
% plots 36 figures 
rh_vec = [0;1];       
sg_vec_vol = [0.9 3.0 9.0];
th_vec = [0.5 0.2 0];
[zvol,wvol]=cvol(rh_vec,sg_vec_vol,th_vec);
