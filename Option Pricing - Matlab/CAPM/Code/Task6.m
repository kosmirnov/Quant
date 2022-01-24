clear;
clc;

alphas=[0; 0.04; 0; -0.07; 0; 0.03; 0; -0.05];
NN=8;
returns=xlsread('DataG02.xls',2,'C7:J66');
returns_riskless=xlsread('DataG02.xls',2,'N7:N66');
w_B=xlsread('DataG02.xls',2,'C3:J3')';
e=ones(NN,1);

alphasvec=zeros(60,8);
alphasvec(:,2)=0.004;
alphasvec(:,4)=-0.007;
alphasvec(:,6)=0.003;
alphasvec(:,8)=-0.005;
%%  Regression
% returns_index=returns*w_B;

% excess_returns=returns-returns_riskless*ones(1,NN)+alphasvec;
% %excess_returns=returns-returns_riskless*ones(1,NN)-ones(length(returns),1)*alpha';
% excess_index = returns_index-returns_riskless;
% X=[ones(length(returns),1) excess_returns];
% [betas_est,se_b,mse]=lscov(excess_index,excess_returns);
% 
% Omega= (mse'*ones(1,NN)).*eye(NN);
% 
% w_A=(Omega\alphas)/(e'*(Omega\alphas));
% 
% alpha_a=w_A'*alphas;



%% Plot opportunity set
data=returns+alphasvec;

for i=1:NN
r(i,1)=mean(data(:,i));
end


s2=cov(data);


figure;
plot(sqrt(diag(s2)),r,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','m',...
    'MarkerSize',6);
hold on;



% 3. Auxiliary Constant A,B,C and D;

A = r'*(s2\e);
B = r'*(s2\r);
C = e'*(s2\e);
D = B.*C - A.^2;


% 4. Min. Variance Portfolio
rMin = A/C;
s2Min = 1/C;
wMin = (s2\e)/C;


plot(sqrt(diag(s2Min)),rMin,'o','MarkerEdgeColor','b',...
    'MarkerFaceColor','y',...
    'MarkerSize',6);
hold on;

% % 5. Efficient Set
%  g = (B*(s2\e) - A*(s2\r))/D;
%  h = (C*(s2\r) - A*(s2\e))/D;
%  
%  for ii = 1 : 1400
%      rE(ii) = -0.04 + ii.*0.00025;
%      wHlp = g + h*rE(ii);
%      wE(:,ii) = wHlp;
%      s2E(ii) = wHlp'*s2*wHlp;
%  end
 
