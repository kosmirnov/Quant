function Prob = N(d)
% Cumulative Standard Normal Distribution Function 

Prob = 0.5 + 0.5.*erf(d./sqrt(2));
