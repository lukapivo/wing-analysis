clear
close all

caseref = "Data/NACA4412.mat";
load(caseref);

figure(1);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('NACA 4412', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_NACA4412','epsc2')

figure(2);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('NACA 4412', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_NACA4412','epsc2')

caseref = "Data/final_LLH01.mat";
load(caseref);

figure(3);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLH01', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLH01','epsc2')

figure(4);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLH01', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLH01','epsc2')

caseref = "Data/final_LLH02.mat";
load(caseref);

figure(5);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLH02', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLH02','epsc2')

figure(6);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLH02', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLH02','epsc2')


caseref = "Data/final_LLH03.mat";
load(caseref);

figure(7);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLH03', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLH03','epsc2')

figure(8);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLH03', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLH03','epsc2')

caseref = "Data/final_LLH04.mat";
load(caseref);

figure(9);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLH04', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLH04','epsc2')

figure(10);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLH04', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLH04','epsc2')

caseref = "Data/final_LLH05.mat";
load(caseref);

figure(11);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLH04a', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLH04a','epsc2')

figure(12);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLH04a', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLH04a','epsc2')
% 
% caseref = "Data/LLL06b.mat";
% load(caseref);
% 
% figure(13);
% grid on
% box on
% plot(clswp, cdswp)
% xlabel('C_L');
% ylabel('C_D');
% 
% legend('LLL06', 'Location','north')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/cdcl_LLL06','epsc2')
% 
% figure(14);
% grid on
% box on
% plot(alpha, lovdswp);
% xlabel('\alpha (deg)');
% ylabel('L/D');
% 
% legend('LLL06', 'Location','northwest')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/ld_LLL06','epsc2')
% 
% caseref = "Data/LLL07b.mat";
% load(caseref);
% 
% figure(15);
% grid on
% box on
% plot(clswp, cdswp)
% xlabel('C_L');
% ylabel('C_D');
% 
% legend('LLL07', 'Location','north')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/cdcl_LLL07','epsc2')
% 
% figure(16);
% grid on
% box on
% plot(alpha, lovdswp);
% xlabel('\alpha (deg)');
% ylabel('L/D');
% 
% legend('LLL07', 'Location','northwest')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/ld_LLL07','epsc2')
% 
% caseref = "Data/LLL08b.mat";
% load(caseref);
% 
% figure(17);
% grid on
% box on
% plot(clswp, cdswp)
% xlabel('C_L');
% ylabel('C_D');
% 
% legend('LLL08', 'Location','north')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/cdcl_LLL08','epsc2')
% 
% figure(18);
% grid on
% box on
% plot(alpha, lovdswp);
% xlabel('\alpha (deg)');
% ylabel('L/D');
% 
% legend('LLL08', 'Location','northwest')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/ld_LLL08','epsc2')