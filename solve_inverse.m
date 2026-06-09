clear
close all



nc = 257; % Points to use, must be 2^n+1
mc = idivide(int32(nc), 4, 'floor');
mct = idivide(int32(nc),16,'floor');
wc = linspace(0,2*pi,nc); % Evenly distributed phi points
dwc = 2*pi/(nc-1);

%%%% Originally EIWSET function
eiw = zeros(nc,mc+1);

for i = 1:nc
    eiw(i, 1) = 1;
    eiw(i, 2) = exp(wc(i)*1j);
end

for i = 1:nc
    for m = 3:mc+1
        i1 = mod((m-1)*(i-1),nc-1)+1;
        eiw(i,m) = eiw(i1,2);
    end
end


% Slow Fourier Transform (check if fast will do)
function [cn] = ftp(nc, mc, eiw, dwc, P)
    cn = zeros(mc+1);
    for m=1:mc+1
        zsum = 0+0j;
        for i=2:nc-1
            zsum = zsum + P(i)*eiw(i,m);
        end
        cn(m) = (0.5*(P(1)*eiw(1,m) + P(nc)*eiw(nc,m)) +zsum)*dwc/pi;
    end
    cn(1) = 0.5 * cn(1);
end

% Inverse-transform to get P and Q
function [piq] = piqsum(nc, mc, eiw, cn)
    piq = zeros(nc);
    for i=1:nc
        zsum = 0 + 0j;
        for m = 1:mc+1
            zsum = zsum +cn(m)*conj(eiw(i,m));
        end
        piq(i) = zsum;
    end
end

% Seed
caseref = "Data/LLL08b_3.2.mat";
load(caseref);

alpha_d = 3.2; % deg
alpha = deg2rad(alpha_d);

% Convert to v/vinf
v1 = [sqrt(1-cp(1:length(su))), sqrt(1-cp(length(su)+1:end))];

% Put onto circle
phi1 = [acos(2*xs(1:length(su)-2)-1), 2*pi-acos(2*xs(length(su)-1:end)-1)];

% Resample
N = nc;
phi = linspace(0, 2*pi, nc);
v = interp1(phi1, v1, phi, 'spline');
xs2 = interp1(phi1, xs, phi, 'spline');
ys2 = interp1(phi1, ys, phi, 'spline');

agte = (atan2(xs(end), -ys(end)) - atan2(xs(1), -ys(1)))/pi - 1.0;

%%% Cncalc
% Find LE
le_idx = find(xs2==min(xs2));
x_le = xs2(le_idx);
wcle = phi(le_idx);

alfcir = 0.5*(wcle - pi);

% Get velocity derivatives with respect to phi
qc = v;
dv = spline(phi, qc);
dv.order=dv.order-1;
dv.coefs=dv.coefs(:,1:end-1).*(dv.order:-1:1);
qcw = ppval(dv,phi);

P = zeros(size(phi));
for i=2:nc-1
    cosw = 2.0*cos(0.5*phi(i) - alfcir);
    sinw = 2.0*sin(0.5*phi(i));
    if sinw > 0 
        sinwe = sinw^agte;
    else
        sinwe = 0;
    end

    if abs(cosw) < 1e-4
        pfun = abs( sinwe/qcw(i) );
    else
        pfun = abs( cosw*sinwe/qc(i) );
    end

    P(i) = log(pfun) +0j;
end

% Extrapolate to TE
P(1) = 3*P(2) -3*P(3) + P(4);
P(end) = 3*P(nc-1) - 3*P(nc-2) + P(nc-3);

cn = ftp(nc, mc, eiw, dwc, P);

piq = piqsum(nc, mc, eiw, cn);
Q = imag(piq);

% Mapgen
dx = xs(2) - xs(1);
dy = ys(2) - ys(1);
qim0 = atan2(dx, -dy) + 0.5*pi*(1+agte);
qimoff = qim0 - imag(cn(1));
cn(1) = cn(1) + qimoff * 1j;

piq = piqsum(nc, mc, eiw, cn);

% P = - log(abs(v) ./ (2*abs(cos(phi/2)-alpha)));
% P2 = zeros(size(P));
% 
% Q = zeros(size(phi));
% 
% for n = 0:(2*N-1)
%     Qn = 0;
%     for i = 0:N-1
%         P1 = mod(n+1+2*i, 2*N);
%         P2 = mod(n-1-2*n,2*N);
% 
%         Qn = Qn + (P(P1+1)-P(P2+1))*cot((2*i+1)*pi/(2*N));
%     end
%     Q(n+1) = 1/(2*N) * Qn;
% end





dx_dphi = -4 * sin(phi/2) .* abs(cos(phi/2 - alpha)) .*(1./abs(v)).*cos(phi/2 +Q);
dy_dphi = -4 * sin(phi/2) .* abs(cos(phi/2 - alpha)) .*(1./abs(v)).*sin(phi/2 +Q);

dx_dphi_orig = diff(xs2) ./ diff(phi);
dy_dphi_orig = diff(ys2) ./ diff(phi);

xs2 = 1+cumtrapz(phi, dx_dphi);
ys2 = cumtrapz(phi, dy_dphi);

plot(phi, v)

figure(2);
plot(phi, P, phi, real(piq), '--')

figure(3);
plot(phi, Q)

figure(4);
plot(phi,dx_dphi, phi(1:length(phi)-1), dx_dphi_orig);

figure(5);
plot(phi,dy_dphi, phi(1:length(phi)-1), dy_dphi_orig);

figure(6);
plot(xs2, ys2);