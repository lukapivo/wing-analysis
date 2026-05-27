% Script 6
% Combined laminar and turbulent boundary layer evolution

clear;
close all;

global Re_L ue0 due_dx

% Res = [1e6 1e7];
Res = [1e4 1e5 1e6];
% Res = 1e5;

% Velocity gradient
due_dx = -0.25;

% Panel count
n = 1000;

% Set up matrices for collecting full results
thetas_full = zeros(length(Res), n+1);
He_full = zeros(length(Res), n+1);

% Set up plotting axes
ax1 = gca;
fig1 = gcf;
set(gcf,'units', 'centimeters','position',[0,0,16,10])
hold on
figure(2);
set(gcf,'units', 'centimeters','position',[0,0,16,10])
hold on
ax2 = gca;
fig2 = gcf;

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
        He(i) = thick0(end,2) / thick0(end,1);
        
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
    
        for j=i:n
            % Momentum integral solution assuming constant H
            thetas(j+1) = thetas(j) * (ue(j) / ue(j+1)) ^ (H + 2);
        end
    end

    % Get current colour
    order = colororder;
    C = order(k, :);
    
    % Plot lines
    plot(ax1, x, thetas, "Color", C)
    plot(ax2, x, He, "Color", C)

    % Get reasonable offsets for text
    xl1 = xlim(ax1);
    yl1 = ylim(ax1);
    xl2 = xlim(ax2);
    yl2 = ylim(ax2);

    dx1 = (xl1(2) - xl1(1)) * 0.01;
    dy1 = (yl1(2) - yl1(1)) * 0.01;
    dx2 = (xl2(2) - xl2(1)) * 0.01;
    dy2 = (yl2(2) - yl2(1)) * 0.01;


    fprintf("Re_L = %.2e\n", Re_L)
    
    if int ~= 0
        disp(['Natural transition at ' num2str(x(int)) ...
            ' with Rethet ' num2str(Rethet)])
        plot(ax1, x(int), thetas(int), ".", "MarkerSize",10, "Color", C)
        text(ax1, x(int)-dx1, thetas(int)+2*dy1, "Natural Transition", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
        plot(ax2, x(int), He(int), ".", "MarkerSize",10, "Color", C)
        text(ax2, x(int)-dx2, He(int)+2*dy2, "Natural Transition", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    end
    
    if ils ~= 0
        disp(['Laminar separation at ' num2str(x(ils)) ...
            ' with Rethet ' num2str(Rethet)])
        plot(ax1, x(ils), thetas(ils), ".", "MarkerSize",10, "Color", C)
        text(ax1, x(ils)-0.01, thetas(ils)+0.0003, "Laminar Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
        plot(ax2, x(ils), He(ils), ".", "MarkerSize",10, "Color", C)
        text(ax2, x(ils)+0.01, He(ils), "Laminar Separation", "FontSize", 10, "Color", C)
    end
    
    
    if itr ~= 0
        disp(['Turbulent reattachment at ' num2str(x(itr)) ...
            ' with Rethet ' num2str(Rethet)])
        plot(ax1, x(itr), thetas(itr), ".", "MarkerSize",10, "Color", C)
        text(ax1, x(itr)+0.005, thetas(itr)-0.0003, "Turbulent Reattachment", "FontSize", 10, "Color", C)
        plot(ax2, x(itr), He(itr), ".", "MarkerSize",10, "Color", C)
        text(ax2, x(itr)+0.01, He(itr), "Turbulent Reattachment", "FontSize", 10, "Color", C)
    end
    
    if its ~= 0
        disp(['Turbulent separation at ' num2str(x(its)) ...
            ' with Rethet ' num2str(Rethet)])
        plot(ax1, x(its), thetas(its), ".", "MarkerSize",10, "Color", C)
        text(ax1, x(its)-0.01, thetas(its)+0.0003, "Turbulent Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
        plot(ax2, x(its), He(its), ".", "MarkerSize",10, "Color", C)
        text(ax2, x(its)-0.01, He(its), "Turbulent Separation", "FontSize", 10, "Color", C, "HorizontalAlignment", "Right")
    end
end



% Plot theta/L
%title("Momentum thickness variation with x")
xlabel(ax1, "x/L")
ylabel(ax1, "\theta/L")
saveas(fig1,'week2/figures/script6_theta2','epsc')

% legend('Thwaites solution','Blasius solution')

% Plot He
%title("Energy shape factor variation with x")
xlabel(ax2, "x/L")
ylabel(ax2, "H_E")
saveas(fig1,'week2/figures/script6_he2','epsc')






