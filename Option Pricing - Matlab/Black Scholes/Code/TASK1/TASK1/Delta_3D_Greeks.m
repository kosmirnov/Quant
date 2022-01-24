% 3D Graph for Delta

function Delta_3D=Delta_3D_Greeks(S,X,t,r,q,sigma)

S_Grid=0:1:S*2;
T=1/12:1/12:24/12;  
[S_Mat,T_Mat]=meshgrid (S_Grid,T); % Create Grid-Vector

[delta_put,~,~,~]=Greeks(S_Mat,X,T_Mat,t,r,q,sigma);


Delta_3D=surf(S_Grid,T,delta_put);
set(Delta_3D, 'LineStyle', 'none');
ylabel('Time To Maturity (years)');
xlabel('Stock Price ($)');
zlabel('Delta');
title('TASK 1C: 3D Plot for Delta');
colorbar('northoutside');
saveas(gcf,'3D_Delta.jpg')