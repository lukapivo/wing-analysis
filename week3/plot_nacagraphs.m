clear
close all

caseref = "Data/NACA4412.mat";
load(caseref);

% For naca comparisons

cd_cl = readtable('4412 cd cl 6e6.csv');
cl_alpha = readtable('4412 CL alpha 6e6.csv');

alphas_cd = interp1(cl_alpha.Var2, cl_alpha.Var1, cd_cl.Var1);

% C_L alpha
figure(1);
hold on
plot(alpha, clswp);
scatter(cl_alpha.Var1, cl_alpha.Var2, 'X')
% plot(alpha, 2*pi*sin(deg2rad(alpha)));
%plot(0,0,'o');
xlabel('\alpha (degrees)');
ylabel('C_L');
title('NACA 4412');
legend('Panel result', 'Experiment')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca4412_clalpha','epsc2')
hold off;

figure(2);
hold on
plot(clswp, cdswp)
scatter(cd_cl.Var1, cd_cl.Var2, 'X')
xlabel('C_L');
ylabel('C_D');
title('NACA 4412');
legend('Panel result', 'Experiment')
ylim([0,0.055]);
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca4412_clcd','epsc2')
hold off;

figure(3);
grid on
hold on
plot(alpha, cdswp);
scatter(alphas_cd, cd_cl.Var2, 'X')
xlabel('\alpha (degrees)');
ylabel('C_D');
title('NACA 4412');
ylim([0,0.055]);
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca4412_cdalpha','epsc2')
hold off;

