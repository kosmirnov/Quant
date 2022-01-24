%% Assignment #4: Option Valuation using Fourier Transform Methods %%
%% Problem 4: Call prices with stochastic volatility %%
%% by Konstantin Smirnov / 3980253 %%

clear;
clc;
close all;

vt=(-0.6:0.1:0.6)';
rh=(-1:0.5:1)';
S=100;
K=120;
T=3;
t=0;
r=0.0953;
kp=0.5;
sg=0.1;
phmax=25;
q=0;


ImpliedVola_00=zeros(length(vt),length(rh));
ImpliedVola_02=zeros(length(vt),length(rh));

for i=1:length(rh)
    for k=1:length(vt)
    ImpliedVola_00(k,i)=SZ_FourierInv(S,K,T,t,r,kp,sg,0,rh(i),vt(k),phmax,1);
    end
end

for i=1:length(rh)
    for k=1:length(vt)
    ImpliedVola_02(k,i)=SZ_FourierInv(S,K,T,t,r,kp,sg,0.2,rh(i),vt(k),phmax,1);
    end
end
%%
ImpliedVolaPlot1=figure;
plot(vt,ImpliedVola_00(:,1),...
     vt,ImpliedVola_00(:,2),...
     vt,ImpliedVola_00(:,3),...      
     vt,ImpliedVola_00(:,4),...      
     vt,ImpliedVola_00(:,5)      );
 xlabel('\bf{Volatility v}');
 ylabel('\bf{Call Price}');
 h=legend('\rho=-1.0',...
        '\rho=-0.5',...
        '\rho=0',...
        '\rho=0.5',...
        '\rho=1.0','Location','southeast');
 set(h,'FontSize',12); 
 title('\bf{Implied Volatility with \theta = 0}');
 
%  saveas(gcf,'plot41.jpeg');

ImpliedVolaPlot2=figure;
plot(vt,ImpliedVola_02(:,1),...
     vt,ImpliedVola_02(:,2),...
     vt,ImpliedVola_02(:,3),...      
     vt,ImpliedVola_02(:,4),...      
     vt,ImpliedVola_02(:,5)      );
 xlabel('\bf{Volatility v}');
 ylabel('\bf{Call Price}');
 h=legend('\rho=-1.0',...
        '\rho=-0.5',...
        '\rho=0',...
        '\rho=0.5',...
        '\rho=1.0','Location','southeast');
 set(h,'FontSize',12); 
 title('\bf{Implied Volatility with \theta = 0.2}');
%   saveas(gcf,'plot42.jpeg');

