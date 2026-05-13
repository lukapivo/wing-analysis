% Script 1
% Plots the influence coefficient contours for a linear vortex sheet.

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

% Sheet length
del = 1.5;

% Generate mesh grid
xs = linspace(xmin, xmax, nx);
ys = linspace(ymin, ymax, ny);

[xm, ym] = meshgrid(xs, ys);

infa_est = zeros(size(xm));
infb_est = zeros(size(xm));

% Compute influence coefficients
[infa, infb] = refpaninf(del, xm, ym);

%%% Plot contours
c = -0.15:0.05:0.15;

% infa
contour(xm,ym,infa,c)

% infb
figure(2);
contour(xm,ym,infb,c)

% infa + infb
figure(3);
contour(xm,ym,infa+infb,c)