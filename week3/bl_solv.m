function [int, ils, itr, its, delstar, theta] = bl_solv(x,cp)
% BL_SOLV solve the boundary layer for an airfoil.

global Re_L ue0 due_dx

% Panel count
n = length(x);
    
% Initialise utility variables
laminar = true;
i = 0;

% Dimensionless ue/U, theta/L
ue = sqrt(1-cp);
theta = zeros(size(x));
delstar = zeros(size(x));

% Differentiate ue and correct first
due_dxs = zeros(size(x));
due_dxs(1) = ue(1)/x(1);
due_dxs(2:n) = diff(ue)./diff(x);

% Initialise energy thickness
He = zeros(size(x));

% Natural transition location
int = 0;
% Laminar separation location
ils = 0;
% Turbulent reattachment location
itr = 0;
% Turbulent separation location
its = 0;

while laminar && i <= n
    i = i + 1;

    if i == 1
        ueint = ueintbit(0,0,x(i),ue(i));
    else
        ueint = ueint + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    end

    theta_sq = 0.45 / Re_L * (ue(i))^(-6) * ueint;
    theta(i) = sqrt(theta_sq);

    % Test for transition
    m = - Re_L * theta_sq * due_dxs(i);
    H = thwaites_lookup(m);
    He(i) = laminar_He(H);
    Rethet = Re_L * ue(i) * theta(i);
    
    % Save delstar
    delstar(i) = H * theta(i);
    
    if log(Rethet) >= 18.4*He(i) - 21.74
        laminar = false;
        int = i;
    elseif m >= 0.09
        laminar = false;
        ils = i;
        % Set He explicitly to laminar separation value
        He(i) = 1.51509;
    end
end

delta_e = He(i) * theta(i);

% Set initial values
thick0 = zeros(2,1);

thick0(1) = theta(i);
thick0(2) = delta_e;

% Enter turbulent loop
while its == 0 && i < n
    i = i + 1;
    % Set global variables
    ue0 = ue(i-1);
    due_dx = due_dxs(i);

    % Solve the differential equation
    [delx, thickhist] = ode45(@thickdash, [0,x(i)-x(i-1)], thick0);
    
    % Update with theta and delta_e at end of panel
    thick0 = thickhist(end,:);
    theta(i) = thickhist(end,1);
    He(i) = thick0(end,2) / thick0(end,1);
    
    delstar(i) = theta(i) * (11*He(i)+15) / (48*He(i)-59);

    
    % Test for turbulent reattachment
    if He(i) > 1.58 && ils ~= 0 && itr == 0 
        itr = i;
    end
    
    % Test for turbulent separation
    if He(i) < 1.46
        its = i;
    end
end

% Complete thetas if turbulent separation occurred
if its ~= 0
    % Assume constant shape factors after separation
    H = 2.803;
    He(i+1:end) = He(i);

    for j=i:n-1
        % Momentum integral solution assuming constant H
        theta(j+1) = theta(j) * (ue(j) / ue(j+1)) ^ (H + 2);
    end

    delstar(i+1:n) = H * theta(i+1:n);
end

end