% Script 6
% Combined laminar and turbulent boundary layer evolution

clear;
close all;

global Re_L ue0 due_dx

Res = [1e5];

% Velocity gradient
due_dx = -0.125;

% Panel count
n = 100;

% Set up matrices for collecting full results
thetas_full = zeros(length(Res), n+1);
He_full = zeros(length(Res), n+1);

for k=1:length(Res)
    % Set the Reynolds number
    Re_L = Res(k);
    
    laminar = true;
    
    % Dimensionless x/L and ue/U
    x = linspace(0,1,n + 1);
    ue = ones(size(x)) + due_dx .* x;
    
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
            laminar = false;
            int = i;
        elseif m >= 0.09
            laminar = false;
            ils = i;
            % Set He explicitly to laminar separation value
            He(i) = 1.51509;
        end
    
    end
    
    delta_e = He(i) * thetas(i);
    
    thick0 = zeros(2,1);
    
    % Set the initial values
    thick0(1) = thetas(i);
    thick0(2) = delta_e;
    
    % Enter turbulent loop
    while its == 0 && i <= n
        i = i + 1;
        % Set global variables
        ue0 = ue(i-1);
        % due_dx doesn't need updating as constant; would need updating for
        % full panel method
    
        % Solve the differential equation
        [delx, thickhist] = ode45(@thickdash, [0,x(i)-x(i-1)], thick0);
        
        % Update with theta and delta_e at end of panel
        thick0 = thickhist(end,:);
        thetas(i) = thickhist(end,1);
        He(i) = thick0(end,1) / thick0(end,2);
        
        % Test for turbulent reattachment
        if He(i) > 1.58
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
    
        for j=i:n
            % Momentum integral solution assuming constant H
            thetas(j+1) = thetas(j) * (ue(j+1) / ue(j)) ^ (H + 2);
        end
    end
    
    % Record results
    thetas_full(k, :) = thetas;
    He_full(k, :) = He;

    fprintf("Re_L = %.2e\n", Re_L)
    
    if int ~= 0
        disp(['Natural transition at ' num2str(x(int)) ...
            ' with Rethet ' num2str(Rethet)])
    end
    
    if ils ~= 0
        disp(['Laminar separation at ' num2str(x(ils)) ...
            ' with Rethet ' num2str(Rethet)])
    end
    
    
    if itr ~= 0
        disp(['Turbulent reattachment at ' num2str(x(itr)) ...
            ' with Rethet ' num2str(Rethet)])
    end
    
    if its ~= 0
        disp(['Turbulent separation at ' num2str(x(its)) ...
            ' with Rethet ' num2str(Rethet)])
    end
end

% Plot theta/L
for k=1:length(Res)
    hold on
    plot(x, thetas_full(k, :))
    hold off
end
%title("Momentum thickness variation with x")
xlabel("x/L")
ylabel("\theta/L")

% legend('Thwaites solution','Blasius solution')

% Plot He
figure(2);
for k=1:length(Res)
    hold on
    plot(x, He_full(k, :))
    hold off
end
%title("Energy shape factor variation with x")
xlabel("x/L")
ylabel("H_E")






