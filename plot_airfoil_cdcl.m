clear
close all

caseref = "Data/NACA0012.mat";
load(caseref);

figure(1);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('NACA0012', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_NACA0012','epsc2')

figure(2);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('NACA0012', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_NACA0012','epsc2')

caseref = "Data/LLL.mat";
load(caseref);

figure(3);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL01', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL01','epsc2')

figure(4);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL01', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL01','epsc2')

caseref = "Data/LLL02.mat";
load(caseref);

figure(5);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL02', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL02','epsc2')

figure(6);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL02', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL02','epsc2')


caseref = "Data/LLL03.mat";
load(caseref);

figure(7);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL03', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL03','epsc2')

figure(8);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL03', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL03','epsc2')

caseref = "Data/LLL04.mat";
load(caseref);

figure(9);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL04', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL04','epsc2')

figure(10);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL04', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL04','epsc2')

caseref = "Data/LLL05.mat";
load(caseref);

figure(11);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL05', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL05','epsc2')

figure(12);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL05', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL05','epsc2')

caseref = "Data/LLL06b.mat";
load(caseref);

figure(13);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL06', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL06','epsc2')

figure(14);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL06', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL06','epsc2')

caseref = "Data/LLL07b.mat";
load(caseref);

figure(15);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL07', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL07','epsc2')

figure(16);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL07', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL07','epsc2')

caseref = "Data/LLL08b.mat";
load(caseref);

figure(17);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLL08', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLL08','epsc2')

figure(18);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLL08', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLL08','epsc2')

caseref = "Data/final_LLH04_low.mat";
load(caseref);

figure(19);
grid on
box on
plot(clswp, cdswp)
xlabel('C_L');
ylabel('C_D');

legend('LLLH04', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cdcl_LLH04_low','epsc2')

figure(20);
grid on
box on
plot(alpha, lovdswp);
xlabel('\alpha (deg)');
ylabel('L/D');

legend('LLH04', 'Location','northwest')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/ld_LLH04_low','epsc2')