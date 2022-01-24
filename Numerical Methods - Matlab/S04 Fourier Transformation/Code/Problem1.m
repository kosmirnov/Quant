%% Assignment #4: Option Valuation using Fourier Transform Methods %%
%% Problem 1: BSM model by Fourier Inversion %%
%% by Konstantin Smirnov / 3980253 %%

clear;
clc;
close all;
% input
K=210;
T = 0.75;
t= 0;
r = 0.03;
q = 0.05;
sg = 0.3;
S=(100:1:300)';
h= r-q;

% compute standard BSM European Call
c_standard = BSMC(S,K,T,t,h,r,sg);

%% FIT computations for varying S %%
c_fourier_5=zeros(length(S),1);
c_fourier_10=zeros(length(S),1);
c_fourier_25=zeros(length(S),1);
c_fourier_50=zeros(length(S),1);

for i=1:length(S);
 c_fourier_5(i)= BSM_FourierInv(S(i),K,T,t,r,q,sg,5);
 c_fourier_10(i)= BSM_FourierInv(S(i),K,T,t,r,q,sg,10);
 c_fourier_25(i)= BSM_FourierInv(S(i),K,T,t,r,q,sg,25);
 c_fourier_50(i)= BSM_FourierInv(S(i),K,T,t,r,q,sg,50);
end

% errors for S=[100,300]
eps_5=c_standard-c_fourier_5;
eps_10=c_standard-c_fourier_10;
eps_25=c_standard-c_fourier_25;
eps_50=c_standard-c_fourier_50;
% errors for S= 100, 200, 300 %
result_5=[eps_5(1,1);eps_5(101,1);eps_5(201,1)];
result_10=[eps_10(1,1);eps_10(101,1);eps_10(201,1)];
result_25=[eps_25(1,1);eps_25(101,1);eps_25(201,1)];
result_50=[eps_50(1,1);eps_50(101,1);eps_50(201,1)];

%% Plots of errors for varying S

plot1=figure;
plot(S,eps_5,'r','LineWidth',1.5);
xlabel('S');
ylabel('\epsilon');
title('\epsilon for \phi=5');
% saveas(gcf,'plot11.jpeg');


plot2=figure;
plot(S,eps_10,'r','LineWidth',1.5);
xlabel('S');
ylabel('\epsilon');
title('\epsilon for \phi=10');
% saveas(gcf,'plot12.jpeg');


plot3=figure;
plot(S,eps_25,'r','LineWidth',1.5);
xlabel('S');
ylabel('\epsilon');
title('\epsilon for \phi=25');
% saveas(gcf,'plot13.jpeg');

plot4=figure;
plot(S,eps_50,'r');
xlabel('S');
ylabel('\epsilon');
title('Difference between BSM and Forier Transform for \phi=50');
% saveas(gcf,'plot14.jpeg');


plot5=figure;
plot(S,eps_5,'LineWidth',1.5);
hold on;
plot(S,eps_10,'LineWidth',1.5);
hold on;
plot(S,eps_25,'LineWidth',1.5);
hold on;
plot(S,eps_50,'--');
xlabel('S');
ylabel('\epsilon');
legend( '\phi_{max} = 5',...
        '\phi_{max} = 10',...
        '\phi_{max} = 25',...
        '\phi_{max} = 50',...
        'Location','northwest');
title('Fourier Inversion:  BSM-Price Error for increasing \phi_{max}');
% saveas(gcf,'plot15.jpeg');


%% Evaluate the computation time for increasing S=1:1000 for both methods %%

S_time=1:1000;

% Time evaluation for standard BSMC %%

c_standard_time=zeros(length(S_time),1);
c_fourier_time_25=zeros(length(S_time),1);
c_fourier_time_50=zeros(length(S_time),1);

time_BSMC=zeros(length(S_time),1);
time_fourier_25=zeros(length(S_time),1);
time_fourier_50=zeros(length(S_time),1);

for c=1:length(S_time);
    tic;
    c_standard_time(c) = BSMC(200,K,T,t,h,r,sg);
    time=toc;
    if c==1
    time_BSMC(c)=time;
    else
    time_BSMC(c)=time_BSMC((c-1))+time;
    end
end


% Time evaluation for Fourier transform %%

for k=1:length(S_time);
    tic;
    c_fourier_time_25(k) = BSM_FourierInv(200,K,T,t,r,q,sg,25);
    time=toc;
    if k==1
    time_fourier_25(k)=time;
    else
    time_fourier_25(k)=time_fourier_25((k-1))+time;
    end
end

for k=1:length(S_time);
    tic;
    c_fourier_time_50(k) = BSM_FourierInv(200,K,T,t,r,q,sg,50);
    time=toc;
    if k==1
    time_fourier_50(k)=time;
    else
    time_fourier_50(k)=time_fourier_50((k-1))+time;
    end
end


BSMC_endtime=time_BSMC(end);
fourier_25_endtime=time_fourier_25(end);
fourier_50_endtime_50=time_fourier_50(end);
%% Time Plots %%
plottime=figure;
loglog(S_time,time_BSMC,'LineWidth',1.5);
hold on;
loglog(S_time,time_fourier_25,'r','LineWidth',1.5);
hold on;
loglog(S_time,time_fourier_50,'Color',[1,0.5,0],'LineWidth',1.5);
xlabel('Number of computations');
ylabel('computational time');
hleg=legend('standard BSMC',...
        'Fourier-Inverse with \phi_{max}= 25',...
        'Fourier-Inverse with \phi_{max}= 50',...
        'Location','northwest');
title('Fourier Inversion: Computational Time');
% saveas(gcf,'plot16.jpeg');