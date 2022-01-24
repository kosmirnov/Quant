% BSM- 3D Plot Function
function BSM_3D=BSM_Put_Meshgrid(S,X,r,q,sigma,t)

S_Grid=0:1:S*2;
T=1/12:1/12:2;  

[S_Mat,T_Mat]=meshgrid (S_Grid,T); % Create Grid-Vector

Put_BSM = BSM_Put_Task1(S_Mat,X,T_Mat,t,r,q,sigma);


BSM_3D=surf(S_Grid,T,Put_BSM); 
ylabel('Time To Maturity');
xlabel('Stock Price');
zlabel('Put Price');
title('TASK 1C: 3D Plot for Put-Price');
colorbar('southoutside');
saveas(gcf,'3D_Value.jpg')