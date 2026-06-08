clear
close all

caseref = "Data/LLL08.mat";
load(caseref);

% C_L alpha and C_D alpha
figure(1);
hold on
plot(alpha, clswp);
plot(alpha, cdswp);
legend("C_L","C_D");
xlabel('Angle of Attack (degrees)');
ylabel('Coefficients');
title('Lift and Drag Coefficients vs. Angle of Attack');
hold off;

figure(2);
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

figure(3);
grid on
plot(alpha, lovdswp);
xlabel('Angle of Attack (degrees)');
ylabel('L/D');


% % For naca comparisons
% 
% % C_L alpha
% figure(1);
% hold on
% plot(alpha, clswp);
% % plot(alpha, 2*pi*sin(deg2rad(alpha)));
% plot(0,0,'o');
% xlabel('\alpha (degrees)');
% ylabel('C_L');
% title('NACA 0012');
% % legend('Panel result', '2\pi sin(\alpha)')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% %saveas(gcf,'week3/Figures/naca0012_clalpha','epsc2')
% hold off;
% 
% figure(2);
% plot(clswp, cdswp)
% xlabel('C_L');
% ylabel('C_D');
% title('NACA 0012');
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% %saveas(gcf,'week3/Figures/naca0012_clcd','epsc2')
% 
% figure(3);
% grid on
% plot(alpha, cdswp);
% xlabel('\alpha (degrees)');
% ylabel('C_D');
% title('NACA 0012');
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% %saveas(gcf,'week3/Figures/naca0012_cdalpha','epsc2')

