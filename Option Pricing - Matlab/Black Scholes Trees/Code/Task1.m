clear;
clc;

%% TASK 1.A: stock price evolution (data group 7)

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n=100;

stock_CRR=S_CRR(S,T,sig,n);
stock_JR=S_JR(S,T,r,q,sig,n);

%% TASK 1.B: : European Put Option Calculation with the binomial tree and with the BSM method 

n=100;

[Put_JR_Tree, Put_JR, Put_BSM]= Binomial_JR(S,X,r,q,sig,T,n,-1,0);

disp('The price of a put of options, with JR and the binomial tree approach for n=100, is:');
disp(Put_JR)
disp('the price of the BSM put is:');
disp(Put_BSM)

%% TASK 1.C: Illustration for different Plots

%Repetition of the calculation for n=1,2,3,...,1000
n_end= 1000;
[~, Put_JR1, Put_BSM]= Binomial_JR(S,X,r,q,sig,T,n_end,-1,0);

disp('The price of a put of options, with JR and the binomial tree approach for n=1000, is:');
disp(Put_JR1);
%The price of the put with the binomial tree calculation is nearer to the BSM one when n increases.

% Plots
Put_Mat_EA=nan(n_end,2);

%Creation of the matrices for storing the values for the plot
for n=1:1:n_end;
    [~,Put_binomial, ~]   = Binomial_JR(S,X,r,q,sig,T,n,-1,0);
    Put_Mat_EA(n,1)=Put_binomial;
    Put_Mat_EA(n,2)=Put_BSM;
end


figure(1);
plot1C = semilogx(1:1:n_end,Put_Mat_EA(:,1),1:1:n_end,Put_Mat_EA(:,2));
xlabel('number of steps');
ylabel('Put price');
h=legend('Put Binomial (JR)', 'Put BSM');
set(h, 'Interpreter', 'none')
title('TASK 1C: Put price depending on N');
plot1C(1).LineWidth=1.5;
plot1C(2).LineWidth=0.5;
% saveas(gcf,'plot1c1.jpeg');

%Zoom figure
figure(2);
plot2C = semilogx(1:1:n_end,Put_Mat_EA(:,1),1:1:n_end,Put_Mat_EA(:,2));
xlabel('number of steps');
ylabel('Put price');
xlim([10,1000]);
h=legend('Put Binomial (JR)', 'Put BSM');
set(h, 'Interpreter', 'none')
title('TASK 1C: Put price depending on N');
plot2C(1).LineWidth=1.5;
plot2C(2).LineWidth=0.5;
% saveas(gcf,'plot1c2.jpeg');

%% TASK 1.D: American Put calculation

%Price of American put with n=100
n=100;
[Put_JR_TreeAmerican,Put_JR_American,~]= Binomial_JR(S,X,r,q,sig,T,n,-1,1);
%1 as input indicator for American option
%Price of American put with n=1000
n1=1000;
[~,Put_JR_American1,~]= Binomial_JR(S,X,r,q,sig,T,n1,-1,1);

%Early exercise premium for n=100 with Binomial method
EEP=Put_JR_American-Put_JR;
%Early exercise premium for n=1000 with Binomial method
EEP1=Put_JR_American1-Put_JR1;

% Early exercise premium for n=100 subtracting BSM put price
EEP2=Put_JR_American - BSMP(S,X,r,q,sig,0,T);
% Early exercise premium for n=1000 subtracting BSM put price
EEP3=Put_JR_American1 - BSMP(S,X,r,q,sig,0,T);


% plots for American options 
n_end1=1000;


Put_Mat_EA=nan(n_end1,3);
%Creation of the matrices for storing the values for the plot
for n=1:1:n_end1;
    [~,European_put, ~]   = Binomial_JR(S,X,r,q,sig,T,n,-1,0);
    [~,American_put, ~]   = Binomial_JR(S,X,r,q,sig,T,n,-1,1);
    Put_Mat_EA(n,1)=European_put;
    Put_Mat_EA(n,2)=Put_BSM;
    Put_Mat_EA(n,3)=American_put;
