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
% infa = zeros(size(xm));
% infb = zeros(size(xm));

infa_est = zeros(size(xm));
infb_est = zeros(size(xm));

% for i=1:ny
%     for j=1:nx
%         [infa(i,j), infb(i,j)] = refpaninf(del, xm(i,j), ym(i,j));
%     end
% end

[infa, infb] = refpaninf(del, xm, ym);

c = -0.15:0.05:0.15;
contour(xm,ym,infa,c)

figure(2);
contour(xm,ym,infb,c)

figure(3);
contour(xm,ym,infa+infb,c)