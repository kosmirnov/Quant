% Function to plot 2D Graph for BSM&Upper and Lower Bounds dependend on T2t

function Time_2D=BSM_Graph_Time(S,X,t,r,q,sigma)

T=1/12:1/12:24/12;                %Time in Months
S_Length=1;

[UB_Put,LB_Put]=Bounds(S,X,T,t,r,q,S_Length);
BSM_Put=BSM_Put_Task1(S,X,T,t,r,q,sigma);

figure;
Time_2D=plot(T,LB_Put,T,UB_Put,T,BSM_Put);
h=legend('Lower Bound','Upper Bound','BSM Price','Location', 'East');
set(h, 'Interpreter', 'none')
ylabel('Put Price($)');
xlabel('Time (years)');
title('TASK 1B: Options Price and Arbitrary Bounds depending on T');

Time_2D(1).LineWidth=1.5;
Time_2D(2).LineWidth=3;
Time_2D(2).LineWidth=1.5;


