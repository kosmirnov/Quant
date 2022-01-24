clear;
clc;

% 1. Data of an Allocation 
data=xlsread('DataG02.xls',1,'B2:I61');

NN=8;
e=ones(NN,1);

for i=1:NN
r(i,1)=mean(data(:,i));
end



% for i=1:NN
% sg(i,1)=var(data(:,i));
% end
% 
% for k=1:NN
%     for i=1:NN;
%     korr(k,i)=corr(data(:,k),data(:,i));
%     end;
% end

% s2_test=sg*sg';
% s3=s2_test*korr;

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


plot(sqrt(diag(s2Min)),rMin,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','y',...
    'MarkerSize',6);
hold on;

% 5. Efficient Set
 g = (B*(s2\e) - A*(s2\r))/D;
 h = (C*(s2\r) - A*(s2\e))/D;
 
 for ii = 1 : 1400
     rE(ii) = -0.04 + ii.*0.00025;
     wHlp = g + h*rE(ii);
     wE(:,ii) = wHlp;
     s2E(ii) = wHlp'*s2*wHlp;
 end
 

 plot(sqrt(s2E),rE,'LineWidth',2);
 hold on;
    
%% Task 3
 
 % 1. Data of an Allocation 


rF=0.0019;

plot(0,rF,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','y',...
    'MarkerSize',6);
hold on;

R_big=r-rF;
H=R_big'*(s2\R_big);

R_T= H / (e'*inv(s2)*R_big)+rF;
sg_p= H / (e'*inv(s2)*R_big)^2;

plot(sqrt(sg_p),R_T,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','y',...
    'MarkerSize',6);
hold on;

% A = R_big'*(s2\e);
% B = R_big'*(s2\R_big);
% C = e'*(s2\e);
% D = B.*C - A.^2;
% 
%  g = (B*(s2\e) - A*(s2\R_big))/D;
%  h = (C*(s2\R_big) - A*(s2\e))/D;
%  
%  for ii = 1 : 1400
%      rE_big(ii) = -0.04 + ii.*0.00025;
%      wHlp = g + h*rE(ii);
%      wE(:,ii) = wHlp;
%      s2E_big(ii) = wHlp'*s2*wHlp;
%  end
% 
%  
%  plot(sqrt(s2E_big),rE_big,'LineWidth',2);
%  hold on;
% %% Task 4


 
 %% Task 4
 
 w_b=xlsread('DataG02.xls',2,'C5:J5')';
 r_b=R_big'*w_b+rF;
 sg_b=w_b'*s2*w_b;
 
 plot(sqrt(sg_b),r_b,'o','MarkerEdgeColor','b',...
    'MarkerFaceColor','b',...
    'MarkerSize',6);
hold on;

%% Task 5

R_b=0.0037;
beta=(s2*w_b)/(w_b'*s2*w_b);
R_big5=R_b*beta+rF;

%% Task6
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