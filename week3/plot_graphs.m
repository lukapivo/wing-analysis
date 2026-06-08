clear
close all

caseref = "Data/naca4412.mat";
load(caseref);

% % C_L alpha and C_D alpha
% figure(1);
% hold on
% plot(alpha, clswp);
% plot(alpha, cdswp);
% legend("C_L","C_D");
% xlabel('Angle of Attack (degrees)');
% ylabel('Coefficients');
% title('Lift and Drag Coefficients vs. Angle of Attack');
% hold off;
% 
% figure(2);
% plot(clswp, cdswp)
% xlabel('C_L');
% ylabel('C_D');
% 
% figure(3);
% grid on
% plot(alpha, lovdswp);
% xlabel('Angle of Attack (degrees)');
% ylabel('L/D');


% For naca comparisons

% C_L alpha and C_D alpha
figure(1);
hold on
plot(alpha, clswp);
xlabel('Angle of Attack (degrees)');
ylabel('Lift coefficient C_L');
legend('NACA 4412');
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca4412_clalpha','epsc2')
hold off;

figure(2);
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');
legend('NACA 4412');
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca4412_clcd','epsc2')

figure(3);
grid on
plot(alpha, cdswp);
xlabel('Angle of Attack (degrees)');
ylabel('Drag coefficient C_D');
legend('NACA 4412');
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/naca4412_cdalpha','epsc2')

