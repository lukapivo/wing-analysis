% Script 5
% Constant-velocity-gradient turbulent boundary layer

clear;
close all;

global Re_L ue0 due_dx

test_cases = [-0.25 1e7; -0.5 1e7; -0.95 1e7; -0.5 1e6; -0.5 1e8];

for i = 1:height(test_cases)

    % Velocity gradient
    due_dx = test_cases(i,1);
    
    % Set the Reynolds number
    Re_L = test_cases(i,2);
    
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
    
    % Locates index of first He <= 1.46
    sep = find(He<= 1.46, 1);
    
    if ~isempty(sep)
        % Prints the x location of separation
        fprintf("Re_L = %.1e, duedx = %.2f, separation location = %f \n",Re_L, due_dx, x(sep));
    else
        fprintf("Re_L = %.1e, duedx = %.2f, no separation in this interval \n",Re_L, due_dx);
    end

    if Re_L == 1e7 && due_dx == -0.5
        set(gcf,'units', 'centimeters','position',[0,0,16,10])
        % Plot x/L and theta/L for due_dx = -0.50, Re_L = 1e7
        plot(x, theta)
        %title("Momentum thickness from ODE plotted with power law estimates)
        xlabel("x/L")
        ylabel("\theta/L")

        hold on
        plot(x,delta_e)
        hold off

        legend("\theta", "\delta_E")

        saveas(gcf,'week2/figures/script5','epsc')

    end

end

