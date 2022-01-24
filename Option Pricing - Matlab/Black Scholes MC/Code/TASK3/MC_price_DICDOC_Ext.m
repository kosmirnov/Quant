% %Simulation of seven paths of the underlying asset depending on the
% %volatility sigma
% clear;
% clc;
% 
% %input data for problem 1 - data set group no. 6
% 
% S0=160;         %stock price
% X=150;          %strike price
% T=1.50;         %(T-t) - Time to maturity
% t=0;            %(T-t) - Time to maturity
% r=0.03;         %risk-free interest rate
% q=0.04;         %continous dividend yield
% sigma=0.3;      %volatility
% H=140;

% 
% N=30000;    

function[DOCall_MC_Ext,DICall_MC_Ext]=MC_price_DICDOC_Ext(S0,X,T,t,r,q,sigma,H,N,t_step)
seed=77;
rng(seed);

dt=(T-t)/t_step; %is equal to Time to maturity
time=t:dt:T; %steps for until Time to maturity
S=nan(N, t_step+1);
S(:,1)=S0;
U_n=randn(N,t_step);
for a=2:length(time)
    S(:,a)=S(:,a-1).*exp(((r-q)-0.5.*sigma.^2).*dt+...
        sigma.*sqrt(dt).*randn(N,1));
    
    
    ex_prob(:,a-1)=exp(-(2.*(S(:,a-1)-H).*(S(:,a)-H))./((sigma.^2).*...
        (S(:,a-1)).^2*dt));
    
    
    
end

check=zeros(N,1); %initializing a vector with zeroes to collect those stock
                  %paths which fullfill the different conditions for DIC
                  %and DOC
    
                 %idea the cell of the zero vector is initially zero if the 
                 %condition for DOC is met than we get a one. However we
                 %have also to check whether the exit probability
                 %condition is met. If so, the code change the one into a
                 %zero again. Zero for DOC payoffs and one for DIC payoff
for j=1:1:N
    
    check(j,1)=0;  
    i=1;         %start value of help variable 
    while S(j,i)>H && i<=t_step     %Condition for DOC     
    
        i=i+1;   %increasing the help variable by one
        
    end
       
    
    
    if i>=t_step                     %if the code reached the end we have a DOC 
        check(j,1)=1;  
       
    end
    
   k=1;
        while Norm_dist(U_n(j,k))> ex_prob(j,k) && k<=t_step-1
                
            k=k+1;
        end
                                        
        if k<t_step                                      %New exit condition, if met
            check(j,1)=0;                           %the code assumes that the stock price path hits the barrier
        end
  
    
        
end
   

for l=1:1:N                     %evaluation of the ones and zeros in the check vector
    
    if check(l,1)==0                        %if check is 0 than DIC is true
        payoff_DOC=0; 
        payoff_DIC=max(S(l,t_step+1)-X,0);
        
    elseif check(l,1)==1                    %if check is 1 than DOC is  true
        payoff_DOC=max(S(l,t_step+1)-X,0);
        payoff_DIC=0;
               
    end
    
    DOC_payoff(l,1)=payoff_DOC;            %collecting all payoffs
    DIC_payoff(l,1)=payoff_DIC;            %collecting all payoffs
      
end
    
  

%DOC and DIC price using Monte Carlo Simulation
DOCall_MC_Ext=exp(-r*(T-t))*mean(DOC_payoff);     %we discount the mean of all payoffs to calculated the DOC with MC Simulation
DICall_MC_Ext=exp(-r*(T-t))*mean(DIC_payoff);     %we discount the mean of all payoffs to calculated the DOC with MC Simulation





