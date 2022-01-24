clc;
clear;

%% Read in data of opportunity set
returns = xlsread('DataG02.xls','Tabelle1','B2:I61');
r_f_vec=xlsread('DataG02.xls','Tabelle2','N7:N66');

%% 2 Mathematics of the efficient frontier
% Calculate the expected asset returns and the VCM of opportunity set
r=(mean(returns))';
Sigma=cov(returns);
disp('The returns of the opportunity set are: ')
disp(r);
disp('  ');
disp('The Variance-Covariance-Matrix of the opportunity set: ')
disp(Sigma);
disp('  ');


% Check the eigenvalues and determinant of the VCM
eigenvalues=eig(Sigma);
determinant=det(Sigma);
disp('The eigenvalues of the VCM are: ')
disp(eigenvalues);
disp('  ');
disp('The determinant of the VCM is: ')
disp(determinant);
disp('  ');

% Set up help variables
NN=length(r);
e = ones(NN,1);
V= inv(Sigma);

% Calculate auxiliary variables
A=r'*(Sigma\e);
B=r'*(Sigma\r);
C=e'*(Sigma\e);
D=B.*C - A.^2;

% Determine the Minimum-Variance Portfolio
r_min= A/C;
s2_min= 1/C;
w_min = (Sigma\e)/C;
disp('The return of the MVP is: ')
disp(r_min);
disp('  ');
disp('The volatility of the MVP is: ')
disp(sqrt(s2_min));
disp('  ');
disp('The weigths for the MVP are: ')
disp(w_min);
disp('  ');
% Set up the efficient frontier

% Set up variables that determine the weights
g= (B*(Sigma\e)-A*(Sigma\r))/D;
h= (C*(Sigma\r)-A*(Sigma\e))/D;

n=1400;
rE=zeros(n,1);
s2E=zeros(n,1);
wE=zeros(n,8);

for i = 1:1:n
    rE(i,1)= -0.04 + i*0.00025;
    wHlp = g + h*rE(i);
    wE(i,:) = wHlp;
    s2E(i,1)=wHlp'*Sigma*wHlp;
end


