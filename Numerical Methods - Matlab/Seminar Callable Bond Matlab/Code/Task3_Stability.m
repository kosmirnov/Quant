%% TASK 3: Stability
clear;
clc;
% In this subtask we call the function stability to analyse the stability of
% the explicit scheme algorithm of the European Put by checking the 
% eigenvalues and norm of our A - Matrix.

% As input we just have to define the step-size parameters... To increase
% perfomance one can increase step-sizes.

% NOTE THAT FOR THE STEP-SIZE ONLY POSITIVE INTEGERS/WHOLE NUMBERS  ARE
% VALID as step-size input.

i_start=2;  % start of stock-price steps
i_step=1;   % step-size of stock-price variable
i_end=200;  % end of stock-price steps
n_start=1;  % start of time-step
n_step=1;   % step-size of time variable
n_end=2500; % end of time steps

% this calculation may take some time, depending on the size and the lenght
% of your step-parameters

stability=Explicit_Stability(i_start,i_step,i_end,n_start,n_step,n_end);

% As output we get a Matrix "Stability" where the colum 1 and 2 gives you
% the combinations of M and N, the 3 column gives you the M*N for the
% logarithmic plot. The 4. column gives you the biggest absolute error of
% each combintions. For details check Paper and function.
%% TASK 3 Plot for different MxN combinations

% To fill the areas of stability and non-stability one has to define the
% polygon chains first
stable_area = [0,0;stability(:,1),stability(:,2);0,2500];
nonstable_area = [0,0;stability(:,1),stability(:,2);200,0];
% This can be done with the patch command.
figure;
patch(stable_area(:,1),stable_area(:,2),[0 1 0],'LineStyle','none'); % green area
hold on;
patch(nonstable_area(:,1),nonstable_area(:,2),[1 0 0],'LineStyle',...% red area
    'none');
hold on;
plot(stability(:,1),stability(:,2),'k','LineWidth',1.5);
    xlabel('M');
    ylabel('N');
    title('Critical MxN combinations: Feasible Frontier')
text(150,500,'unstable area')
text(50,1500,'stable area')
% saveas(gcf,'MNplot.jpeg');

%% TASK 3 Plog logarithmic errors:
% these figures plot for the maximum error at T-t=1
figure;
loglog(stability(:,3),stability(:,4),'LineWidth',1.5);
    xlabel('log(M*N)');
    ylabel('log(max. Error)');
    title('Errors on the FSF for MxN combinations at T-t=1 (log on x and y)')
% saveas(gcf,'loglogerror_2D.jpeg');

% semilog figure
figure;
semilogx(stability(:,3),stability(:,4),'LineWidth',1.5);
    xlabel('log(M*N)');
    ylabel('abs. max. Error)');
  title('Errors on the FSF for MxN combinations at T-t=1 (log on x)')
% saveas(gcf,'semilogerror_2D.jpeg');
%%
% these figures are for the maximum errors of the WHOLE GRID
figure;
loglog(stability(:,3),stability(:,5),'k','LineWidth',1.5);
    xlabel('log(M*N)');
    ylabel('log(max. Error)');
    title('Errors on the FSF for MxN combinations of the whole grid (log on x and y)')
% saveas(gcf,'loglogerror_3D.jpeg');

% semilog figure
figure;
semilogx(stability(:,3),stability(:,5),'k','LineWidth',1.5);
    xlabel('log(M*N)');
    ylabel('abs. max. Error)');
  title('Errors on the FSF for MxN combinations of the whole grid (log on x)')
% saveas(gcf,'semilogerror_3D.jpeg');



