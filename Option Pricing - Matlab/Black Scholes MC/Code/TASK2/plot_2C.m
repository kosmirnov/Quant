%% 3D-Plot for 2C 
function [plot_3D_t,plot_3D_T]=plot_2C(S_length,q1,q2,sigma1,sigma2,rho,T,t)                 
                     
[S1_L,S2_L]=meshgrid(S_length,S_length);                                  %% Create matricies via meshgrid   
Theo_3D_T=THEO_EEO(S1_L,S2_L,q1,q2,sigma1,sigma2,rho,T,t);

figure;
plot_3D_t=surf(S1_L,S2_L,Theo_3D_T);
xlabel('1.Stock price_t');
ylabel('2.Stock price_t');
zlabel('Price of EEO_T');
title('Development of European Exchange option at T');
colorbar;

Theo_3D_T=max(0,S1_L-S2_L);
figure;
plot_3D_t=surf(S1_L,S2_L,Theo_3D_t);
xlabel('Stock price1_t');
ylabel('Stock price2_t');
zlabel('Price of EEO_t');
title('Development of European Exchange option today');
colorbar;
