%% %% Create Diagonal Matrices for different step sizes NxM

function [d1,d2,d3] =d_calc(Mx,Nt)

% Data Input
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

xx = S0;
xR = Smax;      %righthand boundary
xL = 0;         %lefthand boundary for the starting point

TT = 1.00;      % Time to maturity
K = 200;        % Exercise price
eta = 0.25;     % volatility
r = 0.04;       % riskfree rate
q = 0.06;       % continous dividend yield
h = r - q;      % carry cost

% setup the step sizes
hh = (xR-xL)./Mx;
kk = TT./Nt;
rx = kk./hh.^2;

%value of derivative at maturity (alternative method)
S = (0:Mx)'.*hh;

% d1, d2, d3 are time independent
aa = 0.5.*eta.^2.*(0:Mx)'.*(0:Mx)'.*hh.^2;
bb = h.*(0:Mx)'.*hh;
cc = -r;

d1 = (1/(1-cc.*kk)).*(aa.*rx - 0.5.*bb.*rx.*hh);
d2 = (1/(1-cc.*kk)).*(-2.*aa.*rx + 1);
d3 = (1/(1-cc.*kk)).*(aa.*rx + 0.5.*bb.*rx.*hh);

end

    
    
    