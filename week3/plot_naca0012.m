clear
close all

caseref = "Data/NACA0012.mat";
load(caseref);

% For naca comparisons

cd_cl = readtable('0012 cd cl 6e6.csv');
cl_alpha = readtable('0012 CL alpha 6e6.csv');

alphas_cd = interp1(cl_alpha.Var2(1:length(cl_alpha.Var1)-5), cl_alpha.Var1(1:length(cl_alpha.Var1)-5), cd_cl.Var1);

% C_L alpha
figure(1);
grid on
box on
hold on
plot(alpha, clswp);
scatter(cl_alpha.Var1, cl_alpha.Var2, 'X')
% plot(alpha, 2*pi*sin(deg2rad(alpha)));
%plot(0,0,'o');
xlabel('\alpha (degrees)');
ylabel('C_L');
title('NACA 0012');
legend('Panel result', 'Experiment', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca0012_clalpha','epsc2')
hold off;

figure(2);
grid on
box on
hold on
plot(clswp, cdswp)
scatter(cd_cl.Var1, cd_cl.Var2, 'X')
xlabel('C_L');
ylabel('C_D');
title('NACA 0012');
legend('Panel result', 'Experiment','Location','north')
ylim([0,0.055]);
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca0012_clcd','epsc2')
hold off;

figure(3);
grid on
box on
hold on
plot(alpha, cdswp);
%scatter(alphas_cd, cd_cl.Var2, 'X')
scatter(alphas_cd, cd_cl.Var2, 'X')
xlabel('\alpha (degrees)');
ylabel('C_D');
title('NACA 0012');
legend('Panel result', 'Experiment','Location','north')
ylim([0,0.055]);
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca0012_cdalpha','epsc2')
hold off;