end



%% Plot for the American put depending on n
figure;
plot1D = semilogx(1:1:n_end1,Put_Mat_EA(:,3));
xlabel('number of steps');
ylabel('Put price');
title('TASK 1D: American Put price depending on n');
% saveas(gcf,'plot1d1.jpeg');

% Plot for the European and the American put depending on n
figure;
plot2D = semilogx(1:1:n_end1,Put_Mat_EA(:,1),1:1:n_end1,Put_Mat_EA(:,2),1:1:n_end1,Put_Mat_EA(:,3));
xlabel('number of steps');
ylabel('Put price');
h=legend('Put Binomial European(JR)', 'Put BSM', 'Put Binomial American(JR)');
set(h, 'Interpreter', 'none')
title('TASK 1D: American and European put price depending on N');
plot2D(1).LineWidth=1.5;
plot2D(2).LineWidth=0.5;
% saveas(gcf,'plot1d2.jpeg');

% Zoom figure for the American and European put depending on n
figure;
semilogx(1:1:n_end1,Put_Mat_EA(:,1),'g');
hold on
semilogx(1:1:n_end1,Put_Mat_EA(:,2),'r');
semilogx(1:1:n_end1,Put_Mat_EA(:,3),'b');
xlabel('number of steps');
ylabel('Put price');
xlim([150,1000]);
h=legend('Put Binomial European(JR)', 'Put BSM', 'Put Binomial American(JR)');
set(h, 'Interpreter', 'none')
title('TASK 1D: American and European put price depending on N');
hold off
% saveas(gcf,'plot1d3.jpeg');


% Zoom figure for the American and European put depending on n, to see the
% differences in values
figure;
semilogx(1:1:n_end1,Put_Mat_EA(:,1),'g');
hold on
semilogx(1:1:n_end1,Put_Mat_EA(:,2),'r');
semilogx(1:1:n_end1,Put_Mat_EA(:,3),'b');
xlabel('number of steps');
ylabel('Put price');
xlim([340,370]);
ylim([5.68,5.7]);
h=legend('Put Binomial European(JR)', 'Put BSM', 'Put Binomial American(JR)');
set(h, 'Interpreter', 'none')
title('TASK 1D: American and European put price depending on N');
hold off
% saveas(gcf,'plot1d4.jpeg');





%% early excercise premium dependent on n (Binomial and BSM)

n_end2= 1000;
European=nan(n_end2,1);
American=nan(n_end2,1);

for n=1:1:n_end2;
    
    [~,European(n,1),~]=Binomial_JR(S,X,r,q,sig,T,n,-1,0);
    [~,American(n,1),~]=Binomial_JR(S,X,r,q,sig,T,n,-1,1);
  
end


% Vector of early exercise prices
Put_Mat_P=American-European;

BSMP_EEP=BSMP(S,X,r,q,sig,0,T);
Put_Mat_BSM=American - BSMP_EEP;

% this graph represents the EEP vs. binomial
figure;
semilogx(1:1:n_end2,Put_Mat_P);
xlabel('number of steps');
ylabel('Early exercise premium');
title('TASK 1D: Early exercise premium (binomial) depending on n');
% saveas(gcf,'plot1d5.jpeg');


% this graph represents the EEP vs. BSM
figure;
semilogx(1:1:n_end2,Put_Mat_BSM);
xlabel('number of steps');
ylabel('Early exercise premium');
title('TASK 1D: Early exercise premium (BSM) depending on n');
%zoomed in version to compare it to binomial
figure;
semilogx(1:1:n_end2,Put_Mat_BSM);
xlim([950,1000]);
xlabel('number of steps');
ylabel('Early exercise premium');
title('TASK 1D: Early exercise premium (BSM) depending on n');
% saveas(gcf,'plot1d6.jpeg');
