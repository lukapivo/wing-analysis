% Script 4
% Zero-pressure-gradient turbulent boundary layer

clear;
close all;

global Re_L ue0 duedx

% Set the Reynolds number
Re_L = 1e7;

% Velocity gradient
duedx = 0;

% Starting velocity
ue0 = 1;

% Set the initial values
x0 = 0.01;
thick0 = zeros(2,1);
thick0(1) = 0.023 * x0 * (Re_L*x0) .^ (-1/6);
thick0(2) = 1.83 * thick0(1);

% Solve the differential equation
[delx, thickhist] = ode45(@thickdash, [0 0.99], thick0);

theta = thickhist(:,1);

% delx = x - x0
x = x0 + delx;

% Generate comparison values
theta7 = 0.037 * x .* (Re_L * x).^(-1/5);
theta9 = 0.023 * x .* (Re_L * x).^(-1/6);

% Plot
set(gcf,'units', 'centimeters','position',[0,0,16,10])
plot(x, theta)
%title("Momentum thickness from ODE plotted with power law estimates)
xlabel("x/L")
ylabel("\theta/L")

hold on
plot(x,theta7)
plot(x,theta9)
hold off

legend("Numerical solution", "1/7^{th} power law", "1/9^{th} power law", "Location","northwest")

saveas(gcf,'week2/figures/script4','epsc')

