%% TASK 2 CALCULATE BACKSPREAD WITH CALL WITH FD-EXPLICIT SCHEME:
clear;
clc;

% Call the function for given Mx and Nt step-sizes for adjusted Explicit-FD
% algorithm for a Backspread with Call. 
% For parameter settings check the function.

Smax = 1200;    %maximum price of the underlying (numeric)
TT = 1;      % Time to maturity
Mx=60;      % Set stock price steps
Nt=400;     % Set time steps

[S, u0_BSC, TheoBSC, Error2D_BSC, Error3D_BSC, ME_BSC_2D, ME_BSC_3D]=Explicit_EuroBSC(Smax,TT,Mx,Nt);

%values for S=200 and T-t=1
BSC_FD_200=u0_BSC(11,1);            % explicit scheme values 
BSC_Theo_200=TheoBSC(11,1);         % theoretical values
%% TASK 2 Plot 2D Errors: Stock price vs. error for Euro-BSC
figure;
plot(S,u0_BSC,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('BSC value (explicit scheme)');
  title('Explicit FD Backspread with Call (European) value with T=1.00 for increasing S')
% saveas(gcf,'EuroBSCPayoff.jpeg')

figure;
plot(S,TheoBSC,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('BSC value (theoretical)');
    title('Theoretical Backspread with Call (European) value with T=1.00 for increasing S')
% saveas(gcf,'TheoBSCPayoff.jpeg')

payoff_bsc = 2*(max(S-220,0))-max(S-160,0);         %payoff function of BSC for ploting

figure;
plot(S,payoff_bsc,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('BSC value');
    axis([0,350,-150,150]);
    title('Payoff of an Backspread with Call (European)')
% saveas(gcf,'BSCPayoff2.jpeg')

figure;
plot(S,Error2D_BSC,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
    title('2D Error for BSC: Stock price vs. Error')
% saveas(gcf,'2DBSC.jpeg');

%% Plot 3D Error:
% TASK 2 Plot 3D-Errors : Stock price vs. time vs. error for Euro-BSC
figureBSC=figure;
axes0 = axes('Parent',figureBSC);           % create axes to get the right view
hold(axes0,'on');               
Maxx = 0.4*Mx;                              % restrict to exercise price
Part = Error3D_BSC(2:Nt+1,3:Maxx);
colormap(jet(128));
surfc(Part,'Linestyle','none');
        xlabel('h*i (discrt. stock price)');
        ylabel('n*k (discrt. time)');
        zlabel('error');
       title('3D Error for BSC: Stock price and time-to-maturity vs. error (in discretizized steps)')
view(axes0,[32.5 25.2]);
grid(axes0,'on');
axis(axes0,'tight');
%         saveas(gcf,'3DBSC.jpeg');