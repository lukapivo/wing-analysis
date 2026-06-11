clear
close all

caseref = "Geometry/NACA0012.surf";
load(caseref);

caseref = "Geometry/LLL01.surf";
load(caseref);

caseref = "Geometry/LLL02.surf";
load(caseref);

caseref = "Geometry/LLL03.surf";
load(caseref);

caseref = "Geometry/LLL04.surf";
load(caseref);

caseref = "Geometry/LLL05.surf";
load(caseref);

caseref = "Geometry/LLL06b.surf";
load(caseref);

caseref = "Geometry/LLL07b.surf";
load(caseref);

caseref = "Geometry/LLL08b6.surf";
load(caseref);

x1 = NACA0012(:, 1);
y1 = NACA0012(:, 2);

x2 = LLL01(:, 1);
y2 = LLL01(:, 2);

x3 = LLL02(:, 1);
y3 = LLL02(:, 2);

x4 = LLL03(:, 1);
y4 = LLL03(:, 2);

x5 = LLL04(:, 1);
y5 = LLL04(:, 2);

x6 = LLL05(:, 1);
y6 = LLL05(:, 2);
[xs6 ys6] = splinefit([1;x6(2:end-1);1],[0;y6(2:end-1);0],0);

x7 = LLL06b(:, 1);
y7 = LLL06b(:, 2);
[xs7 ys7] = splinefit([1;x7(2:end-1);1],[0;y7(2:end-1);0],0);

x8 = LLL07b(:, 1);
y8 = LLL07b(:, 2);
[xs8 ys8] = splinefit([1;x8(2:end-1);1],[0;y8(2:end-1);0],0);

x9 = LLL08b6(:, 1);
y9 = LLL08b6(:, 2);
[xs9 ys9] = splinefit([1;x9(2:end-1);1],[0;y9(2:end-1);0],0);

% Airfoils
figure(1);
axis equal
box on
hold on
plot(x1, y1);
xlabel('x/c');
ylabel('y/c');
legend('NACA 0012')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/NACA0012','epsc2')
hold off;

figure(2);
axis equal
box on
hold on
plot(x1, y1, '--');
plot(x2, y2);
xlabel('x/c');
ylabel('y/c');
legend('NACA 0012', 'LLL01')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL01','epsc2')
hold off;

figure(3);
axis equal
box on
hold on
plot(x2, y2, '--');
plot(x3, y3);
xlabel('x/c');
ylabel('y/c');
legend('LLL01', 'LLL02')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL02','epsc2')
hold off;


figure(4);
axis equal
box on
hold on
plot(x3, y3, '--');
plot(x4, y4);
xlabel('x/c');
ylabel('y/c');
legend('LLL02', 'LLL03')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL03','epsc2')
hold off;

figure(5);
axis equal
box on
hold on
plot(x4, y4, '--');
plot(x5, y5);
xlabel('x/c');
ylabel('y/c');
legend('LLL03', 'LLL04')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL04','epsc2')
hold off;

figure(6);
axis equal
box on
hold on
plot(x5, y5, '--');
plot(xs6, ys6);
xlabel('x/c');
ylabel('y/c');
legend('LLL04', 'LLL05')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL05','epsc2')
hold off;

figure(7);
axis equal
box on
hold on
plot(xs6, ys6, '--');
plot(xs7, ys7);
xlabel('x/c');
ylabel('y/c');
legend('LLL05', 'LLL06')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL06','epsc2')
hold off;

figure(8);
axis equal
box on
hold on
plot(xs7, ys7, '--');
plot(xs8, ys8);
xlabel('x/c');
ylabel('y/c');
legend('LLL06', 'LLL07')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL07','epsc2')
hold off;

figure(9);
axis equal
box on
hold on
plot(xs8, ys8, '--');
plot(xs9, ys9);
xlabel('x/c');
ylabel('y/c');
legend('LLL07', 'LLL08')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/LLL08','epsc2')
hold off;