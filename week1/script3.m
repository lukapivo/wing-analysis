% Script 3
% Plots the influence coefficient contours for a linear vortex sheet at general position.

clear;
close all;

%%% Set parameters
% X-limits
xmin = 0;
xmax = 5;
nx = 51;

% Y-limits
ymin = 0;
ymax = 4;
ny = 41;

% Sheet end positions
xa = 3.5;
ya = 2.5;

xb = 1.6;
yb = 1.1;

% Approximate vortex count
nv = 100;

% Generate mesh grid
xg = linspace(xmin, xmax, nx);
yg = linspace(ymin, ymax, ny);

[xm, ym] = meshgrid(xg, yg);

infa_est = zeros(size(xm));
infb_est = zeros(size(xm));

% Compute influence coefficients
[infa, infb] = panelinf(xa, ya, xb, yb, xm, ym);

%%% Compute approximate influence coefficients
% Calculate panel length for spacing.
tl = [xb-xa yb-ya];
del = norm(tl);
t = tl / del;


% Need L for influence coefficients as determines Gamma for each point
L = linspace(del/(2*nv), del * (1 - 1/(2*nv)), nv);

% Get actual positions of point vortices by marching in direction of t.
x = xa + L*t(1);
y = ya + L*t(2);


% Influence coefficients determined from:
% gamma_k = gamma_a * (1 - l/del) + gamma_b * (l/del)
% Gamma_k = gamma_k * del/nv
% fa = del/nv (1 - l/del)(-log(r^2)/4pi), etc for fb
% Therefore use Gamma = del/nv with psipv to return -del/nv log(r^2)/4pi
for i=1:nv
    psi = psipv(x(i), y(i), del/nv, xm, ym);
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