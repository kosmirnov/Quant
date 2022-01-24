function Put_MJ= MJ_Put(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans,n,n_stop)
MJ_Vec=zeros(n_stop,1);
while n<=n_stop;                      
    r=r_input-lambda*k+(n*gamma/T);
    Var_Jump=sigma_input^2+(n*delta^2)/T;
    sigma=sqrt(Var_Jump);
    Put_MJ_Calc=(((lambda_trans*T)^n)/factorial(n))*exp(-(lambda_trans*T))*BSM_Put_Jump(S,X,r,sigma,T);
    n=n+1;
    MJ_Vec(n,1)=Put_MJ_Calc;
end    
Put_MJ=sum(MJ_Vec);                      