% Plot efficient frontier, with MVP and all assets of opportunity set
name_str = 'Efficient frontier and MVP of opportunity set';                    
figure('Name',name_str,'NumberTitle','off');  
x=plot(sqrt(diag(Sigma)),r,'o',sqrt(s2_min),r_min,'o',sqrt(s2E),rE);
set(x(1), 'MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',6);
set(x(2), 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',6);
set(x(3), 'Color',[0.4,0.4,0.4], 'LineWidth',2);
ax=gca;
xXLabel = xlabel('Return per month');
xYLabel = ylabel('Volatility per month');
ax.XLimMode = 'manual';
ax.XLim = [0 0.2];
ax.YLimMode = 'manual';
ax.YLim = [-0.03 0.05];
hLegend = legend( ...
  'Assets of Opportunity Set' , ...
  'Minimum Variance Portfolio'      , ...
  'Efficient Frontier'      , ...
  'location', 'NorthWest' );
set( ax                       , ...
    'FontName'   , 'Helvetica' );
set([ xXLabel, xYLabel], ...
    'FontName'   , 'AvantGarde');
set(hLegend             , ...
    'FontSize'   , 8           );
set([xXLabel, xYLabel]  , ...
    'FontSize'   , 10          );
set(ax, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'XTick'       , 0:0.05:0.2, ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , -0.03:0.01:0.05, ...
  'LineWidth'   , 1         );
set(ax,'FontSize',12)
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 Task2.eps



%% 3 Riskless asset and the Capital Allocation Line
r_f=0.0019 ;
s2_f=0;
% Calculate excess return for returns of opportunity set
R=r-r_f;

% Calculate weigths of tangent portfolio
A_prime=e'*(Sigma\R);
B_prime=(Sigma\R); 
w_T=B_prime./A_prime; 
disp('The weigths for the Tangency Portfolio are: ')
disp(w_T);
disp('  ');

% Calculate return and volatility of tangent portfolio
r_T=r'*w_T;
s2_T=w_T'*Sigma*w_T;
disp('The return of the Tangancy Portfolio is: ')
disp(r_T);
disp('  ');
disp('The volatility of the Tangency Portfolio is: ')
disp(sqrt(s2_T));
disp('  ');

% Set up CAL
sharpe_ratio=(r_T-r_f)/sqrt(s2_T); % slope of CAL


s_CAL=(0:0.01:0.5)';
n=length(0:0.01:0.5);
r_CAL_pos=zeros(n,1);
r_CAL_neg=zeros(n,1);

for i= 1:n
    r_CAL_pos(i,1)= r_f + sharpe_ratio*s_CAL(i,1);
    r_CAL_neg(i,1)= r_f - sharpe_ratio*s_CAL(i,1);
end


 
% Plot Riskless Portfolio, Tangengy Portfolio and Capital Allocation Line
name_str = 'Efficient frontier and MVP of opportunity set';                    
figure('Name',name_str,'NumberTitle','off');  
x=plot(sqrt(diag(Sigma)),r,'o',sqrt(s2_min),r_min,'o',sqrt(s2E),rE,...
       sqrt(s2_f),r_f,'o',sqrt(s2_T),r_T,'o', s_CAL, r_CAL_pos, ...
       s_CAL, r_CAL_neg);
set(x(1), 'MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',6);
set(x(2), 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',6);
set(x(3), 'Color',[0.4,0.4,0.4], 'LineWidth',2);
set(x(4), 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6);
set(x(5), 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6);
set(x(6), 'Color',[0.8,0.2,0], 'LineWidth',2);
set(x(7), 'Color',[0.8,0.2,0], 'LineWidth',2);
ax=gca;
xXLabel = xlabel('Return per month');
xYLabel = ylabel('Volatility per month');
ax.XLimMode = 'manual';
ax.XLim = [0 0.2];
ax.YLimMode = 'manual';
ax.YLim = [-0.03 0.05];
hLegend = legend( ...
  'Assets of Opportunity Set' , ...
  'Minimum Variance Portfolio'      , ...
  'Efficient Frontier'      , ...
  'Riskless Portfolio', ...
  'Tangency Portfolio', ...
  'Capital Allocation Line', ...
  'location', 'East' );
set( ax                       , ...
    'FontName'   , 'Helvetica' );
set([ xXLabel, xYLabel], ...
    'FontName'   , 'AvantGarde');
set(hLegend             , ...
    'FontSize'   , 8           );
set([xXLabel, xYLabel]  , ...
    'FontSize'   , 10          );
set(ax, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'XTick'       , 0:0.05:0.2, ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , -0.03:0.01:0.05, ...
  'LineWidth'   , 1         );
set(ax,'FontSize',12)
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 Task3.eps

%% 4 With historical data, the benchmark is inefficient

% Read-in market capitalisation
market_cap = xlsread('DataG02.xls','Tabelle2','C3:J3');
total_market_cap=sum(market_cap);
w_B= (market_cap/total_market_cap)';
%w_bench = xlsread('DataG02.xls','Tabelle2','C5:J5');
%r_bench = xlsread('DataG02.xls','Tabelle2','L7:L66');
%r_b=(w_bench*returns')';

% Calculate return of benchmark portfolio as well as the volatility

r_B=w_B'*r;
s2_B=w_B'*Sigma*w_B;
disp('The return of the Benchmark Portfolio is: ')
disp(r_B);
disp('  ');
disp('The volatility of the Benchmark Portfolio is: ')
disp(sqrt(s2_B));
disp('  ');
disp('The weigths for the Benchmark Portfolio are: ')
disp(w_B);
disp('  ');

% Show in the plot that the benchmark portfolio is not efficient

name_str = 'Inefficient benchmark Portfolio';                    
figure('Name',name_str,'NumberTitle','off');  
x=plot(sqrt(diag(Sigma)),r,'o',sqrt(s2_min),r_min,'o',sqrt(s2E),rE,...
       sqrt(s2_f),r_f,'o',sqrt(s2_T),r_T,'o', sqrt(s2_B),r_B,'o', ...
       s_CAL, r_CAL_pos, s_CAL, r_CAL_neg );
set(x(1), 'MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',6);
set(x(2), 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',6);
set(x(3), 'Color',[0.4,0.4,0.4], 'LineWidth',2);
set(x(4), 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6);
set(x(5), 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6);
set(x(6), 'MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6);
set(x(7), 'Color',[0.8,0.2,0], 'LineWidth',2);
set(x(8), 'Color',[0.8,0.2,0], 'LineWidth',2);
ax=gca;
xXLabel = xlabel('Return per month');
xYLabel = ylabel('Volatility per month');
ax.XLimMode = 'manual';
ax.XLim = [0 0.2];
ax.YLimMode = 'manual';
ax.YLim = [-0.03 0.05];
hLegend = legend( ...
  'Assets of Opportunity Set' , ...
  'Minimum Variance Portfolio'      , ...
  'Efficient Frontier'      , ...
  'Riskless Portfolio', ...
  'Tangency Portfolio', ...
  'Benchmark Portfolio' , ...
  'Capital Allocation Line', ...
  'location', 'East' );
set( ax                       , ...
    'FontName'   , 'Helvetica' );
set([ xXLabel, xYLabel], ...
    'FontName'   , 'AvantGarde');
set(hLegend             , ...
    'FontSize'   , 8           );
set([xXLabel, xYLabel]  , ...
    'FontSize'   , 10          );
set(ax, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'XTick'       , 0:0.05:0.2, ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , -0.03:0.01:0.05, ...
  'LineWidth'   , 1         );
set(ax,'FontSize',12)
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 Task4.eps

%% 5 Reverse Optimization: What does the market think?

% Given Data of Benchmark portfolio which is efficient
% expected excess return
R_B_new=0.0037;
r_B_new= R_B_new + r_f;
% weigths of benchmark portfolio stay the same
w_B=w_B;

% Calculate the implied expected returns R=r-r_f
betas=(Sigma*w_B)./(w_B'*Sigma*w_B);
R_imp=betas*R_B_new;
r_imp=R_imp+r_f;


disp('The implied returns of assets in the opportunity set are: ')
disp(r_imp);
disp('  ');

% Standard deviation of Benchmark Portfolio does not change
s2_B_imp=w_B'*Sigma*w_B;

disp('The return of the new Benchmark Portfolio is: ')
disp(r_B_new);
disp('  ');
disp('The volatility of the new Benchmark Portfolio is: ')
disp(sqrt(s2_B_imp));
disp('  ');
disp('The weigths of the new Benchmark Portfolio is: ')
disp(w_B);
disp('  ');

% Calculate the new MVP
A_new=r_imp'*(Sigma\e);
B_new=r_imp'*(Sigma\r_imp);
C_new=e'*(Sigma\e);
D_new=B_new.*C_new - A_new.^2;

r_min_new= A_new/C_new;
s2_min_new= 1/C_new;
w_min_new = (Sigma\e)/C_new;

disp('The return of the new MVP is: ')
disp(r_min_new);
disp('  ');
disp('The volatility of the new MVP is: ')
disp(sqrt(s2_min_new));
disp('  ');
disp('The weigths for the new MVP are: ')
disp(w_min_new);
disp('  ');

% Calculate the new efficient frontier

g_new= (B_new*(Sigma\e)-A_new*(Sigma\r_imp))/D_new;
h_new= (C_new*(Sigma\r_imp)-A_new*(Sigma\e))/D_new;

n=1400;
rE_new=zeros(n,1);
s2E_new=zeros(n,1);
wE_new=zeros(n,8);

for i = 1:1:n
    rE_new(i,1)= -0.04 + i*0.00025;
    wHlp = g_new + h_new*rE_new(i);
    wE_new(i,:) = wHlp;
    s2E_new(i,1)=wHlp'*Sigma*wHlp;
end

% Plot efficient frontier, with MVP and all assets of opportunity set for
% implied returns
name_str = 'Efficient frontier and MVP of opportunity set for implied returns';                    
figure('Name',name_str,'NumberTitle','off');  
x=plot(sqrt(diag(Sigma)),r_imp,'o',sqrt(s2_min_new),r_min_new,'o',sqrt(s2E_new),rE_new);
set(x(1), 'MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',6);
set(x(2), 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',6);
set(x(3), 'Color',[0.4,0.4,0.4], 'LineWidth',2);
ax=gca;
xXLabel = xlabel('Return per month');
xYLabel = ylabel('Volatility per month');
ax.XLimMode = 'manual';
ax.XLim = [0 0.2];
ax.YLimMode = 'manual';
ax.YLim = [-0.01 0.02];
hLegend = legend( ...
  'Assets of Opportunity Set' , ...
  'Minimum Variance Portfolio'      , ...
  'Efficient Frontier'      , ...
  'location', 'NorthWest' );
set( ax                       , ...
    'FontName'   , 'Helvetica' );
set([ xXLabel, xYLabel], ...
    'FontName'   , 'AvantGarde');
set(hLegend             , ...
    'FontSize'   , 8           );
set([xXLabel, xYLabel]  , ...
    'FontSize'   , 10          );
set(ax, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'XTick'       , 0:0.05:0.2, ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , -0.03:0.01:0.02, ...
  'LineWidth'   , 1         );
set(ax,'FontSize',12)
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 Task5_1.eps

%% Calculate new Tangency portfolio as well as the CAL and plot them

% Calculate weigths of new tangent portfolio
A_prime_new=e'*(Sigma\R_imp);
B_prime_new=(Sigma\R_imp); 
w_T_new=B_prime_new./A_prime_new; 
disp('The weigths for the Tangency Portfolio are: ')
disp(w_T_new);
disp('  ');

% Calculate return and volatility of new tangent portfolio
r_T_new=r_imp'*w_T_new;
s2_T_new=w_T_new'*Sigma*w_T_new;
disp('The return of the new Tangancy Portfolio is: ')
disp(r_T_new);
disp('  ');
disp('The volatility of the new Tangency Portfolio is: ')
disp(sqrt(s2_T_new));
disp('  ');

% Set up CAL
sharpe_ratio_new=(r_T_new-r_f)/sqrt(s2_T_new); % slope of CAL


s_CAL_new=(0:0.01:0.5)';
n=length(0:0.01:0.5);
r_CAL_pos_new=zeros(n,1);
r_CAL_neg_new=zeros(n,1);

for i= 1:n
    r_CAL_pos_new(i,1)= r_f + sharpe_ratio_new*s_CAL_new(i,1);
    r_CAL_neg_new(i,1)= r_f - sharpe_ratio_new*s_CAL_new(i,1);
end


 
name_str = 'Fully invested Tangency Portfolio coincides with Benchmark Portfolio';                    
figure('Name',name_str,'NumberTitle','off');  
x=plot(sqrt(diag(Sigma)),r_imp,'o',sqrt(s2_min_new),r_min_new,'o',sqrt(s2E_new),rE_new,...
       sqrt(s2_f),r_f,'o',sqrt(s2_T_new),r_T_new,'o', sqrt(s2_B_imp),r_B_new,'d', ...
       s_CAL_new, r_CAL_pos_new, s_CAL_new, r_CAL_neg_new );
set(x(1), 'MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',6);
set(x(2), 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',6);
set(x(3), 'Color',[0.4,0.4,0.4], 'LineWidth',2);
set(x(4), 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6);
set(x(5), 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',11);
set(x(6), 'MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6);
set(x(7), 'Color',[0.8,0.2,0], 'LineWidth',2);
set(x(8), 'Color',[0.8,0.2,0], 'LineWidth',2);
ax=gca;
xXLabel = xlabel('Return per month');
xYLabel = ylabel('Volatility per month');
ax.XLimMode = 'manual';
ax.XLim = [0 0.2];
ax.YLimMode = 'manual';
ax.YLim = [-0.01 0.02];
hLegend = legend( ...
  'Assets of Opportunity Set' , ...
  'Minimum Variance Portfolio'      , ...
  'Efficient Frontier'      , ...
  'Riskless Portfolio', ...
  'Tangency Portfolio', ...
  'Benchmark Portfolio' , ...
  'Capital Allocation Line', ...
  'location', 'NorthWest' );
set( ax                       , ...
    'FontName'   , 'Helvetica' );
set([ xXLabel, xYLabel], ...
    'FontName'   , 'AvantGarde');
set(hLegend             , ...
    'FontSize'   , 8           );
set([xXLabel, xYLabel]  , ...
    'FontSize'   , 10          );
set(ax, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'XTick'       , 0:0.05:0.2, ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , -0.03:0.01:0.02, ...
  'LineWidth'   , 1         );
set(ax,'FontSize',12)
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 Task5_2.eps




%%


alphas=[0; 0.04; 0; -0.07; 0; 0.03; 0; -0.05];
NN=8;
returns=xlsread('DataG02.xls',2,'C7:J66');
returns_riskless=xlsread('DataG02.xls',2,'N7:N66');
w_B=xlsread('DataG02.xls',2,'C3:J3')';
e=ones(NN,1);


returns_index=returns*w_B;
excess_returns=returns-returns_riskless*ones(1,NN);
%excess_returns=returns-returns_riskless*ones(1,NN)-ones(length(returns),1)*alpha';
excess_index = returns_index-returns_riskless;
X=[ones(length(returns),1) excess_returns];
[betas_est,se_b,mse]=lscov(excess_index,excess_returns);

Omega= (mse'*ones(1,NN)).*eye(NN);

w_A=(Omega\alphas)/(e'*(Omega\alphas));

alpha_a=w_A'*alphas;




