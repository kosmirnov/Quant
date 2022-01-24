%% Simulation of seven paths of the underlying asset depending on the

clear;
clc;

% input data for problem 1 - data set group # 4
seed=127;       % influence factor for random process
rng(seed);
S0=40;          % stock price
X=35;           % strike price
T=1;            % (T-t) - Time to maturity
t=0;            % (T-t) - Time to maturity
r=0.02;         % risk-free interest rate
q=0.05;         % continous dividend yield
sigma=[0;0.1;0.2;0.3;0.4;0.5;0.6];     % different volatiliy levels


N=size(sigma,1);    

n=10;                                                                       % number of subintervals to calculate the stock price evolution with the step by step approach
                                                                          
     
     
dt=(T-t)/n;                                                                 % is equal to Time to maturity
time=t:dt:T;
     


S=nan(N, n+1);
S(:,1)=S0;


for j=2:length(time)
    
     S(:,j)=S0.*exp(((r-q)-0.5.*sigma.^2).*dt+...
        sigma.*sqrt(dt).*randn(N,1));
    
end
   
   
% 2D-plot of stock paths

figure;
plot(time,S','LineWidth',1.5);
xlabel('Time to maturity');
ylabel('Stock price paths');
title('Stock price evolution');
legend('sigma=0','sigma=0.1','sigma=0.2','sigma=0.3','sigma=0.4','sigma=0.5',...
    'sigma=0.6','Location', 'northwest');
grid on;
saveas(gcf,'task_1a.jpeg');