%% TASK 2: Calculation of Implied Interest Rates and Volatility

clc;
clear;


% Dataset
S=10077;  % Index Price
t= 0;
T= (63/360); % Time to Maturity according to ODAX-Calendar
Data = xlsread('StrikesandPricesJune2016');     %Read in Data for data set #2
X= Data(:,1);       % Strike vector according to data set #2
put= Data(:,2);     % put prices vector for different strikes according to data set #2    
call = Data(:,3);   % put prices vector for different strikes according to data set #2


% 2a) Implied Interest Rates:  Calculation of r via Put-Call-Parity
fprintf('Calculated implied Interest Rate with respect to data set');
format long g      % write implied IR in command window in numerical format
[r_implied_mean,~]=r_implied(S,call,put,X,T,t)
[~,r_vec]=r_implied(S,call,put,X,T,t);

% 2b und c) Implied Vola Calculation and Volatiliy Smile
[vola,vola_smile]=implied_vola(S,X,T,t,r_implied_mean,put);  % Functions for implied volavec & volasmile graph with implied r