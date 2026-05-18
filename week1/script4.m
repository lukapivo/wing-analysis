% Script 3
% Plots the streamlines of flow past a unit radius cylinder.

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

% Define vortex sheet strength
gamma = -2 * sin(theta);

% Streamfunction contributions
psi = ym; % Free stream

for i=1:np

    % Compute influence coefficients
    if i + 1 > np
        ib = mod(i+1, np);
    else
        ib = i+1;
    end
    
    [infa, infb] = panelinf(xs(i), ys(i), xs(ib), ys(ib), xm, ym);

    psi = psi + gamma(i) * infa + gamma(ib) * infb;

end

%%% Plot contours
c = -1.75:0.25:1.75;

% psi
contour(xm,ym,psi,c)
title("Streamfunction")
axis equal
xlabel("x")
ylabel("y")

hold on
plot(xs,ys)
hold off