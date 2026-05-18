% Script 5
% Panel method solution for the cylinder flow

clear;
close all;

%%% Set parameters
% X-limits
xmin = -2.5;
xmax = 2.5;
nx = 51;

% Y-limits
ymin = -2;
ymax = 2;
ny = 41;

% Panel count
np = 100;

% Generate mesh grid
xg = linspace(xmin, xmax, nx);
yg = linspace(ymin, ymax, ny);

[xm, ym] = meshgrid(xg, yg);

% Generate panel edges
theta = (0:np)*2*pi/np;
xs = cos(theta);
ys = sin(theta);

alpha = pi/24;

% Find vortex sheet strengths for both incidences
A = build_lhs(xs,ys);
b1 = build_rhs(xs,ys,0);
b2 = build_rhs(xs,ys,alpha);

gamma1 = A\b1; 
gamma2 = A\b2;

% Streamfunction contributions
psi1 = ym; % Free stream
psi2 = ym*cos(alpha) - xm*sin(alpha); % Free stream at incidence

for i=1:np
    % Compute influence coefficients
    [infa, infb] = panelinf(xs(i), ys(i), xs(i+1), ys(i+1), xm, ym);

    psi1 = psi1 + gamma1(i) * infa + gamma1(i+1) * infb;
    psi2 = psi2 + gamma2(i) * infa + gamma2(i+1) * infb;

end

% Calculate total circulation

Gamma1 = sum(gamma1) * 2 * pi / np;
Gamma1
Gamma2 = sum(gamma2) * 2 * pi / np;
Gamma2

%%% Plot contours
c = -1.75:0.25:1.75;

% psi at zero incidence
contour(xm,ym,psi1,c)
title("Streamfunction at zero incidence")
axis equal
xlabel("x")
ylabel("y")

hold on
plot(xs,ys)
hold off

% psi at incidence

figure(2);
contour(xm,ym,psi2,c)
title(compose("Streamfunction at alpha = %.1f degrees", alpha*180/pi))
axis equal
xlabel("x")
ylabel("y")

hold on
plot(xs,ys)
hold off

% Velocity plots

figure(3);
plot(theta/pi, gamma1)
title("Velocity plot for zero incidence")
xlabel("\theta/\pi")
ylabel("Velocity")

figure(4);
plot(theta/pi, gamma2)
title(compose("Velocity plot for alpha = %.1f degrees", alpha*180/pi))
xlabel("\theta/\pi")
ylabel("Velocity")