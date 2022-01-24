function Theta_3D=Theta_3D_Greeks(S,X,t,r,q,sigma)

S_Grid=0:1:S*2;
T=1/12:1/12:24/12;  
[S_Mat,T_Mat]=meshgrid (S_Grid,T); % Create Grid-Vector

[~,~,theta_put,~]=Greeks(S_Mat,X,T_Mat,t,r,q,sigma);


Theta_3D=surf(S_Grid,T,theta_put);
set(Theta_3D, 'LineStyle', 'none');
ylabel('Time To Maturity (years)');
xlabel('Stock Price ($)');
zlabel('Theta');
title('TASK 1C: 3D Plot for Theta');
colorbar('northoutside');
saveas(gcf,'3D_Theta.jpg')