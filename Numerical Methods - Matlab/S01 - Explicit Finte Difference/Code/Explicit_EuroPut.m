%% Explicit Sce Function for European Put %%
% function [S, u0,TheoPut,Error2D, Error3D, ME_Put_2D, ME_Put_3D]=Explicit_EuroPut(Smax,TT,Mx,Nt)
% Parameter Settings
clear;
clc;

Smax=100;
TT=5;
Mx=20;
Nt=4000;
xR = Smax;      %righthand boundary
xL = 0;         %lefthand boundary for the starting point
% K = 200;        % Exercise price
eta = 0.2;     % volatility
% r = 0.04;       % riskfree rate
% q = 0.06;       % continous dividend yield
% h = r - q;      % carry cost

% 1. Discretization: Defining the Grid
u0 = zeros(Mx+1,1);   %Numerical values at time level n
u1 = zeros(Mx+1,1);   %Numerical values at time level n+1 since MatLabStarts with 1, but we need 0

% setup the step sizes
hh = (xR-xL)./Mx;                       % how large is each size?
kk = TT./Nt;
rx = kk./hh.^2;                         % This is our discount factor

% value of derivative at maturity (alternative method)
S = (0:Mx)'.*hh;
% u0 = max(K - S',0); %way more efficient! same as the loop

% 2. Difference Approximation
% d1, d2, d3 are time independent
aa = 0.5.*eta.^2.*(0:Mx)'.*(0:Mx)'.*hh.^2;
% bb = h.*(0:Mx)'.*hh;
cc = -(0:Mx)'.*hh;
i=(0:Mx)';
d1 = (1./(1+i.*hh.*kk)).*(aa.*rx);
d2 = (1./(1+i.*hh.*kk)).*(-2.*aa.*rx + 1);
% d3 = (1/(1-cc.*kk)).*(aa.*rx);

% main loop of the the explicit scheme
for nn = 1:Nt  % nn is counted at the advanced time level
    
    u1(1) = K.*exp(-r.*nn.*kk);                                             % Lefthand boundary (Dirichlet boundary)
    
    for i = 2:Mx                                                            % These are the inner points from 1 to Mx-1
        
        u1(i) = d1(i).*u0(i-1) + d2(i).*u0(i) + d3(i).*u0(i+1);
    end
    
    u1(Mx+1) = (d1(Mx+1) + d3(Mx+1)).*u0(Mx) + d2(Mx+1).*u0(Mx+1);          % Righthand boundary via Neumann-Boundary condition
    
    
    u0 = u1;                                                                % shift to the next level
    
    Error3D(nn+1,:)= u0 - BSMP(S,K,nn.*kk,0,h,r,eta);                       % Calculate Error with respect to underlying and time. 
                                                                            % Here we use an own BSMP function to calculate the theoretical value 
end

% Calculate errors in 2D
TheoPut=BSMP(S,K,nn.*kk,0,h,r,eta); 
Error2D  =    u0 - TheoPut;                               % Calculate the error compared to the theoretical value of the BSMP
ME_Put_2D=max(abs(Error2D));   % Here we use an own BSMP function to calculate the theoretical value 

% Calculat errors in 3D
max_error_row=max(abs(Error3D));       %outputs the max error of each column for each h step for increasing n steps                                      
ME_Put_3D=max(abs(max_error_row'));    %output the max error of this combination to get scalar




    
    
        
        
        
        
        
        



















    
    
    
    
    
    
    
    
















