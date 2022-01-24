%% Richardson Extrapolation function for Crank-Nicolson Scheme

function [u0_RE,ERROR_2D_CN_RE,ERROR_3D_RE,ME_CN_RE, ME_3D]=RE_CN(Mx,Nt)
[~, TheoPut, u0, ~, ERROR_3D_CN,~,~]= Crank_Nicolson(Mx,Nt);                 % Call the function with N and M
[~, ~, u0_2N2M,~, ERROR_3D_CN_2N2M,~,~]= Crank_Nicolson(2*Mx,2*Nt);          % Call the function with 4*N and 2*M for RE

u0_2N2M=u0_2N2M(1:2:end);
ERROR_3D_CN_2N2M=ERROR_3D_CN_2N2M(2:2:end,1:2:end);                         % Cut the 3D-Errors


u0_RE=(1/3)*(4*u0_2N2M-u0);                                                 % RE-Equation given to Task 7.3. for the implicit scheme
ERROR_3D_RE = (1/3)*(4*ERROR_3D_CN_2N2M-ERROR_3D_CN);                       % 3D-Error for RE

ERROR_2D_CN_RE=u0_RE-TheoPut;                                               % 2D-Error of RE;

ME_CN_RE=max(abs(ERROR_2D_CN_RE)); 

ME_3D= max(max(abs(ERROR_3D_RE)));



