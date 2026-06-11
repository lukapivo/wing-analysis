clear
close all

function [] = plot_points(int, ils, itr, its, ax1, x, thetas, color)
C = color;

xl1 = xlim(ax1);
yl1 = ylim(ax1);

dx1 = (xl1(2) - xl1(1)) * 0.005;
dy1 = (yl1(2) - yl1(1)) * 0.005;

if int ~= 0
    disp(['Natural transition at ' num2str(x(int))])
    plot(ax1, x(int), thetas(int), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
    % text(ax1, x(int)-2*dx1, thetas(int)+2*dy1, "NT", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    % plot(ax2, x(int), He(int), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
    % text(ax2, x(int)-2*dx2, He(int)+2*dy2, "Natural Transition", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
end

if ils ~= 0
    disp(['Laminar separation at ' num2str(x(ils))])
    plot(ax1, x(ils), thetas(ils), "^", "MarkerSize",4, "Color", C,'HandleVisibility','off')
    % text(ax1, x(ils)-2*dx1, thetas(ils)+2*dy1, "LS", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    % plot(ax2, x(ils), He(ils), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
    % text(ax2, x(ils)+dx2, He(ils), "Laminar Separation", "FontSize", 10, "Color", C)
end

if itr ~= 0
    disp(['Turbulent reattachment at ' num2str(x(itr))])
    plot(ax1, x(itr), thetas(itr), "square", "MarkerSize",4, "Color", C,'HandleVisibility','off')
    % text(ax1, x(itr)+dx1, thetas(itr)-2*dy1, "TR", "FontSize", 10, "Color", C)
    % plot(ax2, x(itr), He(itr), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
    % text(ax2, x(itr)+dx2, He(itr), "Turbulent Reattachment", "FontSize", 10, "Color", C)
end

if its ~= 0
    disp(['Turbulent separation at ' num2str(x(its))])
    plot(ax1, x(its), thetas(its), "x", "MarkerSize",4, "Color", C,'HandleVisibility','off')
    % text(ax1, x(its)-2*dx1, thetas(its)+2*dy1, "TS", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    % plot(ax2, x(its), He(its), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
    % text(ax2, x(its)-2*dx2, He(its), "Turbulent Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
end
end

caseref = "Data/NACA0012_5.mat";
load(caseref);

figure(1);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('NACA0012', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_NACA0012','epsc2')

% Airfoils
figure(2);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');


caseref = "Data/LLL_5.mat";
load(caseref);


figure(2);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('NACA0012', 'LLL01', 'Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL01','epsc2')


figure(3);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');

caseref = "Data/LLL02_5.mat";
load(caseref);


figure(3);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL01', 'LLL02','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL02','epsc2')

figure(4);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');

caseref = "Data/LLL03_5.mat";
load(caseref);


figure(4);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL02', 'LLL03','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL03','epsc2')

figure(5);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');

caseref = "Data/LLL04_5.mat";
load(caseref);


figure(5);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL03', 'LLL04','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL04','epsc2')

figure(6);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');

caseref = "Data/LLL05_5.mat";
load(caseref);


figure(6);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL04', 'LLL05','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL05','epsc2')

figure(8);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');


caseref = "Data/LLL07b_5.mat";
load(caseref);


figure(8);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL05', 'LLL07','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL07','epsc2')

figure(9);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');

caseref = "Data/LLL08b_5.mat";
load(caseref);


figure(9);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL07', 'LLL08','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL08','epsc2')









caseref = "Data/LLL07b_3.mat";
load(caseref);

figure(10);
box on 
hold on
plot(xs, cp, 'b--');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'b');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'b');

caseref = "Data/LLL08b_3.mat";
load(caseref);


figure(10);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');

legend('LLL07', 'LLL08','Location','south')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLL08_3deg','epsc2')




caseref = "Data/NACA0012_7.mat";
load(caseref);

figure(11);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');


legend('NACA0012','Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_NACA0012_7deg','epsc2')


caseref = "Data/final_LLH04_low_5.mat";
load(caseref);

figure(12);
box on 
hold on
plot(xs, cp, 'r');
set(gca, 'Ydir', 'reverse')
xlabel('x/c');
ylabel('c_p');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 'r');
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 'r');


legend('LLH04','Location','north')
set(gcf,'units', 'centimeters','position',[0,0,8,5])
saveas(gcf,'week3/Figures/cp_LLH04_low','epsc2')


