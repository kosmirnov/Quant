function [DOC_Call_Moon, DIC_Call_Moon]=DOC_DIC_Moon(S0,N,t,T,r,H,n,q,sigma,X)

dt=(T-t)/n;     %length of one subinterval delta_t to delta_t+1
time=t:dt:T;    %steps until Time to maturity

S=nan(N, n+1);  %size of stock price matrix
S(:,1)=S0;      %first row of stock price matrix
U_n=randn(N,n); %Vector with different z for standard normal distrubution   
                %to calculate the exit condition (Moon)
                
                
%Calculation of stock price paths and exit probilitiy for the exit
%condition (Moon)

                
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
    while S(j,i)>H && i<=n     %Condition for DOC     
    
        i=i+1;   %increasing the help variable by one
        
    end
       
    
    
    if i>=n                     %if the code reached the end we have a DOC 
        check(j,1)=1;  
       
    end
        
    k=1;
        while Norm_dist(U_n(j,k))> ex_prob(j,k) && k<=n-1
                
            k=k+1;
        end
                                        
        if k<n                                      %New exit condition, if met
            check(j,1)=0;                           %the code assumes that the stock price path hits the barrier
        end
    
        
end
   

for l=1:1:N                     %evaluation of the ones and zeros in the check vector
    
    if check(l,1)==0                        %if check is 0 than DIC is true
        payoff_DOC=0; 
        payoff_DIC=max(S(l,n+1)-X,0);
        
    elseif check(l,1)==1                    %if check is 1 than DOC is  true
        payoff_DOC=max(S(l,n+1)-X,0);
        payoff_DIC=0;
               
    end
    
    DOC_payoff(l,1)=payoff_DOC;            %collecting all payoffs
    DIC_payoff(l,1)=payoff_DIC;            %collecting all payoffs
      
end

DOC_Call_Moon=exp(-r*(T-t))*mean(DOC_payoff);
DIC_Call_Moon=exp(-r*(T-t))*mean(DIC_payoff);
end