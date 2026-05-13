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

% Approximate vortex count
nv = 100;

% Generate mesh grid
xs = linspace(xmin, xmax, nx);
ys = linspace(ymin, ymax, ny);

[xm, ym] = meshgrid(xs, ys);

infa_est = zeros(size(xm));
infb_est = zeros(size(xm));

% Compute influence coefficients
[infa, infb] = refpaninf(del, xm, ym);

%%% Compute approximate influence coefficients
X = linspace(del/(2*nv), del * (1 - 1/(2*nv)), nv);

% Influence coefficients determined from:
% gamma_k = gamma_a * (1 - x/del) + gamma_b * (x/del)
% Gamma_k = gamma_k * del/nv
for i=1:nv
    psi = psipv(X(i), 0, del/nv, xm, ym);
    infa_est = infa_est + psi * (1 - X(i)/del);
    infb_est = infb_est + psi * X(i)/del;
end


%%% Plot contours
c = -0.15:0.05:0.15;

% infa
contour(xm,ym,infa,c)

% infb
figure(2);
contour(xm,ym,infb,c)

% Approximate infa
figure(3);
contour(xm,ym,infa_est,c)

% Approximate infb
figure(4);
contour(xm,ym,infb_est,c)