%% This script calculates the absolute error (vs. true value) for each Mx and Nt combination

for n=100:100:2000;             
    n_mat=n/100;
        for i=10:10:200
        i_mat=i/10;
        ME(n_mat,i_mat)=Max_Error(i,n);
        end
end


