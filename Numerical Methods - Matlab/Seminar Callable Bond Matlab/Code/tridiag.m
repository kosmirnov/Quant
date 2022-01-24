function [ A ] = tridiag(d1,d2,d3)
% This function creates a tridiagonal matrix from three input vectors.

D1 = diag(d1,-1); % d1(i) becomes the A(i,i-1) element (first value drops) 
D2 = diag(d2, 0); % d2(i) becomes the A(i,i  ) element (main diagonal)
D3 = diag(d3, 1); % d3(i) becomes the A(i,i+1) element (last value drops)
A = D1(2:end,2:end) + D2 + D3(1:end-1,1:end-1);
A(end,end-1) = A(end,end-1) + d3(end);

end

