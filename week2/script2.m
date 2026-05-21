% Script 1
% Constant velocity gradient laminar boundary layer with test for
% transition

clear;
close all;


% Set the Reynolds number
Re_L = 5e6;

% Velocity gradient
due_dx = -0.1;

% Panel count
n = 100;
laminar = true;

% Dimensionless x/L and ue/U
x = linspace(0,1,n + 1);
ue = ones(size(x)) + due_dx .* x;
% True for zero pressure gradient

% Blasius solution
thetas_blas = 0.664 / Re_L^(1/2) .* x.^(1/2);

% Dimensionless theta/L
thetas = zeros(size(x));
ueint = 0;

i = 1;
while laminar && i < n
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
        disp([x(i) Rethet/1000])
    end
    
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

print -deps2c -loose week2/Figures/script2.eps



