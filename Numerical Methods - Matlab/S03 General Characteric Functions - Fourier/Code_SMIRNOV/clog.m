%% Problem 3: Complex Logarithmic Function
% technical implementation is decribed in the paper
% by Konstantin Smirnov

function [plot1,plot2,plot3,plot4,plot51,plot52,plot6]=clog(pause_ind)

%% create quadrants to get nice plots %%
[xx1,yy1]=meshgrid(-3:0.05:eps,-10:0.05:eps);
[xx2,yy2]=meshgrid(eps:0.05:3,-10:0.05:eps);
[xx3,yy3]=meshgrid(eps:0.05:3,eps:0.05:10);
[xx4,yy4]=meshgrid(-3:0.05:eps,eps:0.05:10);


zz1 = xx1 + 1i.*yy1;
zz2 = xx2 + 1i.*yy2;
zz3 = xx3 + 1i.*yy3;
zz4 = xx4 + 1i.*yy4;

ww1 = log(zz1);
ww2 = log(zz2);
ww3 = log(zz3);
ww4 = log(zz4);

%% Plot 1 :  Real Part %%
plot1=figure;
    surf(real(zz1),imag(zz1),real(ww1)); % first quadrant
    xlabel('Re(z)');
    ylabel('Im(z)');
    zlabel('Im(w)');
    colormap(jet);
    xlim([-3 3]);
    zlim([-5 2]);
    ylim([-pi pi]);
    axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;
    surf(real(zz2),imag(zz2),real(ww2)); 
    hold on;
    surf(real(zz3),imag(zz3),real(ww3));  
    hold on;
    surf(real(zz4),imag(zz4),real(ww4)); 
    shading interp;
hold off;
% saveas(gcf,'plot1_log.jpeg');

%% Plot 2 :  Imaginary Part %%
plot2=figure;
for k=-1:1:1 % increases pi by k to get a new round
    surf(real(zz1),imag(zz1),imag(ww1 + 2*k*pi*1i),'LineStyle','none'); % first quadrant
    xlabel('Re(z)');
    ylabel('Im(z)');
    zlabel('Im(w)');
    colormap(jet);
    camlight('headlight');
    camlight('right');
    axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;
    surf(real(zz2),imag(zz2),imag(ww2 + 2*k*pi*1i),'LineStyle','none'); % second quadrant 
    hold on;
    surf(real(zz3),imag(zz3),imag(ww3 + 2*k*pi*1i),'LineStyle','none'); % third quadrant 
    hold on;
    surf(real(zz4),imag(zz4),imag(ww4 + 2*k*pi*1i),'LineStyle','none'); % foruth quadrant 
    material metal;
    shading interp;
    hold on;
    if pause_ind == 'Y' 
    pause(1);
    else 
    end
end
hold off;
title('Imaginary Part of the Complex Logarithmic Function for k = [-1 1] (Riemann Surface)');
% saveas(gcf,'plot2_log.jpeg');

%% Plot 3: Surface plot with contour lines for the real part %%
plot3=figure;
    surfc(real(zz1),imag(zz1),real(ww1)); % first quadrant
    xlabel('Re(z)');
    ylabel('Im(z)');
    zlabel('Im(w)');
    xlim([-3 3]);
    ylim([-pi pi]);
    colormap(jet);
    axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;
    surfc(real(zz2),imag(zz2),real(ww2)); 
    hold on;
    surfc(real(zz3),imag(zz3),real(ww3));  
    hold on;
    surfc(real(zz4),imag(zz4),real(ww4)); 
    shading interp;
hold off;
title('Surface plot with contour lines for the real part of the Complex Logarithmic Function');
% saveas(gcf,'plot3_log.jpeg');

%% Plot 4: Surface plot with contour lines of the imaginary part %%
plot4=figure;
for k=1 % increases pi by k to get a new round
    surfc(real(zz1),imag(zz1),imag(ww1 + 2*k*pi*1i),'LineStyle','none'); % first quadrant
    xlabel('Re(z)');
    ylabel('Im(z)');
    zlabel('Im(w)');
    zlim([-15 15]);
    colormap(jet);
    camlight('headlight');
    camlight('right');
    axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;
    surfc(real(zz2),imag(zz2),imag(ww2 + 2*k*pi*1i),'LineStyle','none'); % second quadrant 
    hold on;
    surfc(real(zz3),imag(zz3),imag(ww3 + 2*k*pi*1i),'LineStyle','none'); % third quadrant 
    hold on;
    surfc(real(zz4),imag(zz4),imag(ww4 + 2*k*pi*1i),'LineStyle','none'); % foruth quadrant 
    material metal;
    shading interp;
    hold on;
end
hold off;
title('Surface plot with contour lines for the imaginary part of the Complex Logarithmic Function');
% saveas(gcf,'plot4_log.jpeg');

