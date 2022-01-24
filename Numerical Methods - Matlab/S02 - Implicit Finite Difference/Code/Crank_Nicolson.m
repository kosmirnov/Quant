%% Function for  European put with Implicit Scheme
function [S, TheoPut, u0, ERROR_2D_CN, ERROR_3D_CN, ME_CN, Max_3D_Error]= Crank_Nicolson(Mx,Nt)

% BS Parameters
Smax = 1200; % maximum price of the underlying
TT = 1.00; %time to mat
E = 200; % strike of the put
eta = 0.25; % volatility of the underlying
r = 0.04; % riskless interest rate
q = 0.06; % dividend yield
h = r - q; % carry costs

% definition of variables
u1 = zeros(Mx+1,1);

ERROR_3D_CN = zeros(Nt,Mx+1);

% defining the grid
xR = Smax;
xL = 0;
hh= (xR - xL)./Mx; % step size in space direction
kk = TT./Nt;
rx = kk./(2*hh^2);      %Crank-Nicolson Adjustment

% initial values 
S = (0:Mx)'.*hh;
u0 = max(E - (0:Mx)'.*hh, 0);
%u0 = max(E -S.*hh, 0);
% Theoretical Put Price
TheoPut=BSMP(S,E,TT,0,h,r,eta);

% Time-independent Coefficients
aa = 0.5 .* eta^2.*(0:Mx)'.*(0:Mx)' .* hh.*hh; 
bb = h.* (0:Mx)' .* hh; % Not r.*, do not forget the dividend yield
cc = -r;

d1 = -aa.*rx + 0.5.*bb.*rx.*hh;
d2 = 2.*aa.*rx - cc.*(kk/2) + 1;
d3 = -aa.*rx - 0.5.*bb.*rx.*hh;

% Correction of d1 due to the right boundary at Mx
%idea: put everything which is not time-dependent before our main loop
d1(Mx+1) = d1(Mx+1) + d3(Mx+1);

% LR-decomposition of the System Au=d into AU = LRu = Ly = d
% step 1: A = LR 
af(2) = d2(2);
rr(2) = d3(2)./af(2);
for i = 3:Mx
af(i) = d2(i) - d1(i).*rr(i-1);
rr(i) = d3(i)./af(i);
end;
af(Mx+1) = d2(Mx+1) - d1(Mx+1).*rr(Mx);

% main loop of the implicit scheme, where nn is counted on the advanced
% time level
for nn = 1:Nt
  % left boundary for index i=0  "Dirichlet" 
    u1(1) = E.*exp(-r.*nn.*kk); 
    
    % definition of the vector d4 (RHS of equation system)
    d4 = zeros(Mx+1,1);
    d4(2:Mx) = -d1(2:Mx).*u0(1:Mx-1)+(2-d2(2:Mx)).*u0(2:Mx)-d3(2:Mx).*u0(3:Mx+1);
    d4(Mx+1)= -d1(Mx+1).*u0(Mx)+(2-d2(Mx+1)).*u0(Mx+1);
    d4(2) = d4(2)-d1(2).*u1(1);
    
    % step 2: Ly = d
    yy(2) = d4(2)./af(2);
    for i = 3:Mx+1
        yy(i) = (d4(i) - d1(i).*yy(i-1))./af(i);
    end;
    
    % step 3: Ru = y
    u1(Mx+1) = yy(Mx+1);
    for i = Mx:-1:2
        u1(i) = yy(i) - u1(i+1).*rr(i);
    end;
    
    % timeshift
    u0 = u1;
    ERROR_3D_CN(nn,:) = u0 - BSMP(S,E,nn.*kk,0,h,r,eta);
end;

% calculate 3D error
ERROR_2D_CN = u0 - TheoPut;

% Search for the maximum error of this MxN combination
ME_CN=max(abs(ERROR_2D_CN)); 

% Search for the biggest 3D Error
Max_3D_Error=max(max(abs(ERROR_3D_CN)));




