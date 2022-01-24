%% Problem 2.1: Characteristic Function for Stochastic Volatility
% technical implementation is decribed in the paper
% by Konstantin Smirnov

%   Calculation of f2 from Schöbel/Zhu [1999]
%   Note: Without correction of principal values
%   function [fig1,fig2]=cvol(sg,th,rh)


%%%% EXTENDED IN ORDER TO PLOT FOR RHO, SIGMA, AND THETA %%%%


function [fig1,fig2]=cvol(rh_vec,sg_vec,th_vec)








for count_rh=1:numel(rh_vec)
 rh=rh_vec(count_rh);
 
    for count_sg=1:numel(sg_vec)
    sg=sg_vec(count_sg);
    
        for count_th=1:numel(th_vec)
            th=th_vec(count_th);

ph = eps:0.001:5;
if ~isreal(ph)                   % Check of input matrix
    error('Input argument must be real.'); end;

if ~(ndims(ph)<=2) || (~(size(ph,1)==1) && ~(size(ph,2)==1))
   error('First input must be a onedimensional vector.'); end;

zzz = NaN(size(ph));   % Defines a matrix of the same size as ph.  
fff = NaN(size(ph));   % Defines a matrix of the same size as ph. 

T  = 20.0;       % parameter values
t  = 0.0;
r  = 0.0953;
kp = 4.0;        

S = 100;
vt = 0.0;

xt = log(S);
sg2 = sg*sg;

s1 = 0.5.*ph.^2.*(1-rh.^2) + 0.5.*1i.*ph.*(1 - 2.*kp.*rh./sg);
s2 = 1i.*ph.*kp.*th.*rh./sg;
s3 = 0.5.*1i.*ph.*rh./sg;

g1 = sqrt(2.*sg2.*s1 + kp.^2);
g2 = (kp - 2.*sg2.*s3)./g1;
g3 = kp.^2.*th - s2.*sg2;

sh = sinh(g1.*(T-t));
ch = cosh(g1.*(T-t));
h0 = kp.*th.*g1 - g2.*g3;
h1 = (kp.^2.*th.^2.*g1.^2 - g3.^2)./(2.*sg2.*g1.^3);
h2 = (h0.*g3)./(sg2.*g1.^3);
nm = sh + g2.*ch;                                    % numerator
dn = ch + g2.*sh;                                    % denominator

D  = (kp - (g1.*nm)./dn)./sg2;
B  = ((h0 + g3.*nm)./dn - kp.*th.*g1)./(sg2.*g1);
C1 = log(dn);

C2 = 0.5.*kp.*(T-t) + h1.*(sh./dn - g1.*(T-t)) + h2.*((ch-1)./dn); 
C  = -0.5.*C1 + C2;

z2 = 1i.*ph.*(r.*(T-t) + xt) - 0.5.*1i.*ph.*rh.*(vt.^2./sg + sg.*(T-t));
f2 = exp(z2);
z2 = z2 + 0.5.*D.*vt.^2 + B.*vt + C;
f2 = f2.*exp(0.5.*D.*vt.^2 + B.*vt + C);

zzz = z2;
fff = f2;

fig1=figure;
plot3(real(zzz),imag(zzz),ph,'LineWidth',1.5);      % complex plane of the result starts at 0 and it runs in this direction goes to infinity very quickly
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('phi');
grid on;
% saveas(fig1,sprintf('zvola_%g%g%g.png',rh,th,sg)); % will create FIG1, FIG2,...
title(sprintf('z plot: \\rho=%g, \\sigma=%g, \\theta=%g',rh,sg,th));

    
fig2=figure;
plot3(real(fff),imag(fff),ph,'r','LineWidth',1.5);
xlabel('Re(w)');
ylabel('Im(w)');
zlabel('phi');
grid on;
title(sprintf('w plot:  \\rho=%g, \\sigma=%g, \\theta=%g',rh,sg,th));
% saveas(fig2,sprintf('wvola_g%g%g%g.png',rh,th,sg)); % will create FIG1, FIG2,...

        end
    end
end
end
