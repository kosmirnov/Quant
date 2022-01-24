%% Problem 1: Complex Exponential Function
% technical implementation is decribed in the paper
% by Konstantin Smirnov

function [plot1,plot2,plot3,plot4,plot5, plot6]=cexp


[xx,yy]=meshgrid([-3:0.05:-eps,eps:0.05:3],[-10:0.05:-eps,eps:0.05:10]);

z = xx +i.*yy;
w = exp(z);



plot1=figure;
surf(xx,yy,real(w));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Re(w)');
xlim([0 3]);
axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi'; '-0.5 \pi';  0; '0.5 \pi';  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
view(axis1,[57.7 14]);
material metal;
shading interp;
colormap(jet);
lightangle(90,120);
lightangle(-90,60);
lightangle(-180,-60);
axis;
title('Real Part of the Complex Exponential Function');
% saveas(gcf,'plot1.jpeg');


plot2=figure;
surf(xx,yy,imag(w));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Im(w)');
xlim([0 3]);
axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
view(axis1,[66.5 27.6]);
material metal;
shading interp;
colormap(jet);
lightangle(90,120);
lightangle(-90,60);
lightangle(-180,-60);
axis;
title('Imaginary Part of the Complex Exponential Function');
% saveas(gcf,'plot2.jpeg');


plot3=figure;
surf(xx,yy,abs(w));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Abs(w)');
xlim([-3 3]);
axis1=gca;
view(axis1,[-13.9 22.8]);
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
material metal;
shading interp;
colormap(jet);
lightangle(90,120);
lightangle(-90,60);
lightangle(-180,-60);
axis;
title('Modulus of the Complex Exponential Function');
% saveas(gcf,'plot3.jpeg');

plot4=figure;
contour(xx,yy,real(w));
hold on;
contour(xx,yy,imag(w));
hold off;
xlabel('Re(w)');
ylabel('Im(w)');
xlim([0 3]);
ylim([-pi pi]);
axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
material metal;
shading interp;
colormap(jet);
lightangle(90,120);
lightangle(-90,60);
lightangle(-180,-60);
axis;
colormap(jet);
title('Contour Plot of the Complex Exponential Function');
% saveas(gcf,'plot4.jpeg');

plot5=figure;
surfc(xx,yy,real(w));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Re(w)');
xlim([0 3]);
ylim([-pi pi]);
axis1=gca;
view(axis1,[56.5 18.8]);
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
material metal;
shading interp;
colormap(jet);
lightangle(90,120);
lightangle(-90,60);
lightangle(-180,-60);
axis;
colorbar;
% saveas(gcf,'plot5.jpeg');
title('Surface Plot with Contours of the Real Part of Complex Exponential Function');

plot6=figure;
surfc(xx,yy,imag(w));
xlabel('Re(z)');
ylabel('Im(z)');
zlabel('Im(w)');
xlim([0 3]);
ylim([-pi pi]);
axis1=gca;
view(axis1,[60.9 26]);
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
material metal;
shading interp;
colormap(jet);
lightangle(90,120);
lightangle(-90,60);
lightangle(-180,-60);
axis;
colorbar;
title('Surface Plot with Contours of the Imaginary Part of Complex Exponential Function');
% saveas(gcf,'plot6.jpeg');

