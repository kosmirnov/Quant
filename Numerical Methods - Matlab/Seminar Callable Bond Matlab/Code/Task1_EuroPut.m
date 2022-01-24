%% MAIN - FUNCTION FOR THE EUROPEAN PUT %%
%% TASK 1 CALCULATE EUROPEAN PUT VALUE WITH THE FD-EXPLICIT SCHEME

clc;
clear;

Smax = 1200;    %maximum price of the underlying (numeric)
TT = 1;      % Time to maturity
Mx=60;      % Set stock price steps
Nt=400;     % Set time steps

% Call the function for Mx and Nt steps to get the stock price for
% plotting, calculate BSM values at maturity for different stock prices u0, 
% errors for today in 2D and 3D-Errors dependend of time steps and 
% stock price for the given parameters.
% For parameter settings check the function.


[S, u0_EuroPut, TheoPut, Error2D_EuroPut, Error3D_EuroPut, ME_Put_2D, ME_Put_3D]=Explicit_EuroPut(Smax,TT,Mx,Nt);        

Put_FD_200=u0_EuroPut(11,1);        % explicit scheme values at S=200 and T-t=1
Put_Theo_200=TheoPut(11,1);         % theoretical values Put values at 200 (closed-form) S=200 and T-t=1

% Compare_Mat=[S,u0_EuroPut,TheoPut];     % to compare the output matrix of the explicit scheme (first column) and theoretical values (2nd column)
                                               


%% TASK 1 Plot 2D Errors: Stock price vs. error for Euro-Put
figure;
plot(S,u0_EuroPut,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (explicit scheme)');
    title('Explicit FD European put value with T=1.00 and increasing S')
% saveas(gcf,'EuroPut.jpeg')

figure;
plot(S,TheoPut,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (theoretical)');
    title('Theoretical European put value with T=1.00 and increasing S')
% saveas(gcf,'TheoEuroPut.jpeg')
% plot payoff
K=200;
payoff=max((K-S),0);
figure;
plot(S,payoff,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value');
    title('Payoff function of an European put')
% saveas(gcf,'PayoffPut.jpeg')

%plot 2D-Error
figure;
plot(S,Error2D_EuroPut,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
    title('2D Error: Stock price vs. Error')
% saveas(gcf,'2DEuroPut.jpeg')


%% TASK 1 Plot 3D-Errors : Stock price vs. time vs. error for EuroPut
% Plot the errors for different time steps and stock prices around the
% exercise price since here the error is the biggest. 

Maxx = 0.4.*Mx;   %restrict to exercise price
Part = Error3D_EuroPut(2:Nt+1,1:Maxx);
figurePut=figure;
axes1 = axes('Parent',figurePut);           % create axes to get the right view
hold(axes1,'on');
colormap(jet(128));
surfc(Part,'Linestyle','none');                 %plot with area of error
        xlabel('h*i (discrt. stock price)');
        ylabel('n*k (discrt. time)');
        zlabel('error');
        title('3D Error: Stock price vs. Time-to-maturity vs. Error ')
view(axes1,[56.5 13.2]);
grid(axes1,'on');
axis(axes1,'tight');
% saveas(gcf,'3DEuroPut.jpeg');
