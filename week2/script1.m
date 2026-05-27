% Script 1
% Zero pressure gradient laminar boundary layer

clear;
close all;

% Set the Reynolds number
Re_L = 1000;

% Panel count
n = 100;

% Dimensionless x/L, ue/U, theta/L
x = linspace(0,1,n + 1);
ue = ones(size(x)); % True for zero pressure gradient
thetas = zeros(size(x));

% Blasius solution
thetas_blas = 0.664 / Re_L^(1/2) .* x.^(1/2);

ueint = 0;
for i=2:(n+1)
    ueint = ueint + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    theta_sq = 0.45 / Re_L * (ue(i))^(-6) * ueint;
    thetas(i) = sqrt(theta_sq);
end

% Momentum thickness plot
set(gcf,'units', 'centimeters','position',[0,0,16,10])
plot(x, thetas)
%title("Momentum thickness variation with x")
xlabel("x/L")
ylabel("\theta/L")

hold on
plot(x,thetas_blas, "--")
hold off

legend('Thwaites solution','Blasius solution')

saveas(gcf,'week2/figures/script1','epsc')