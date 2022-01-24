%% Explicit Scheme Function for Backspread with Call %%
function [S, u0,TheoBSC,Error2D_BSC, Error3D_BSC, ME_BSC_2D, ME_BSC_3D]=Explicit_EuroBSC(Smax,TT,Mx,Nt)
% Parameter Input

xR = Smax;      % righthand boundary
xL = 0;         % lefthand boundary for the starting point

E1 = 160;       % Exercise price of 1st Call
E2 = 220;       % Exercise price of 2nd Call
eta = 0.25;     % volatility
r = 0.04;       % riskfree rate
q = 0;          % continous dividend yield is set to 0, since in this case our UL doesn't pay dividends.
h = r - q;      % carry cost

% Discretization: Defining the Grid
u0 = zeros(Mx+1,1);   % Numerical values at time level n
u1 = zeros(Mx+1,1);   % Numerical values at time level n+1 since MatLabStarts with 1, but we need 0

% setup the step sizes
hh = (xR-xL)./Mx;
kk = TT./Nt;
rx = kk./hh.^2;

% value of derivative at maturity (alternative method)
S = (0:Mx)'.*hh;
u0 = 2*max(S' - E2,0) - max(S' - E1,0); %way more efficient! same as the loop


% d1, d2, d3 are time independent
aa = 0.5.*eta.^2.*(0:Mx)'.*(0:Mx)'.*hh.^2;
bb = h.*(0:Mx)'.*hh;
cc = -r;

d1 = (1/(1-cc.*kk)).*(aa.*rx - 0.5.*bb.*rx.*hh);
d2 = (1/(1-cc.*kk)).*(-2.*aa.*rx + 1);
d3 = (1/(1-cc.*kk)).*(aa.*rx + 0.5.*bb.*rx.*hh);

% main loop of the the explicit scheme
for nn = 1:Nt  % nn is counted at the advanced time level
    
    u1(1) = (d1(1) + d2(1)).*u0(1) + d3(1).*u0(2); 
                                                                            % Lefthand boundary via Neumann (for derivation, see paper)
    
    for i = 2:Mx                                                            % These are the inner points from 1 to Mx-1
        
        u1(i) = d1(i).*u0(i-1) + d2(i).*u0(i) + d3(i).*u0(i+1);
    end
    
    u1(Mx+1) = (d1(Mx+1) - d3(Mx+1)).*u0(Mx) + (2*d3(Mx+1) + d2(Mx+1)).*u0(Mx+1); % Righthand boundary via Neumann-Boundary condition (for derivation see paper)
    
    
    u0 = u1;                                                                % shift to the next level
    
    Error3D_BSC(nn+1,:)= u0 - (2*BSMC(S,E2,nn.*kk,0,h,r,eta) - BSMC(S,E1,nn.*kk,0,h,r,eta));                       % Calculate Error with respect to underlying and time 
end

% Calculate Error for today and plot the Error for different underlying S
TheoBSC= (2*BSMC(S,E2,nn.*kk,0,h,r,eta) - BSMC(S,E1,nn.*kk,0,h,r,eta));
Error2D_BSC  =    u0 - TheoBSC;
ME_BSC_2D=max(abs(Error2D_BSC));

max_error_row=max(abs(Error3D_BSC));%givey you max error of each column for each h step for increasing n steps                                      
ME_BSC_3D=max(abs(max_error_row'));    %hand out max error of this combination
end
    
    
        
        
        
        
        
        



















    
    
    
    
    
    
    
    
















