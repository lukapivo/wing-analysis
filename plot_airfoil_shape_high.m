clear
close all

caseref = "Geometry/NACA4412.surf";
load(caseref);

caseref = "Geometry/final_LLH01.surf";
load(caseref);

caseref = "Geometry/final_LLH02.surf";
load(caseref);

caseref = "Geometry/final_LLH03.surf";
load(caseref);

caseref = "Geometry/final_LLH04.surf";
load(caseref);
% 
% caseref = "Geometry/LLL05.surf";
% load(caseref);
% 
% caseref = "Geometry/LLL06b.surf";
% load(caseref);
% 
% caseref = "Geometry/LLL07b.surf";
% load(caseref);
% 
% caseref = "Geometry/LLL08b6.surf";
% load(caseref);

x1 = NACA4412(:, 1);
y1 = NACA4412(:, 2);

x2 = final_LLH01(:, 1);
y2 = final_LLH01(:, 2);

x3 = final_LLH02(:, 1);
y3 = final_LLH02(:, 2);

x4 = final_LLH03(:, 1);
y4 = final_LLH03(:, 2);

x5 = final_LLH04(:, 1);
y5 = final_LLH04(:, 2);

% x6 = LLL05(:, 1);
% y6 = LLL05(:, 2);
% [xs6 ys6] = splinefit([1;x6(2:end-1);1],[0;y6(2:end-1);0],0);
% 
% x7 = LLL06b(:, 1);
% y7 = LLL06b(:, 2);
% [xs7 ys7] = splinefit([1;x7(2:end-1);1],[0;y7(2:end-1);0],0);
% 
% x8 = LLL07b(:, 1);
% y8 = LLL07b(:, 2);
% [xs8 ys8] = splinefit([1;x8(2:end-1);1],[0;y8(2:end-1);0],0);
% 
% x9 = LLL08b6(:, 1);
% y9 = LLL08b6(:, 2);
% [xs9 ys9] = splinefit([1;x9(2:end-1);1],[0;y9(2:end-1);0],0);

% Airfoils
figure(1);
axis equal
box on
hold on
plot(x1, y1);
xlabel('x/c');
ylabel('y/c');
legend('NACA 4412')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/NACA4412','epsc2')
hold off;

figure(2);
axis equal
box on
hold on
plot(x1, y1, '--');
plot(x2, y2);
xlabel('x/c');
ylabel('y/c');
legend('NACA 4412', 'LLH01')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLH01','epsc2')
hold off;

figure(3);
axis equal
box on
hold on
plot(x1, y1, '--');
plot(x3, y3);
xlabel('x/c');
ylabel('y/c');
legend('NACA 4412', 'LLH02')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLH02','epsc2')
hold off;


figure(4);
axis equal
box on
hold on
plot(x3, y3, '--');
plot(x4, y4);
xlabel('x/c');
ylabel('y/c');
legend('LLH02', 'LLH03')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLH03','epsc2')
hold off;

figure(5);
axis equal
box on
hold on
plot(x4, y4, '--');
plot(x5, y5);
xlabel('x/c');
ylabel('y/c');
legend('LLH03', 'LLH04')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLH04','epsc2')
hold off;

% figure(6);
% axis equal
% box on
% hold on
% plot(x5, y5, '--');
% plot(xs6, ys6);
% legend('LLL04', 'LLL05')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/LLL05','epsc2')
% hold off;
% 
% figure(7);
% axis equal
% box on
% hold on
% plot(xs6, ys6, '--');
% plot(xs7, ys7);
% legend('LLL05', 'LLL06')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/LLL06','epsc2')
% hold off;
% 
% figure(8);
% axis equal
% box on
% hold on
% plot(xs7, ys7, '--');
% plot(xs8, ys8);
% legend('LLL06', 'LLL07')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/LLL07','epsc2')
% hold off;
% 
% figure(9);
% axis equal
% box on
% hold on
% plot(xs8, ys8, '--');
% plot(xs9, ys9);
% legend('LLL07', 'LLL08')
% set(gcf,'units', 'centimeters','position',[0,0,8,5])
% saveas(gcf,'week3/Figures/LLL08','epsc2')
% hold off;