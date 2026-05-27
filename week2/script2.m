% Script 2
% Constant velocity gradient laminar boundary layer with test for
% transition

clear;
close all;

Res = [5e6 1e7 2e7];
due_dxs = [-0.1 0 0.1];

for j = 1:length(Res)

    for k = 1:length(due_dxs)

        % Set the Reynolds number
        Re_L = Res(j);
        
        % Velocity gradient
        due_dx = due_dxs(k);
        
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
                laminar = false;
                fprintf("Re_L = %.1e, duedx = %.2f, transition location = %f, Rethet = %e \n",Re_L, due_dx, x(i), Rethet);
            end
            
        end
        if laminar == true
            fprintf("Re_L = %.1e, duedx = %.2f, no transition, Rethet = %e \n",Re_L, due_dx, Rethet);
        end
    end

end