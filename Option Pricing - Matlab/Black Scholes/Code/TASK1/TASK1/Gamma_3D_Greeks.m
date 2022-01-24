function Gamma_3D=Gamma_3D_Greeks(S,X,t,r,q,sigma)

S_Grid=0:1:S*2;
T=1/12:1/12:24/12;  
[S_Mat,T_Mat]=meshgrid (S_Grid,T); % Create Grid-Vector

[~,gamma_put,~,~]=Greeks(S_Mat,X,T_Mat,t,r,q,sigma);


Gamma_3D=surf(S_Grid,T,gamma_put);
set(Gamma_3D, 'LineStyle', 'none');
ylabel('Time To Maturity');
xlabel('Stock Price');
zlabel('Gamma');
title('TASK 1C: 3D Plot for Gamma');
colorbar('southoutside');
saveas(gcf,'3D_Gamma.jpg')