%% Plot 5.1:  Contour Plot of the Imaginary and Real Part for k=1 %%
plot51=figure;
contour(xx1,yy1,real(ww1),'r','LineWidth',1.5);
    xlabel('Re(z)');
    ylabel('Im(z)');
    material metal;
    shading interp;
    axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;
hold on;
contour(xx2,yy2,real(ww2),'r','LineWidth',1.5);
hold on;
contour(xx3,yy4,real(ww3),'r','LineWidth',1.5);
hold on;
contour(xx4,yy4,real(ww4),'r','LineWidth',1.5);
hold on;
    if pause_ind == 'Y' 
    pause(1);
    else 
    end
for k=1 % this loop is needed to increase the imaginary part by 2 pi
    contour(real(zz1),imag(zz1),imag(ww1 + 2*k*pi*1i)); % first quadrant
    material metal;
    shading interp;
    colormap(winter);
    hold on;
    contour(real(zz2),imag(zz2),imag(ww2 + 2*k*pi*1i)); % third quadrant 
    material metal;
    shading interp;
    hold on;
    contour(real(zz3),imag(zz3),imag(ww3 + 2*k*pi*1i)); % third quadrant 
    material metal;
    shading interp;
    hold on;
    contour(real(zz4),imag(zz4),imag(ww4 + 2*k*pi*1i)); % foruth quadrant 
    material metal;
    shading interp;
    hold on;
    if pause_ind == 'Y' 
    pause(1);
    else 
    end
end
title('Contour Plot of the Complex Logarithmic Function for k=1');
% saveas(gcf,'plot51_log.jpeg');

%% Plot 5.2:  Contour Plot of the Imaginary and Real Part for k=1 %%
plot52=figure;
contour(xx1,yy1,real(ww1),'r','LineWidth',1.5);
    xlabel('Re(z)');
    ylabel('Im(z)');
    material metal;
    shading interp;
    axis1=gca;
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;
hold on;
contour(xx2,yy2,real(ww2),'r','LineWidth',1.5);
hold on;
contour(xx3,yy4,real(ww3),'r','LineWidth',1.5);
hold on;
contour(xx4,yy4,real(ww4),'r','LineWidth',1.5);
hold on;
    if pause_ind == 'Y' 
    pause(1);
    else 
    end
for k=-2:1:2 % this loop is needed to increase the imaginary part by 2 pi
    contour(real(zz1),imag(zz1),imag(ww1 + 2*k*pi*1i)); % first quadrant
    material metal;
    shading interp;
    colormap(winter);
    hold on;
    contour(real(zz2),imag(zz2),imag(ww2 + 2*k*pi*1i)); % third quadrant 
    material metal;
    shading interp;
    hold on;
    contour(real(zz3),imag(zz3),imag(ww3 + 2*k*pi*1i)); % third quadrant 
    material metal;
    shading interp;
    hold on;
    contour(real(zz4),imag(zz4),imag(ww4 + 2*k*pi*1i)); % foruth quadrant 
    material metal;
    shading interp;
    hold on;
    if pause_ind == 'Y' 
    pause(1);
    else 
    end
end
title('Contour Plot of the Complex Logarithmic Function for k=[-2:1:2]');

% saveas(gcf,'plot52_log.jpeg');

%% Plot of the modulus %%
plot6=figure;
for k=-1:1:1 
    surf(real(zz1),imag(zz1),abs(ww1 + 2*k*pi*1i),'LineStyle','none'); % first quadrant
    xlabel('Re(z)');
    ylabel('Im(z)');
    zlabel('Im(w)');
    xlim([-4 4]);
    zlim([-5 12]);
    ylim([-2*pi 2*pi]);
    colormap(hsv(256));
    axis1=gca;
    axis1.ZLim = [0 25];
    set(axis1, 'YTick', -4*pi:pi:4*pi,...
      'YTickLabel',{ '-4 \pi' ;'-3 \pi' ; '-2 \pi' ;  '- \pi';  0;  ' \pi';   '2 \pi';  '3 \pi';   '4 \pi'});
    hold on;

    surf(real(zz2),imag(zz2),abs(ww2 + 2*k*pi*1i),'LineStyle','none'); % second quadrant 
    hold on;
    surf(real(zz3),imag(zz3),abs(ww3 + 2*k*pi*1i),'LineStyle','none'); % third quadrant 
    hold on;
    surf(real(zz4),imag(zz4),abs(ww4 + 2*k*pi*1i),'LineStyle','none'); % foruth quadrant 
    material metal;
    shading interp;
    hold on;
    if pause_ind == 'Y' 
    pause(1);
    else 
    end
end
hold off;
title('Modulus Plot of the Complex Logarithmic Function with k=[-1 1]');
% saveas(gcf,'plot6_log.jpeg');
end