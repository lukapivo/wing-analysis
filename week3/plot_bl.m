clear
close all

caseref = "Data/LLL06b_2.5.mat";
load(caseref);

function [] = plot_points(int, ils, itr, its, ax1, x, thetas, color)
    order = colororder;
    C = order(color, :);

    xl1 = xlim(ax1);
    yl1 = ylim(ax1);

    dx1 = (xl1(2) - xl1(1)) * 0.01;
    dy1 = (yl1(2) - yl1(1)) * 0.01;

    if int ~= 0
        disp(['Natural transition at ' num2str(x(int))])
        plot(ax1, x(int), thetas(int), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        text(ax1, x(int)-2*dx1, thetas(int)+2*dy1, "Natural Transition", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
        % plot(ax2, x(int), He(int), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        % text(ax2, x(int)-2*dx2, He(int)+2*dy2, "Natural Transition", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    end
    
    if ils ~= 0
        disp(['Laminar separation at ' num2str(x(ils))])
        plot(ax1, x(ils), thetas(ils), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        text(ax1, x(ils)-2*dx1, thetas(ils)+2*dy1, "Laminar Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
        % plot(ax2, x(ils), He(ils), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        % text(ax2, x(ils)+dx2, He(ils), "Laminar Separation", "FontSize", 10, "Color", C)
    end
    
    if itr ~= 0
        disp(['Turbulent reattachment at ' num2str(x(itr))])
        plot(ax1, x(itr), thetas(itr), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        text(ax1, x(itr)+dx1, thetas(itr)-2*dy1, "Turbulent Reattachment", "FontSize", 10, "Color", C)
        % plot(ax2, x(itr), He(itr), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        % text(ax2, x(itr)+dx2, He(itr), "Turbulent Reattachment", "FontSize", 10, "Color", C)
    end
    
    if its ~= 0
        disp(['Turbulent separation at ' num2str(x(its))])
        plot(ax1, x(its), thetas(its), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        text(ax1, x(its)-2*dx1, thetas(its)+2*dy1, "Turbulent Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
        % plot(ax2, x(its), He(its), ".", "MarkerSize",10, "Color", C,'HandleVisibility','off')
        % text(ax2, x(its)-2*dx2, He(its), "Turbulent Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    end
end

hold on
plot(sl, thetal);
plot(su, thetau);
% legend("Lower", "Upper");
xlabel('s');
ylabel('\theta');
ax_theta = gca;
plot_points(ilnt, ills, iltr, ilts, ax_theta, sl, thetal, 1);
plot_points(iunt, iuls, iutr, iuts, ax_theta, su, thetau, 2);


figure(2);

hold on
plot(sl, delstarl);
plot(su, delstaru);
% legend("Lower", "Upper");
xlabel('s');
ylabel('\delta*');
ax_delstar = gca;
plot_points(ilnt, ills, iltr, ilts, ax_delstar, sl, delstarl, 1);
plot_points(iunt, iuls, iutr, iuts, ax_delstar, su, delstaru, 2);


figure(3);

hold on
plot(sl, delstarl./thetal);
plot(su, delstaru./thetau);
% legend("Lower", "Upper");
xlabel('s');
ylabel('H');
ax_h = gca;
plot_points(ilnt, ills, iltr, ilts, ax_h, sl, delstarl./thetal, 1);
plot_points(iunt, iuls, iutr, iuts, ax_h, su, delstaru./thetau, 2);

figure(4);

hold on
plot(xs, cp);
set(gca, 'Ydir', 'reverse')
xlabel('s');
ylabel('cp');

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

ax_cp = gca;

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 1);
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 1);

figure(5);

ue = sqrt(1-cpu);
mu = - 500000 * thetau.^2 .* [ue(1)/su(1) diff(ue)./diff(su)];

mu_stop = max([iunt iuls]);

hold on
plot(su(1:mu_stop), mu(1:mu_stop));
xlabel('s');
ylabel('m');
ax_m = gca;
% plot_points(iunt, iuls, iutr, iuts, ax_m, su, mu, 1);





% %Load 6 
caseref = "Data/LLL08_2.3.mat";
load(caseref);

figure(1);

plot(sl, thetal, 'LineStyle', '--');
plot(su, thetau, 'LineStyle','--');
legend("Lower 1", "Upper 1", "Lower 2", "Upper 2");
% plot_points(ilnt, ills, iltr, ilts, ax_theta, sl, thetal, 1);
plot_points(iunt, iuls, iutr, iuts, ax_theta, su, thetau, 2);

figure(2);

plot(sl, delstarl, 'LineStyle', '--');
plot(su, delstaru, 'LineStyle', '--');

% plot_points(ilnt, ills, iltr, ilts, ax_delstar, sl, delstarl, 1);
plot_points(iunt, iuls, iutr, iuts, ax_delstar, su, delstaru, 2);
legend("Lower 1", "Upper 1", "Lower 2", "Upper 2");

figure(3);

plot(sl, delstarl./thetal, 'LineStyle', '--');
plot(su, delstaru./thetau, 'LineStyle', '--');
% plot_points(ilnt, ills, iltr, ilts, ax_h, sl, delstarl./thetal, 1);
plot_points(iunt, iuls, iutr, iuts, ax_h, su, delstaru./thetau, 2);
legend("Lower 1", "Upper 1", "Lower 2", "Upper 2");

figure(4);

plot(xs, cp);

xsu = flip(xs(1:length(su)));
cpu = flip(cp(1:length(su)));
xsl = xs(length(su)+1:end);
cpl = cp(length(su)+1:end);

plot_points(ilnt, ills, iltr, ilts, ax_cp, xsl, cpl, 2);
plot_points(iunt, iuls, iutr, iuts, ax_cp, xsu, cpu, 2);



legend('1', '2');

figure(5);

ue = sqrt(1-cpu);
mu = - 500000 * thetau.^2 .* [ue(1)/su(1) diff(ue)./diff(su)];

mu_stop = max([iunt iuls]);
plot(su(1:mu_stop), mu(1:mu_stop));
legend('1', '2')