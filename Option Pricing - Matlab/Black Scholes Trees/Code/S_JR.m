% subroutine for stock price tree
function Stock = S_JR(S,T,r,q,sig,n)

delta_T = T./n; % Time increment

u = exp((r-q-0.5.*sig.^2).*delta_T + sig.*sqrt(delta_T));
d = exp((r-q-0.5.*sig.^2).*delta_T - sig.*sqrt(delta_T));

%preallocation of the dimension of the binomial tree matrix 
TREE = zeros(n+1,n+1); %we need n+1 instead of n values

TREE(1,1) = S; % we set the starting point equal to S

for j=2:n+1 % loop for each column. It starts from position 2 because we have already set
            % position (1,1) equal to S
    for i=1:j %each row above the main diagonal
    
        TREE(i,j) = S.*u.^(j-i).*d.^(i-1);
    
    end
end;

Stock = TREE;
end