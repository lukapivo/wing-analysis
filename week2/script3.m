% Script 3
% Constant velocity gradient laminar boundary layer with test for
% transition or separation

clear;
close all;

% Set the Reynolds number
Re_L = 8.9e5;

% Velocity gradient
due_dx = -0.25;

% Panel count
n = 100;

% Initialise utility variables
laminar = true;
ueint = 0;
i = 1;

% Dimensionless x/L, ue/U, theta/L
x = linspace(0,1,n + 1);
ue = ones(size(x)) + due_dx .* x;
thetas = zeros(size(x));

% Transition location
int = 0;
% Laminar separation location
ils = 0;

while laminar && i <= n
    i = i + 1;

    ueint = ueint + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    theta_sq = 0.45 / Re_L * (ue(i))^(-6) * ueint;
    thetas(i) = sqrt(theta_sq);

    % Test for transition
    m = - Re_L * theta_sq * due_dx;
    H = thwaites_lookup(m);
    He = laminar_He(H);
    Rethet = Re_L * ue(i) * thetas(i);

    if log(Rethet) >= 18.4*He - 21.74
        int = i;
        laminar = false;
    elseif m >= 0.09
        laminar = false;
        ils = i;
    end

end

if int ~= 0
    disp(['Natural transition at ' num2str(x(int)) ...
        ' with Rethet ' num2str(Rethet)])
end

if ils ~= 0
    disp(['Laminar separation at ' num2str(x(ils)) ...
        ' with Rethet ' num2str(Rethet)])
end