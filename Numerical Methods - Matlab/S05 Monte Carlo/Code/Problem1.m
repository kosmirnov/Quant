%% Assignment #5: Monte Carlo Approach %%
%% Problem 1: Improving strong convergence with the Milstein scheme %%
%% by Konstantin Smirnov / 3980253 %%

% INPUT %
clear;
clc;
close all;

seed= 7777; % seed
S0 = 100;
T = 0.5;
t= 0;
r = 0.0953;
eta = 0.25;
[stream1, ~] = RandStream.create('mrg32k3a','NumStreams',2,'Seed',seed);



%% Problem 1a) Comparison of discretization paths
nn11 = 1000; % overall number of increments in the (approx.) cont.  path      % discretization factor was set to mm=20 in this case
nn12= 50;    % the step-size M is computed inside the scripts
err01 = randn(stream1,nn11,1); % discretized version of Brownian Motion

[S_Euler,S_Euler_Last,~]=euler(S0,t,T,r,eta,nn11,nn12,err01);
[S_Milstein,S_Milstein_Last,~]=milstein(S0,t,T,r,eta,nn11,nn12,err01);
[S,S_Last]=cont(S0,T,t,r,eta,nn11,err01);


Splot=S(1:20:nn11+1);
time=(1:length(Splot))./100;

figure;
plot(time,Splot,'g',time,S_Euler,'--',time,S_Milstein,'-o','LineWidth',1.5);
legend('cont. path',...
        'Euler scheme',...
        'Milstein scheme','Location','northeast');
xlabel('T-t');    
ylabel('S');
xlim([0 0.5]);
title('Euler Scheme vs. Milstein Scheme - Continuous Path Convergence (full scale)');
% saveas(gcf,'plot11.jpeg');


figure;
plot(time,Splot,'g',time,S_Euler,'--',time,S_Milstein,'-o','LineWidth',1.5);
legend('cont. path',...
        'Euler scheme',...
        'Milstein scheme','Location','northeast');
xlabel('T-t');    
ylabel('S');
title('Euler Scheme vs. Milstein Scheme - Continuous Path Convergence (zoomed in)');
xlim([0.40 0.5]);
% saveas(gcf,'plot11z.jpeg');

%% Problem 1b: Accuracy and Efficiency of Milstein and Euler Scheme %%
% 1b) Euler Scheme vs Milstein Scheme: Discretization Error & Time Efficiency

nn21=10000;

for i=1:14;
    ti(i)=2^i;
end

err21 = randn(stream1,nn21,1); % discretized version of Brownian Motion

% Transformation with constant diffusion coefficient (analytic solution)
SPaths  =  zeros(1,nn21); 
SPaths(:,1)  =  100; 
dt  =  T/nn21; 
nudt  =  (r-0.5*eta^2)*dt; 
sidt  =  eta*sqrt(dt) ; 

for j=1:nn21
SPaths(1,j+1)=SPaths(1,j)*exp(nudt+sidt*err21(j)); 
end
accuracy=zeros(length(ti),5);
time_efficiency=zeros(length(ti),2);
accuracy(:,1)=ti;

for ii=1:length(ti)
accuracy(ii,2)=SPaths(end);
end

% Loop for Euler scheme 
for ii=1:length(ti)
[~,accuracy(ii,3),time_efficiency(ii,1)]=euler(S0,t,T,r,eta,nn21,ti(ii),err21);
end

% Loop for Milstein scheme
for ii=1:length(ti)
[~,accuracy(ii,4),time_efficiency(ii,2)]=milstein(S0,t,T,r,eta,nn21,ti(ii),err21);
end

% Compute disct. errors
errors_euler=accuracy(:,2)-accuracy(:,3);
errors_milstein=accuracy(:,2)-accuracy(:,4);
%% plots of 1b)
figure;
semilogx(accuracy(:,1),accuracy(:,2),'k--',...
     accuracy(:,1),accuracy(:,3),...
     accuracy(:,1),accuracy(:,4),'LineWidth',1.5);
 legend('theoretical value',...
        'Euler scheme',...
        'Milstein scheme','Location','northeast');
xlabel('number of time increments n (log-scale)');    
ylabel('S');
xlim([10 ti(end)]);
title('Euler Scheme vs. Milstein Scheme - Cont. Path Convergence');
% saveas(gcf,'plot12.jpeg');

figure;
semilogx(accuracy(:,1),accuracy(:,5),'k--',...
     accuracy(:,1),errors_euler,...
     accuracy(:,1),errors_milstein,...
     'LineWidth',1.5);
 legend('True value',...
        'Euler scheme',...
        'Milstein scheme','Location','southeast');
xlabel('number of time increments n (log-scale)');    
ylabel('error');
xlim([10 ti(end)]);
title('Euler Scheme vs. Milstein Scheme - Discretisation Error');
% saveas(gcf,'plot13.jpeg');


figure;
plot([0 0.0005],[0 0],'k--',time_efficiency(:,1),errors_euler,...
     'LineWidth',1.5);
 hold on;
plot(time_efficiency(:,2),errors_milstein,.....
     'LineWidth',1.5);
 legend('True value',...
        'Euler Scheme',...
        'Milstein scheme','Location','southeast');
xlabel('computational time (in sec and log-scale)');    
ylabel('error');
gca.XAxis.TickLabelFormat = '%,.1f';
title('Euler scheme vs. Milstein scheme: Computational Effort');
% saveas(gcf,'plot14.jpeg');

