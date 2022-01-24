% Function to plot 2D Graph for BSM&Upper and Lower Bounds dependend on Stock

function Stock_2D=BSM_Graph_Stock(S,X,r,q,sigma,T,t)

S_Grid=0:1:S*2; % X-Axis string
S_Length=S_Grid;

[UB_Put,LB_Put]=Bounds(S_Grid,X,T,t,r,q,S_Length);
BSM_Put=BSM_Put_Task1(S_Grid,X,T,t,r,q,sigma);

figure;
Stock_2D=plot(S_Grid,LB_Put,S_Grid,UB_Put,S_Grid,BSM_Put);
h=legend('Lower Bound','Upper Bound','BSM Price','Location', 'SouthEast');
set(h, 'Interpreter', 'none')
ylabel('Put Price($)');
xlabel('Stock Price($)');
title('TASK 1B: Put-Prices and Arbitrary Bounds depending on S');
%Linie Dicker machen legende verschiebenx(1).LineWidth=3;
Stock_2D(1).LineWidth=1.5;
Stock_2D(2).LineWidth=3;
Stock_2D(2).LineWidth=1.5;



