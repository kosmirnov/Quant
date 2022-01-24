function vega_3D=Vega_3D_Greeks(S,X,t,r,q,sigma)

S_Grid=0:1:S*2;
T=1/12:1/12:24/12;  
[S_Mat,T_Mat]=meshgrid (S_Grid,T); % Create Grid-Vector

[~,~,~,vega_put]=Greeks(S_Mat,X,T_Mat,t,r,q,sigma);


vega_3D=surf(S_Mat,T_Mat, vega_put);
set(vega_3D, 'LineStyle', 'none');
ylabel('Time To Maturity (years)');
xlabel('Stock Price ($)');
zlabel('Vega');
title('TASK 1C: 3D Plot for Vega');
colorbar('northoutside');
saveas(gcf,'3D_Vega.jpg')