EV_Mat=zeros(20,20);


for n=100:100:2000
    for i=10:10:200
    [d1,d2,d3]=d_calc(i,n);
    [A]=tridiag(d1,d2,d3);
    EV=eig(A);
    norm_a=norm(A);
    Max_EV=max(EV);
    i_mat=i/10;
    n_mat=n/100;
        if Max_EV<=norm_a;
        EV_Mat(n_mat,i_mat)=Max_EV;
        else
        EV_Mat(n_mat,i_mat)=0;
        end;
    end;
end;

