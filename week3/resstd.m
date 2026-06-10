%  Script for use in studying resolution requirements of panel method 
%  calculation.  To alter incidence, edit 'alpha' below.  To alter
%  Van de Vooren geometry parameters, see vdvfoil.m.

clear
close all

%  free-stream incidence
alpha = pi/12;

%  Van de Vooren geometry and pressure distribution
npin = 2000;
[xsin ysin cpex] = vdvfoil( npin, alpha );

figure(1)
plot(xsin,ysin)
axis('equal')
xlabel('x/c')
ylabel('y/c')
title('Van de Vooren aerofoil')
saveas(gcf,'week3/Figures/resstd_airfoil','epsc')

disp('Starting 100 panel calculation ...')
np = 100;
[xs ys] = make_upanels( xsin, ysin, np );

A = build_lhs ( xs, ys );
b = build_rhs ( xs, ys, alpha );

gams = inv(A) * b;
xs1 = xs;
cp1 = 1 - gams.^2;

disp('Starting 200 panel calculation ...')
np = 200;
[xs ys] = make_upanels( xsin, ysin, np );

A = build_lhs ( xs, ys );
b = build_rhs ( xs, ys, alpha );

gams = inv(A) * b;
xs2 = xs;
cp2 = 1 - gams.^2;

disp('Starting 400 panel calculation ...')
np = 400;
[xs ys] = make_upanels( xsin, ysin, np );

A = build_lhs ( xs, ys );
b = build_rhs ( xs, ys, alpha );

gams = inv(A) * b;
xs4 = xs;
cp4 = 1 - gams.^2;

disp('Starting 800 panel calculation ...')
np = 800;
[xs ys] = make_upanels( xsin, ysin, np );

A = build_lhs ( xs, ys );
b = build_rhs ( xs, ys, alpha );

gams = inv(A) * b;
xs8 = xs;
cp8 = 1 - gams.^2;

figure(2)
plot(xsin,-cpex,xs1,-cp1,'--',xs2,-cp2,'-.',xs4,-cp4,'-+',xs8,-cp8,'-x')
xlabel('x/c')
ylabel('-c_p')
title('Van de Vooren cps; varying panel size')
legend('exact','100pans','200pans','400pans','800pans')
saveas(gcf,'week3/Figures/resstd_all','epsc')

figure(3)
plot(xsin,-cpex,xs1,-cp1,'--')


ax3 = gca;
zoom_region = [-0.002 27 0.002 28];
zoom_ax = zoomed_axes(ax3, zoom_region);
legend(ax3, 'exact','100pans')


saveas(gcf,'week3/Figures/resstd_100','epsc')

figure(4)
plot(xsin,-cpex,xs2,-cp2,'-.')


ax4 = gca;
zoom_region = [-0.005 27 0.005 32];
zoom_ax = zoomed_axes(ax4, zoom_region);
legend(ax4,'exact','200pans')


saveas(gcf,'week3/Figures/resstd_200','epsc')

figure(5)
plot(xsin,-cpex,xs4,-cp4,'-+')

ax5 = gca;
zoom_region = [-0.005 27 0.005 32];
zoom_ax = zoomed_axes(ax5, zoom_region);

legend('exact','400pans')


saveas(gcf,'week3/Figures/resstd_400','epsc')

figure(6)
plot(xsin,-cpex,xs8,-cp8,'-x')

ax6 = gca;
zoom_region = [-0.005 27 0.005 28];
zoom_ax = zoomed_axes(ax6, zoom_region);

legend(ax6, 'exact','800pans')
saveas(gcf,'week3/Figures/resstd_800','epsc')

figure(7)
plot(xsin,-cpex)
legend('exact')
saveas(gcf,'week3/Figures/resstd_exact','epsc')