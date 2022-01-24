%% TASK 7.4: 
% Analyse the Maximum Errors vs. computational effort for the different 
% finite-difference schemes for Nt=1/72*Mx.^2;


clear;
clc;
close all;


Mx =12:12:1200;           %  number of grid points per time level 0-60 (not possible with matlab)
Nt=(1/72).*Mx.^2;         % defined by task 7.4. Computation might take some time!

% create input matrix 
ME_Implicit=zeros(numel(Mx),3);
ME_Implicit(:,1)=Mx.*Nt;

ME_Implicit_RE=zeros(numel(Mx),3);
ME_Implicit_RE(:,1)=Mx.*Nt;

ME_CN=zeros(numel(Mx),3);
ME_CN(:,1)=Mx.*Nt;

ME_CN_RE=zeros(numel(Mx),3);
ME_CN_RE(:,1)=Mx.*Nt;



   
% Call the function with a for-loop for the given Mx-size
for i=1:numel(Mx)
tic;
[~, ~, ~ , ~, ~, ME_Implicit(i,2)]= Implicit(Mx(i),Nt(i));
ME_Implicit(i,3)=toc;
end

for i=1:numel(Mx)
tic;
[~,~,~,ME_Implicit_RE(i,2),~]=RE_Implicit(Mx(i),Nt(i));
ME_Implicit_RE(i,3)=toc;
end

for i=1:numel(Mx)
tic;
[~, ~, ~ , ~, ~, ME_CN(i,2)]= Crank_Nicolson(Mx(i),Nt(i));
ME_CN(i,3)=toc;
end

for i=1:numel(Mx)
tic;
[~,~,~,ME_CN_RE(i,2),~]=RE_CN(Mx(i),Nt(i));
ME_CN_RE(i,3)=toc;
end

%% Plots
% Plot MxN vs. error
figure;
loglog(ME_Implicit(:,1),ME_Implicit(:,2),'r',ME_Implicit_RE(:,1),ME_Implicit_RE(:,2),'g',ME_CN(:,1),ME_CN(:,2),'b',ME_CN_RE(:,1),ME_CN_RE(:,2),'k','LineWidth',1.5);
    xlabel('MxN');
    ylabel('error');
    title('MxN vs. error (log-scale)') 

legend('Implicit Scheme','Implicit Scheme with Richardson EP','Crank Nicolson','Crank Nicolson with Richardson EP','Location','southwest');
% saveas(gcf,'74_error.jpeg')


%%
% Plot time vs. error
figure;
loglog(ME_Implicit(:,3),ME_Implicit(:,2),'r',ME_Implicit_RE(:,3),ME_Implicit_RE(:,2),'g',ME_CN(:,3),ME_CN(:,2),'b',ME_CN_RE(:,3),ME_CN_RE(:,2),'k','LineWidth',1.5);
    xlabel('time');
    ylabel('error');
    title('time vs. error (log-scale) ')

legend('Implicit Scheme','Implicit Scheme with Richardson EP','Crank Nicolson','Crank Nicolson with Richardson EP','Location','northeast');
% saveas(gcf,'74_time.jpeg')

%%
% plot MxN vs. time
figure;
plot(ME_Implicit(:,1),ME_Implicit(:,3),'r',ME_Implicit(:,1),ME_Implicit_RE(:,3),'g',ME_CN(:,1),ME_CN(:,3),'b',ME_CN_RE(:,1),ME_CN_RE(:,3),'k','LineWidth',1.5);
    xlabel('M*N');
    ylabel('time in sec');
    title('MxN vs. time')
legend('Implicit Scheme','Implicit Scheme with Richardson EP','Crank Nicolson','Crank Nicolson with Richardson EP','Location','northwest')
% saveas(gcf,'74_time2.jpeg')


