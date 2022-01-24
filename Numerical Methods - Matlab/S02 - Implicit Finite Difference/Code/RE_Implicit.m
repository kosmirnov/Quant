%% Richardson Extrapolation function for Implicit Scheme

function [u0_RE,ERROR_2D_Implicit_RE,ERROR_3D_RE,ME_Implicit_RE, ME_3D]=RE_Implicit(Mx,Nt)
[~, TheoPut, u0, ~, ERROR_3D_Implicit,~,~]= Implicit(Mx,Nt);                 % Call the function with N and M
[~, ~, u0_4N2M,~, ERROR_3D_Implicit_4N2M,~,~]= Implicit(2*Mx,4*Nt);          % Call the function with 4*N and 2*M for RE

% Compute extrapolated implicit prices
u0_4N2M=u0_4N2M(1:2:end);                                                   % cut the vector to fit
u0_RE=(1/3)*(4*u0_4N2M-u0);                                                 % RE-Equation given by Task 7.2.
ERROR_2D_Implicit_RE=u0_RE-TheoPut;                                         % calculate errors                                  


% compute 3D errors..
ERROR_3D_Implicit_4N2M=ERROR_3D_Implicit_4N2M(4:4:end,1:2:end);             % Cut the 3D-Errors to fit                      % RE-Equation given by Task 7.3. for the implicit scheme
ERROR_3D_RE = (1/3)*(4*ERROR_3D_Implicit_4N2M-ERROR_3D_Implicit);           % 3D-Error for RE


%search for the maximum 2D errors 
ME_Implicit_RE=max(abs(ERROR_2D_Implicit_RE)); 
%search for the maximum 3D errors 
ME_3D= max(max(abs(ERROR_3D_RE)));


