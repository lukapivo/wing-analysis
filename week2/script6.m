% Script 6
% Combined laminar and turbulent boundary layer evolution

clear;
close all;


% Set the Reynolds number
Re_L = 0.9e6;

% Velocity gradient
due_dx = -0.25;

% Panel count
n = 100;
laminar = true;

% Dimensionless x/L and ue/U
x = linspace(0,1,n + 1);
ue = ones(size(x)) + due_dx .* x;

% Blasius solution
thetas_blas = 0.664 / Re_L^(1/2) .* x.^(1/2);

% Dimensionless theta/L
thetas = zeros(size(x));
ueint = 0;

% Initialise arrays
He = zeros(size(x));

% Transition location
int = 0;
% Laminar separation location
ils = 0;
% Turbulent reattachment location
itr = 0;
% Turbulent separation location
its = 0;

i = 1;
He(i) = 1.57258;
while laminar && i <= n
    i = i + 1;

    ueint = ueint + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    theta_sq = 0.45 / Re_L * (ue(i))^(-6) * ueint;
    thetas(i) = sqrt(theta_sq);

    % Test for transition
    m = - Re_L * theta_sq * due_dx;
    H = thwaites_lookup(m);
    He(i) = laminar_He(H);
    Rethet = Re_L * ue(i) * thetas(i);

    if log(Rethet) >= 18.4*He(i) - 21.74
        int = i;
        laminar = false;
    elseif m >= 0.09
        laminar = false;
        ils = i;
        % Set He explicitly to laminar separation value
        He(i) = 1.51509;
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

delta_e = He(i) * thetas(i);

thick0 = zeros(2,1);

% Set the initial values
thick0(1) = thetas(i);
thick0(2) = delta_e;

% Solve the differential equation

[delx, thickhist] = ode45(@thickdash, [0 0.99], thick0);

% Enters turbulent loop
while its == 0 && i <= n
    i = i + 1;



end


if itr ~= 0
    disp(['Turbulent reattachment at ' num2str(x(itr)) ...
        ' with Rethet ' num2str(Rethet)])
end

if its ~= 0
    disp(['Turbulent separation at ' num2str(x(its)) ...
        ' with Rethet ' num2str(Rethet)])
end


% Plot
plot(x, thetas)
%title("Momentum thickness variation with x")
xlabel("x/L")
ylabel("\theta/L")

hold on
plot(x,thetas_blas, "--")
hold off

legend('Thwaites solution','Blasius solution')




