
function ME=Max_Error(Mx,Nt)
%% Input
S0 = 200;       %actual price of the underlying
Smax = 1200;    %maximum price of the underlying (numeric)
xx = S0;
xR = Smax;      %righthand boundary
xL = 0;         %lefthand boundary for the starting point
TT = 1.00;      % Time to maturity
K = 200;        % Exercise price
eta = 0.25;     % volatility
r = 0.04;       % riskfree rate
q = 0.06;       % continous dividend yield
h = r - q;      % carry cost

%% Discretization: Defining the Grid
u0 = zeros(Mx+1,1);   %Numerical values at time level n
u1 = zeros(Mx+1,1);   %Numerical values at time level n+1 since MatLabStarts with 1, but we need 0
% setup the step sizes
hh = (xR-xL)./Mx;
kk = TT./Nt;
rx = kk./hh.^2;
%value of derivative at maturity (alternative method)
S = (0:Mx)'.*hh;
u0 = max(K - S',0); %way more efficient! same as the loop
% d1, d2, d3 are time independent
aa = 0.5.*eta.^2.*(0:Mx)'.*(0:Mx)'.*hh.^2;
bb = h.*(0:Mx)'.*hh;
cc = -r;

d1 = (1/(1-cc.*kk)).*(aa.*rx - 0.5.*bb.*rx.*hh);
d2 = (1/(1-cc.*kk)).*(-2.*aa.*rx + 1);
d3 = (1/(1-cc.*kk)).*(aa.*rx + 0.5.*bb.*rx.*hh);

% main loop of the the explicit scheme
for nn = 1:Nt  % nn is counted at the advanced time level
    
    u1(1) = K.*exp(-r.*nn.*kk);                                             % Lefthand boundary (Dirichlet boundary)
    
    for i = 2:Mx                                                            % These are the inner points from 1 to Mx-1
        
        u1(i) = d1(i).*u0(i-1) + d2(i).*u0(i) + d3(i).*u0(i+1);
    end
    
    u1(Mx+1) = (d1(Mx+1) + d3(Mx+1)).*u0(Mx) + d2(Mx+1).*u0(Mx+1);          % Righthand boundary via Neumann-Boundary condition
    
    
    u0 = u1;                                                                % shift to the next level
    
    Error3D(nn+1,:)= u0 - BSMP(S,K,nn.*kk,0,h,r,eta);                       % Calculate Error with respect to underlying and time 
end

max_error_row=max(abs(Error3D));%givey you max error of each column for each h step for increasing n steps                                      
ME=max(abs(max_error_row'));    %hand out max error of this combination
end

    
    
        
        
        
        
        
        



















    
    
    
    
    
    
    
    
















