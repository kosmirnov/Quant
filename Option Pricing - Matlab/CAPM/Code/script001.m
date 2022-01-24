clear;
clc;

% 1. Data of an Allocation 

NN = 4;
r = [0.08 0.09 0.12 0.25]'; % ERR
e = ones(NN,1);
sg = [0.25 0.3 0.5 0.8]';
Korr = [1 0.05 -0.04 0.11; 0.05 1 0.07 0.2;
        -0.04 0.07 1 -0.15; 0.11 0.2 -0.15 1];

% 2. Additional data    
sHlp = sg*sg';    
s2 = Korr.*sHlp;
v = inv(s2);
eig(s2);
det(s2);

figure;
plot(sqrt(diag(s2)),r,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','m',...
    'MarkerSize',6);
axis([0 1 -0.03 0.35]);
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

figure;
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