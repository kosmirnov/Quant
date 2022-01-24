clear;
clc;

%% TASK 2: Binomial Black-Scholes method (BBS)

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n=100;

% Price for the American put with BBS method
BBS=Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
% Price of the American put with the standard binomial approach
[~,American,~]=Binomial_JR(S,X,r,q,sig,T,n,-1,1);
%Difference in prices for the American puts
Diff=BBS-American;

disp('The price of the American put with BBS method and n=100 is:');
disp(BBS);
disp('The price of an American put with the standard binomial method and n=100 is:');
disp(American);
disp('The difference is:');
disp(Diff);

% Same computation, but with n=1000;
n1=1000;
% Price for the American put with BBS method
BBS1=Binomial_JR_BBS(S,X,r,q,sig,T,n1,-1,1);
% Price of the American put with the standard binomial approach
[~,American1,~]=Binomial_JR(S,X,r,q,sig,T,n1,-1,1);
%Difference in prices for the American puts
Diff1=BBS1-American1;

disp('The price of the American put with BBS method and n=1000 is:');
disp(BBS1);
disp('The price of an American put with the standard binomial method and n=1000 is:');
disp(American1);
disp('The difference is:');
disp(Diff1);

%% Plots
n_end=1000;
Put_Mat=nan(n_end,2);

%Creation of the matrices for storing the values for the plot
for n=1:1:n_end;
    [~,Put_American_bin,~]   = Binomial_JR(S,X,r,q,sig,T,n,-1,1);
    Put_Mat(n,1)=Put_American_bin;
    Put_American_BBS   = Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
    Put_Mat(n,2)=Put_American_BBS;
end



% Plot for the comparison between the Binomial American put price and the BBS
% American put price
figure;
plot2C = semilogx(1:1:n_end,Put_Mat(:,1),1:1:n_end,Put_Mat(:,2));
xlabel('number of steps');
ylabel('Put price');
h=legend('Put Binomial (JR)', 'Put Binomial (BBS)');
set(h, 'Interpreter', 'none')
title('Put price depending on N');
% saveas(gcf,'plot21.jpeg');

% Zoom figure for the American and European put depending on n
figure;
semilogx(1:1:n_end,Put_Mat(:,1),1:1:n_end,Put_Mat(:,2));
xlabel('number of steps');
xlim([100,1000]);
ylabel('Put price');
h=legend('Put Binomial (JR)', 'Put Binomial (BBS)');
set(h, 'Interpreter', 'none')
title('Put price depending on N');
% saveas(gcf,'plot23.jpeg');

% Plot for the difference between the Binomial American put price and the BBS
% American put price
Diff_Mat=abs(Put_Mat(:,1)-Put_Mat(:,2));

figure;
semilogx(1:1:n_end,Diff_Mat);
xlabel('number of steps');
ylabel('Difference in prices');
h=legend('Difference in put prices');
set(h, 'Interpreter', 'none')
title('Difference in Put prices depending on N');
% saveas(gcf,'plot24.jpeg');
%% Early exercise premium calculation
n_end=1000;
Put_EA=nan(n_end,2);
Put_EA_N=nan(n_end,3);

%Creation of the matrices for storing the values for the plots
%Loop for the calculation of the early exercise premium for the put price
%calculated with the BBS method
for n=1:1:n_end;
    Put_EA(n,1)  = Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1); %American (ind=1)
    Put_EA(n,2)= Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,0); %European (ind=0)
end
%Early exercise premium
Mat_EA=Put_EA(:,1)-Put_EA(:,2);

%Loop for the calculation of the early exercise premium for the put price
%calculated with the Binomial method
for n=1:1:n_end;
    [~,Put_EA_N(n,1),~]  = Binomial_JR(S,X,r,q,sig,T,n,-1,1); %American (ind=1)
    [~,Put_EA_N(n,2),~]  = Binomial_JR(S,X,r,q,sig,T,n,-1,0); %European (ind=0)
   
end
%Early exercise premium
Mat_EA_N=Put_EA_N(:,1)-Put_EA_N(:,2);


%Plot for both the early exercise premia
figure;
semilogx(1:1:n_end,Mat_EA,1:1:n_end,Mat_EA_N);
xlabel('number of steps');
ylabel('Premia');
h=legend('Early exercise premium (BBS)', 'Early exercise premium (Binomial JR)');
set(h, 'Interpreter', 'none')
title('Early exercise premia for BBS and Binomial');
% saveas(gcf,'plot25.jpeg');


%Price of the put with the BSM method
Put_BSM=BSMP(S,X,r,q,sig,0,T);
Put_EA_N(:,3)=Put_BSM;
%Early exercise premium for the American BBS and the BSM
Mat_EA_1=Put_EA(:,1)-Put_EA_N(:,3);
%Early exercise premium for the American Binomial and the BSM
Mat_EA_2=Put_EA_N(:,1)-Put_EA_N(:,3);

%Plot for both the early exercise premia
figure;
semilogx(1:1:n_end,Mat_EA_1,1:1:n_end,Mat_EA_2);
xlabel('number of steps');
ylabel('Premia');
h=legend('Early exercise premium (BBS)', 'Early exercise premium (Binomial JR)');
set(h, 'Interpreter', 'none')
title('Early exercise premia calculated with the BSM');
% saveas(gcf,'plot27.jpeg');


%% Appendix: calculation of the error for the BBS and the Binomial method

% The Binomial_JR function for the American put, with n=15000, gives back the value of
% 5.6899 (Broadie/Detemple (1996)). We use this value to compute the error of the calculation of the
% Binomial and of the BBS method when n is lower.
[~,true_value,~]=Binomial_JR(S,X,r,q,sig,T,15000,-1,1);

%%
n_end3=1000;
BBS_error=nan(n_end3,1);
for n=1:1:n_end3
    BBS_error(n,1) = Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1) - true_value;
end


Bin_error=nan(n_end3,1);
for n=1:1:n_end3
    [~,American,~]=Binomial_JR(S,X,r,q,sig,T,n,-1,1);
    Bin_error(n,1) = American - true_value;
end


figure;
plot(1:1:n_end3,Bin_error,1:1:n_end3,BBS_error);
xlabel('number of steps');
ylabel('error');
title('Calculation Error');
legend('error binomial','error BBS','Location','southoutside','Orientation','horizontal');
% saveas(gcf,'plot29.jpeg');
