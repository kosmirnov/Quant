function Delta_MJ=MJ_Delta(S,X,T,r_input,sigma_input,lambda,gamma,delta,k,lambda_trans,n,n_stop)

MJ_Vec_Delta=zeros(n_stop,1);
% 
% while n<=n_stop;                      
%     r=r_input-lambda*k+(n*gamma/T);
%     Var_Jump=sigma_input^2+(n*delta^2)/T;
%     sigma=sqrt(Var_Jump);
%     Put_MJ_Delta=(((lambda_trans*T)^n)/factorial(n))*exp(-(lambda_trans*T))*BSM_Delta_Jump(S,X,r,sigma,T);
%     n=n+1;
%     MJ_Vec_Delta(n,1)=Put_MJ_Delta;
% end    
% Delta_MJ=sum(MJ_Vec_Delta);



while n<=n_stop;                      
    r=r_input-lambda*k+(n*gamma/T);
    Var_Jump=sigma_input^2+(n*delta^2)/T;
    sigma=sqrt(Var_Jump);
    Put_MJ_Delta=(((lambda_trans*T)^n)/factorial(n))*exp(-(lambda_trans*T))*BSM_Delta_Jump(S,X,r,sigma,T);
    n=n+1;
    MJ_Vec_Delta(n,1)=Put_MJ_Delta;
end    
Delta_MJ=sum(MJ_Vec_Delta);