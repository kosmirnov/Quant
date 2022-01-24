%% Problem 2.2: Function to embed the characteristic function into problem 1 %%
% technical implementation is decribed in the paper
% by Konstantin Smirnov

function [fig1,fig2,fig3]=cnorm_embed(phi,mu_vec,sg_vec)

for count_mu=1:numel(mu_vec)
mu=mu_vec(count_mu);
    for k=1:numel(sg_vec)
        sg=sg_vec(k);

%% compute the functional path of the normal distribution %%
phi=phi';
a=-0.5.*phi.^2.*sg.^2;
b=phi.*mu;
z=a+1i*b;
w=exp(z);

%% use the exponential function of problem 1 and adjust it %%
[xx,yy] = meshgrid(a,b);
zz = xx +1i.*yy;
ww = exp(zz);



fig1=figure;
surf(real(zz),imag(zz),real(ww));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Re(w)');
material metal;
colormap(jet);
axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
hold on;
plot3(real(z),imag(z),real(w),'r','LineWidth',1.5);  
axis1.View = [80 60];
material metal;
shading interp;
title(sprintf('Real part of cexp with embedded path for \\mu=%d \\sigma=%d',mu_vec(count_mu),sg));
% saveas(fig1,sprintf('real_musg%d%d.png',count_mu,sg));



fig2=figure;
surf(real(zz),imag(zz),imag(ww));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Re(w)');
material metal;
colormap(jet);
axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
hold on;
plot3(real(z),imag(z),imag(w),'r','LineWidth',1.5);  
axis1.View = [80 60];
material metal;
shading interp;
title(sprintf('Imag. part of cexp with embedded path for\\mu=%d \\sigma=%d',mu_vec(count_mu),sg));
% saveas(fig2,sprintf('imag_musg%d%d.png',count_mu,sg));

fig3=figure;
surf(real(zz),imag(zz),abs(ww));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Re(w)');
material metal;
colormap(jet);
axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
hold on;
plot3(real(z),imag(z),abs(w),'r','LineWidth',1.5);  
material metal;
shading interp;
title(sprintf('Modulus of cexp with embedded path for \\mu=%d \\sigma=%d',mu_vec(count_mu),sg));
% saveas(fig3,sprintf('mod_musg%d%d.png',count_mu,sg));
    end
end

end
