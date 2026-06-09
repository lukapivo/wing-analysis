clear
close all

% Seed
caseref = "Data/LLL08b_3.2.mat";
load(caseref);

alpha_d = 3.2; % deg
alpha = deg2rad(alpha_d);

% Convert to v/vinf
v1 = [sqrt(1-cp(1:length(su))), sqrt(1-cp(length(su)+1:end))];

% Put onto circle
phi1 = [acos(2*xs(1:length(su)-2)-1), 2*pi-acos(2*xs(length(su)-1:end)-1)];
phi1
% Resample
N = 400;
phi = linspace(0, 2*pi, 2*N+1);
v = interp1(phi1, v1, phi);

P = - log(abs(v) ./ (2*abs(cos(phi/2)-alpha)));
P2 = zeros(size(P));

Q = zeros(size(phi));

for n = 0:(2*N-1)
    Qn = 0;
    for i = 0:N-1
        P1 = mod(n+1+2*i, 2*N);
        P2 = mod(n-1-2*n,2*N);
        
        Qn = Qn + (P(P1+1)-P(P2+1))*cot((2*i+1)*pi/(2*N));
    end
    Q(n+1) = 1/(2*N) * Qn;
end



dx_dphi = -4 * sin(phi/2) .* abs(cos(phi/2 - alpha)) .*(1./abs(v)).*cos(phi/2 +Q);
dy_dphi = -4 * sin(phi/2) .* abs(cos(phi/2 - alpha)) .*(1./abs(v)).*sin(phi/2 +Q);

xs2 = 1+cumtrapz(phi, dx_dphi);
ys2 = cumtrapz(phi, dy_dphi);

plot(phi, v)

figure(2);
plot(phi, P, phi, P2, '--')

figure(3);
plot(phi, abs(Q))

figure(4);
plot(phi,dx_dphi);

figure(5);
plot(phi,dy_dphi);

figure(6);
plot(xs2, ys2);