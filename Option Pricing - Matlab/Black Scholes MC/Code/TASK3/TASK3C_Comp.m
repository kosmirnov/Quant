%Comparison plot Exercise 3

S0=160;         %stock price - start value
X=150;          %strike price
T=1;            %(T-t) - Time to maturity
t=0;            %(T-t) - Time to maturity
r=0.03;         %risk-free interest rate
q=0.04;         %continous dividend yield
sigma=0.3;      %different volatiliy levels
H=140;          %barrier
seed=77;
rng(seed);
N=30000;        %number of stock paths

n_stop=100:100:1000;


row=1;
for n=n_stop
    
    
[DOCall_MC_n(row,1), DICall_MC_n(row,1)]=DOC_DIC(S0,N,t,T,r,H,n,q,sigma,X);

[DOC_Call_Moon(row,1), DIC_Call_Moon(row,1)]=DOC_DIC_Moon(S0,N,t,T,r,H,n,q,sigma,X);


Call_DIC(row,1)=DIC_call(S0,X,r,sigma,q,T,t,H);

Call_DOC(row,1)=DOC_call(S0,X,r,sigma,q,T,t,H);


row=row+1;

end

figure;
plot(n_stop, Call_DIC,'r', n_stop, Call_DOC,'r', n_stop, DOCall_MC_n,'b', n_stop, DICall_MC_n,'b',...
    n_stop,DOC_Call_Moon,'g',n_stop,DIC_Call_Moon,'g','LineWidth',1.5);
xlabel('steps between discrete time points');
ylabel('Call price_t');
legend('DIC-exact','DOC-exact', 'DOC-MC','DIC-MC','DOC-Moon','DIC-Moon','Location','east');
grid on;
% saveas(gcf,'plot3C_comp');