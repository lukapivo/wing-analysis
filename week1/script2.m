% Script 2
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
L = linspace(del/(2*nv), del * (1 - 1/(2*nv)), nv);

% Influence coefficients determined from:
% gamma_k = gamma_a * (1 - l/del) + gamma_b * (l/del)
% Gamma_k = gamma_k * del/nv
% fa = del/nv (1 - l/del)(-log(r^2)/4pi), etc for fb
% Therefore use Gamma = del/nv with psipv to return -del/nv log(r^2)/4pi
for i=1:nv
    psi = psipv(L(i), 0, del/nv, xm, ym);
    infa_est = infa_est + psi * (1 - L(i)/del);
    infb_est = infb_est + psi * L(i)/del;
end


%%% Plot contours
c = -0.15:0.05:0.15;

% infa
contour(xm,ym,infa,c)
title("Analytical f_a")
xlabel("x")
ylabel("y")

% infb
figure(2);
contour(xm,ym,infb,c)
title("Analytical f_b")
xlabel("x")
ylabel("y")

% Approximate infa
figure(3);
contour(xm,ym,infa_est,c)
title("Discretised f_a")
xlabel("x")
ylabel("y")

% Approximate infb
figure(4);
contour(xm,ym,infb_est,c)
title("Discretised f_b")
xlabel("x")
ylabel("y")