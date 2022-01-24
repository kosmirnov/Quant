%% Assignment 2: Numerical Method in Finance
% TASKs 7.1 - 7.4.: Calculations and Plots for Implicit Scheme,
% Crank-Nicolson and Richardson Extrapolations for both schemes

%% Implicit Finite Difference Methods
clear;
clc;
close all;

Mx = 120;           %   number of grid points per time level 0-60 (not possible with matlab)
Nt = 100;           %   number of time levels

% Call the function
[S, TheoPut, u0_Implicit , ERROR_2D_Implicit, ERROR_3D_Implicit, ME_Implicit_2D ,ME_Implicit_3D]= Implicit(Mx,Nt);

% Price for S=200
true_price=TheoPut(21,1);
price_implicit=u0_Implicit(21,1);


% Plot of implicit scheme solution for increasing S
figure;
plot(S,u0_Implicit,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (implicit Scheme)');
    title('Implicit Scheme: European Put value for increasing S')
% saveas(gcf,'ImplicitPut.jpeg')

% Plot for closed-form solution for increasing S
figure;
plot(S,TheoPut,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (theoretical)');
    title('Theoretical European Put value for increasing S')
% saveas(gcf,'TheoEuroPut.jpeg')


% plot the errors of the implicit Scheme with fixed time steps (2D-Errors)
figure;
plot(S,ERROR_2D_Implicit,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
    title('Implicit Scheme: Stock price vs. Error')
% saveas(gcf,'2D_Implicit.jpeg')
% define vectors for plotting
T_Part=(1/100:1/100:1)';    
S_Part=S(1:48);             
% Plot the errors for different time steps and stock prices (3D-Errors)
figure;
Maxx = 0.4*Mx;
PART_IMPLICIT = ERROR_3D_Implicit(:,1:Maxx);
material metal;
colormap(jet(128));
surfc(S_Part,T_Part,PART_IMPLICIT,'Linestyle','none');
        xlabel('stock price');
        ylabel('time to maturity');
        zlabel('error');
        title('Implicit Scheme: Stock price vs. Time-to-maturity vs. Error ')
camlight('left'); camlight('right'); camlight('headlight');
% saveas(gcf,'3D_Implicit.jpeg')
%% 7.2. CRANK-NICOLSON FINITE DIFFERNECE
% Call the function
[S, TheoPut, u0_CN, ERROR_2D_CN, ERROR_3D_CN, ME_CN_2D, ME_CN_3D]= Crank_Nicolson(Mx,Nt);

% price at S=200
price_CN=u0_CN(21,1);

% Plot of CN prices vs. S
figure;
plot(S,u0_CN,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (Crank-Nicolson Scheme)');
    title('Crank Nicolson Scheme: European Put value for increasing S')
%     saveas(gcf,'u0_CN.jpeg')
    
% 2D-Plot of CN Errors vs. S
figure;
plot(S,ERROR_2D_CN,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
    title('Crank-Nicolson Scheme: Stock price vs. Error')
%     saveas(gcf,'2D_CN.jpeg')
    
% 3D-Plot of CN Errors vs. S
figure;
Maxx = 0.4*Mx;
PART_CN = ERROR_3D_CN(:,1:Maxx);
material metal;
colormap(jet(128));
surfc(S_Part,T_Part,PART_CN,'Linestyle','none');
        xlabel('stock price');
        ylabel('time to maturity');
        zlabel('error');
        title('Crank-Nicolson Scheme: Stock price vs. Time-to-maturity vs. Error ')
%     saveas(gcf,'3D_CN.jpeg')
camlight('left'); camlight('right'); camlight('headlight');

%% 7.3. RICHARDSON EXTRAPOLATION 
% Call the function for the Richardson Extrapolation for the Implicit
% and Crank-Nicolson Scheme
[u0_RE_Implicit , ERROR_2D_RE_Implicit, ERROR_3D_RE_Implicit,ME_Implicit_RE_2D, ME_Implicit_RE_3D]= RE_Implicit(Mx,Nt);
[u0_RE_CN,ERROR_2D_RE_CN,ERROR_3D_RE_CN,ME_RE_CN_2D, ME_CN_RE_3D]=RE_CN(Mx,Nt);

%prices at S=200
price_RE_Implicit=u0_RE_Implicit(21,1);
price_RE_CN=u0_RE_CN(21,1);

% prices at maturity for increasing S in both cases...
figure;
plot(S,u0_RE_Implicit,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (implicit Scheme with RE)');    
    title('Implicit Scheme with RE: European Put values for increasing S')
%     saveas(gcf,'u0_impicit_re.jpeg')

    figure;
plot(S,u0_RE_CN,'LineWidth',1.5);
    xlabel('stock price');
    ylabel('put value (Crank-Nicolson Scheme with RE)');    
    title('Crank-Nicolson Scheme with RE: European Put values for increasing S')
%     saveas(gcf,'u0_cn_re.jpeg')

% plot the errors of the implicit Scheme with fixed time steps (2D-Errors)
figure;
plot(S,ERROR_2D_Implicit,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
hold on;
plot(S,ERROR_2D_RE_Implicit,'g','LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
    title('Implicit Scheme vs. Implicit Scheme with RE: Error development for increasing S')
hold off;
legend('Implicit Scheme','Implicit Scheme with Richardson EP');
% saveas(gcf,'IMPvsRE.jpeg')

figure;
plot(S,ERROR_2D_CN,'r','LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
hold on;
plot(S,ERROR_2D_RE_CN,'g','LineWidth',1.5);
    xlabel('stock price');
    ylabel('error');
    title('Crank-Nicolson Scheme vs. Crank-Nicolson Scheme with RE: Error development for increasing S')
hold off;
legend('Crank-Nicolson Scheme','Crank-Nicolson Scheme with Richardson EP');
% saveas(gcf,'CNvsRE.jpeg')

% Plot the errors for different time steps and stock prices (3D-Errors)
figure;
Maxx = 0.4*Mx;
PART_RE_IMPLICIT = ERROR_3D_RE_Implicit(:,1:Maxx);
material metal;
colormap(jet(128));
surfc(S_Part,T_Part,PART_RE_IMPLICIT,'Linestyle','none');
        xlabel('stock price');
        ylabel('time to maturity');
        zlabel('error');
        title('Implicit Scheme with RE: Stock price vs. Time-to-maturity vs. Error ')
camlight('left'); camlight('right'); camlight('headlight');
% saveas(gcf,'3D_IMPRE.jpeg')


figure;
Maxx = 0.4*Mx;
PART_RE_CN = ERROR_3D_RE_CN(:,1:Maxx);
material metal;
colormap(jet(128));
surfc(S_Part,T_Part,PART_RE_CN,'Linestyle','none');
        xlabel('stock price');
        ylabel('time to maturity');
        zlabel('error');
        title('Crank-Nicolson Scheme with RE: Stock price vs. Time-to-maturity vs. Error ')
camlight('left'); camlight('right'); camlight('headlight');
% saveas(gcf,'3D_CNRE.jpeg')



