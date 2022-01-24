clear;
clc;

%% TASK 3: the BBS method with Richardson extrapolation (BBSR)

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n=100;

%Price for the American put with BBSR method and n=100
BBSR=Binomial_BBSR(S,X,r,q,sig,T,n,-1,1);
% Price of the American put with the BBS and n=100
BBS=Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
%Difference in prices for the American puts
Diff=BBSR-BBS;

disp('The price of the American put with BBSR method and n=100 is:');
disp(BBSR);
disp('The price of an American put with the BBS method and n=100 is:');
disp(BBS);
disp('The difference is:');
disp(Diff);

n1=1000;
%Price for the American put with BBSR method and n=1000
BBSR2=Binomial_BBSR(S,X,r,q,sig,T,n1,-1,1);
% Price of the American put with the BBS and n=1000
BBS2=Binomial_JR_BBS(S,X,r,q,sig,T,n1,-1,1);
%Difference in prices for the American puts
Diff2=BBSR2-BBS2;

disp('The price of the American put with BBSR method and n=1000 is:');
disp(BBSR2);
disp('The price of an American put with the BBS method and n=1000 is:');
disp(BBS2);
disp('The difference is:');
disp(Diff2);

%% Plots

n_end=1000;
Put_Matrix=nan((n_end/2),2);

%Creation of the matrices for storing the values for the plot
% American case
for n=2:2:n_end;
    Put_BBS= Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
    Put_Matrix(n,1)=Put_BBS;
    Put_BBSR=Binomial_BBSR(S,X,r,q,sig,T,n,-1,1);
    Put_Matrix(n,2)=Put_BBSR;
end


figure;
plot3 = semilogx(2:2:n_end,Put_Matrix(2:2:n_end,1),2:2:n_end,Put_Matrix(2:2:n_end,2));
xlabel('number of steps');
ylabel('Put price');
h=legend('Put BBS', 'Put BBSR');
set(h, 'Interpreter', 'none')
title('American put prices with BBS and BBSR methods');
% saveas(gcf,'plot3a.jpeg')


%% Appendix: calculation of the error for the BBSR method

% The Binomial_JR function for the American put, with n=15000, gives back the value of
% 5.6899 (Broadie/Detemple (1996)). We use this value to compute the error of the calculation of the
% BBSR and of the BBS method when n is lower.
[~,true_value,~]=Binomial_JR(S,X,r,q,sig,T,15000,-1,1);

n_end3=1000;
check =(2:2:n_end);  
%Calculation for American put option
BBSR_error=zeros(n_end3,2);
for n=check
    BBSR_error(n,1) = Binomial_BBSR(S,X,r,q,sig,T,n,-1,1) - true_value;
    BBSR_error(n,2)  = Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1) - true_value;
end

BBSR_error( ~any(BBSR_error,2), : ) = []; %delete all zero rows
figure;
plot(check,BBSR_error(:,1), check,BBSR_error(:,2));
xlabel('number of steps');
ylabel('error');
title('Calculation Error');
legend('error BBSR','error BBS');
% saveas(gcf,'plot3c.jpeg')

figure;
plot(check,BBSR_error(:,1), check,BBSR_error(:,2));
xlabel('number of steps');
ylabel('error');
xlim([0,50]);
title('Calculation Error');
legend('error BBSR','error BBS','Location','southoutside','Orientation','horizontal');
% saveas(gcf,'plot3d.jpeg')


