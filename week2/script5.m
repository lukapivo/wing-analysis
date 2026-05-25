% Script 5
% Constant-velocity-gradient turbulent boundary layer

clear;
close all;

global Re_L ue0 duedx

% Set the Reynolds number
Re_L = 1e7;

% Velocity gradient
duedx = -0.25;

% Starting velocity
ue0 = 1;

thick0 = zeros(2,1);

% Set the initial values
x0 = 0.01;
thick0(1) = 0.023 * x0 * (Re_L*x0) .^ (-1/6);
thick0(2) = 1.83 * thick0(1);

% Solve the differential equation

[delx, thickhist] = ode45(@thickdash, [0 0.99], thick0);

% delx = x - x0
x = x0 + delx;

theta = thickhist(:,1);
delta_e = thickhist(:,2);

He = delta_e ./ theta;

% Locates index of first He >= 1.46
sep = find(He>= 1.46, 1);

if ~isempty(sep)
    % Prints the x location of separation
    x(sep);
else
    disp("No separation in this interval")
end

% Plot x/L and theta/L for duedx = -0.50, Re_L = 1e7
plot(x, theta)
%title("Momentum thickness from ODE plotted with power law estimates)
xlabel("x/L")
ylabel("\theta/L")

hold on
plot(x,delta_e)
hold off

legend("\theta", "\delta_E")

print -deps2c -loose week2/Figures/script5.eps

