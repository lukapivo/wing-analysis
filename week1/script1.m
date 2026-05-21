% Script 1
% Plots the streamfunction contours for a point vortex.

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

% Vortex position
xc = 0.50;
yc = 0.25;

% Circulation
Gamma = 3.0;

% Generate mesh grid
xg = linspace(xmin, xmax, nx);
yg = linspace(ymin, ymax, ny);

[xm, ym] = meshgrid(xg, yg);

% Calculate streamfunction over meshgrid
psi = psipv(xc, yc, Gamma, xm, ym);

% Plot contour
c = -0.4:0.2:1.2;
contour(xm,ym,psi,c)
%title("\psi")
xlabel("x")
ylabel("y")

print -deps2c -loose week1/Figures/script1.eps