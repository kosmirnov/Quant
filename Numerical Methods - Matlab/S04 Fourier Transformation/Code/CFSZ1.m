function [zzz,fff] = CFSZ1(S,T,t,r,kp,sg,th,rh,vt,ph,heston)
%
%   Calculation of f1 from Schöbel/Zhu [1999]
%   Note: Without correction of principal values

if ~isreal(ph)                   % Check of input matrix
    error('Input argument must be real.'); end;

if ~(ndims(ph)<=2) || (~(size(ph,1)==1) && ~(size(ph,2)==1))
   error('First input must be a onedimensional vector.'); end;

xt = log(S);
sg2 = sg*sg;

s1 = -0.5.*(1+1i.*ph).^2.*(1-rh.^2) + 0.5.*(1+1i.*ph).*(1 - 2.*kp.*rh./sg);
s2 = (1+1i.*ph).*kp.*th.*rh./sg;
s3 = 0.5.*(1+1i.*ph).*rh./sg;

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

if heston==0
    C1 = log(dn);
elseif heston==1
        k=zeros(length(ph),1);
    for j=2:length(ph)
        % When dn crosses the real negative axis from above, k needs to be increased by 1
        if real(dn(j)) < 0 && imag(dn(j-1))>0 && imag(dn(j))<0 
            k(j)=k(j-1)+1;
            % When dn crosses the real negative axis from below, k needs to be reduced by 1
        elseif real(dn(j)) < 0 && imag(dn(j-1))<0 && imag(dn(j))>0
            k(j)=k(j-1)-1;
        else % in all other cases, k is still the same (same level for complex logarithm)
            k(j)=k(j-1);
        end
    end
    % Calculate complex logarithm of dn avoiding jumps
    C1 =log(abs(dn)) +1i.*(atan2(imag(dn),real(dn))+2.*pi.*k) ;
else
    error('Wrong type assigned')
end

C2 = 0.5.*kp.*(T-t) + h1.*(sh./dn - g1.*(T-t)) + h2.*((ch-1)./dn); 
C  = -0.5.*C1 + C2;

z1 = 1i.*ph.*(r.*(T-t) + xt) - 0.5.*(1+1i.*ph).*rh.*(vt.^2./sg + sg.*(T-t));
f1 = exp(z1);
z1 = z1 + 0.5.*D.*vt.^2 + B.*vt + C;
f1 = f1.*exp(0.5.*D.*vt.^2 + B.*vt + C);

zzz = z1;
fff = f1;

