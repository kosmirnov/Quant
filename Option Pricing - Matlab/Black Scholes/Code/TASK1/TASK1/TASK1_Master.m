%% TASK 1A: Computation
clc;
clear;

S=70;               % stock price
X=65;               % strike price
r=0.03;             % interest rate
q=0.03;             % cont. div. yield
sigma=0.35;         % Volatility
T=0.25; 
t=0;                % T-t is the time to maturity




S_Length=1;           %% For simple Computation set vector size to 1
fprintf('Upper and Lower Bound of the Put');
[UB_Put,LB_Put]=Bounds(S,X,T,t,r,q,S_Length)

fprintf('Fair Price of the Option according to BSM');
Put_BSM=BSM_Put_Task1(S,X,T,t,r,q,sigma)
fprintf('Greeks:');
[Delta_Put,Gamma_Put,Theta_Put,Vega_Put]=Greeks(S,X,T,t,r,q,sigma)

%%  TASK 1B: 2D Graphs 
%Function to call 2D Graph for BSM-Price & Bounds dependending on Stock
Stock_2D=BSM_Graph_Stock(S,X,r,q,sigma,T,t);   
%% Function to call 2D Graph for BSM-Price & Bounds dependending on T2t
Time_2D=BSM_Graph_Time(S,X,t,r,q,sigma);                



%% TASK 1C: 3D Graphs
%% 3D Graph for BSM Price
BSM_3D=BSM_Put_Meshgrid(S,X,r,q,sigma,t);
%% 3D Graph for Delta
delta_3D=Delta_3D_Greeks(S,X,t,r,q,sigma);
%% 3D Graph for Gamma
gamma_3D=Gamma_3D_Greeks(S,X,t,r,q,sigma);
%% 3D Graph for Theta
theta_3D=Theta_3D_Greeks(S,X,t,r,q,sigma);
%% 3D Graph for Vega
vega_3D=Vega_3D_Greeks(S,X,t,r,q,sigma);

