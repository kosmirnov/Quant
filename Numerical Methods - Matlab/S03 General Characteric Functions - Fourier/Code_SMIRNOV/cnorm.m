%% Problem 2.1: Characteristic Function of the Normal Distribution
% technical implementation is decribed in the paper
% by Konstantin Smirnov

function [fig1,fig2]=cnorm(ph,mu_vec,sg_vec)

for count_mu=1:numel(mu_vec)
mu=mu_vec(count_mu);
    for k=1:numel(sg_vec)
        sg=sg_vec(k);


z = 1i.*ph'*mu - 0.5.*sg.*sg.*ph'.*ph'; % charecteristic function
w = exp(z);

fig1=figure;
plot3(real(z),imag(z),ph,'LineWidth',1.5);
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('phi');
grid on;
title(sprintf('z plot: \\mu=%d \\sigma=%d',mu_vec(count_mu),sg)); % sprintf command enables us to include strigs for the title for varying parameters
% saveas(fig1(count_mu,k),sprintf('plot6_musg%d%d.png',count_mu,sg)); 

    
fig2=figure;
plot3(real(w),imag(w),ph,'r','LineWidth',1.5);
xlabel('Re(w)');
ylabel('Im(w)');
zlabel('phi');
grid on;
title(sprintf('w plot: \\mu=%d \\sigma=%d',mu_vec(count_mu),sg));
% saveas(fig2(count_mu,k),sprintf('plot7_musg%d%d.png',count_mu,sg)); 
    end
end