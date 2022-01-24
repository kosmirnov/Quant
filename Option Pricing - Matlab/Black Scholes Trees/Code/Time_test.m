% Task 2 and 3 -> time efficiency
clear;
clc;

%% Plots for computational time for American put Binomial vs. BBS 

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;

n_end=1000;
n_end_time=1:1:n_end;
BBS_time=nan(n_end,4) ;
for n=n_end_time
    tic;
    BBS_time(n,1) = Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
    BBS_time(n,2)=toc;
end

figure;
plot(n_end_time,BBS_time(:,2))
hold on

clear;

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n_end=1000;
n_end_time=1:1:n_end;
BBS_time=nan(n_end,4) ;


%we set up a simple JR function with only one output to be consistent with
%the other functions in the timing comparison
for n=n_end_time
    tic;
    BBS_time(n,3) = Binomial_JR_time(S,X,r,q,sig,T,n,-1,1);
    BBS_time(n,4)=toc;
end

plot(n_end_time,BBS_time(:,4))
hold off
xlabel('number of steps');
ylabel('time (seconds)');
title('Computational time for increasing n');
legend('time BBS','time binomial');
% saveas(gcf,'plot2time.jpeg')


%% plots for computational time BBS vs. BBSR

clear;
clc;

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n_end=1000;
check =(2:2:n_end);        %% for plotting

BBSR_time=nan(n_end,6) ;
for n=check
    tic;
    BBSR_time(n,1) = Binomial_JR_BBS(S,X,r,q,sig,T,n,-1,1);
    BBSR_time(n,2)=toc;
end
BBSR_time( ~any(BBSR_time,2), : ) = [];  % delete all zero rows
figure;
plot(check,BBSR_time(:,2))
hold on

clear;
clc;

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n_end=1000;
check =(2:2:n_end); 
for n=check
    tic;
    BBSR_time(n,3) = Binomial_BBSR(S,X,r,q,sig,T,n,-1,1);
    BBSR_time(n,4)=toc;
end
BBSR_time( ~any(BBSR_time,2), : ) = [];  % delete all zero rows
plot(check,BBSR_time(:,4))

clear;
clc;

S=45;
X=40;
T=1.50;
r=0.02;
q=0.06;
sig=0.35;
n_end=1000;
check =(2:2:n_end); 

for n=check
    tic;
    BBSR_time(n,5) = Binomial_JR_time(S,X,r,q,sig,T,n,-1,1);
    BBSR_time(n,6)=toc;
end


BBSR_time( ~any(BBSR_time,2), : ) = [];  % delete all zero rows

plot(check,BBSR_time(:,6));
hold off
xlabel('number of steps');
ylabel('time (seconds)');
title('Computational time for increasing n');
legend('time BBS','time BBSR','time binomial');
% saveas(gcf,'plot3e.jpeg')


