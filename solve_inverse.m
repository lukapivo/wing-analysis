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

% Seed
caseref = "Data/naca0012_2.mat";
load(caseref);

alpha_d = 2; % deg
alpha = deg2rad(alpha_d);

% Convert to v/vinf
v1 = [sqrt(1-cp(1:length(su))), -sqrt(1-cp(length(su)+1:end))];

% Put onto circle
phi1 = [acos(2*xs(1:length(su)-2)-1), 2*pi-acos(2*xs(length(su)-1:end)-1)];

% Resample
N = nc;
phi = linspace(0, 2*pi, nc);
v = interp1(phi1, v1, phi, 'spline');


%%% SCINIT
agte = (atan2(xs(end), -ys(end)) - atan2(xs(1), -ys(1)))/pi - 1.0;
ag0 = atan2( xs(1) , -ys(1) );
qim0 = ag0 + 0.5*pi*(1.0+agte);

dxte = xs(1) - xs(end);
dyte = ys(1) - ys(end);
dzte = dxte + dyte*1j;

xle = min(xs);
yle = ys(xs==xle);
zleold = xle + yle * 1j;
chordx = 0.5*(xs(1)+xs(end)) - xle;
chordy = 0.5*(ys(1)+ys(end)) - yle;
chordz = chordx + 1j * chordy;

xs = interp1(phi1, xs, phi, 'spline');
ys = interp1(phi1, ys, phi, 'spline');


%%% Cncalc
% Find LE
le_idx = find(xs==min(xs));
x_le = xs(le_idx);
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

cn(1) = 0+1j* imag(cn(1));

piq = piqsum(nc, mc, eiw, cn);
Q = imag(piq);


% Mapgen
dx = xs(2) - xs(1);
dy = ys(2) - ys(1);
qim0 = atan2(dx, -dy) + 0.5*pi*(1+agte);
qimoff = qim0 - imag(cn(1));
cn(1) = cn(1) + qimoff * 1j;

piq = piqsum(nc, mc, eiw, cn);
[zc sc zc_cn] = zccalc(eiw, nc, phi, agte, dwc, mct, piq);
[cn, zc, sc, zc_cn] = zcnorm(nc, mct, chordz, zleold, zc, sc, zc_cn, cn);

for i=0:1000
    residual = zc(1) - zc(end);
    jacobian = zc_cn(1,1) - zc_cn(end,1);
    if abs(jacobian) < 1e-20
        1e-20
        break
    end
    dcn = residual / jacobian;
    cn(1) = cn(1) - dcn;

    piq = piqsum(nc, mc, eiw, cn);
    [zc sc zc_cn] = zccalc(eiw, nc, phi, agte, dwc, mct, piq);
    [cn, zc, sc, zc_cn] = zcnorm(nc, mct, chordz, zleold, zc, sc, zc_cn, cn);

    if abs(dcn) < 5e-5
        5e-5
        break
    end
end

%%% Recalculate specified velocities
alfcir = alpha - imag(cn(1));
qspec_values = zeros(nc,1);

for ic=1:nc
    eppp = exp(-real(piq(ic)));
    
    sinw = 2.0*sin(0.5*phi(ic));
    if sinw > 0 
        sinwe = sinw^(1-agte);
    else
        sinwe = 0;
    end
    qspec_values(ic) = 2 * cos(0.5*phi(ic)-alfcir)* sinwe * eppp;
end


plot(phi, v, phi, qspec_values)

figure(2);
plot(phi, P, phi, real(piq), '--')

figure(3);
plot(phi, Q)

figure(4);

plot(real(zc), imag(zc), xs,ys,'--');
axis equal

figure(5);
scatter(0:length(cn)-1,log10(abs(cn)),'o');
% yscale log

% Slow Fourier Transform (check if fast will do)
function [cn] = ftp(nc, mc, eiw, dwc, P)
cn = zeros(1,mc+1);
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
piq = zeros(1,nc);
for i=1:nc
    zsum = 0 + 0j;
    for m = 1:mc+1
        zsum = zsum +cn(m)*conj(eiw(i,m));
    end
    piq(i) = zsum;
end
end

% Calculate coordinates from p and q
function [zc, sc, zc_cn] = zccalc(eiw, nc, phi, agte, dwc, mtest, piq)
    ic = 1;
    zc = zeros(nc, 1);
    sc = zeros(nc, 1);
    zc_cn = zeros(nc, ic);
    
    zc(ic) = 4;
    for m=1:mtest
        zc_cn(1,m) = 0+0j;
    end
    
    sinw = 2*sin(0.5*phi(ic));
    sinwe = 0;
    if sinw > 0
        sinwe = sinw^(1-agte);
    end
    
    hwc = 0.5*(phi(ic)-pi)*(1+agte) - 0.5*pi;
    dzdw1 = sinwe * exp(piq(ic) + hwc*1j);
    
    for ic=2:nc
        sinw = 2*sin(0.5*phi(ic));
        sinwe = 0;
        if sinw > 0
            sinwe = sinw^(1-agte);
        end
    
        hwc = 0.5*(phi(ic)-pi)*(1+agte) - 0.5*pi;
        dzdw2 = sinwe * exp(piq(ic) + hwc*1j);
    
        % I think this is just trapezium rule
        zc(ic) = 0.5*(dzdw1+dzdw2)*dwc + zc(ic-1);
        dz_piq1 = 0.5*dzdw1*dwc;
        dz_piq2 = 0.5*dzdw2*dwc;
    
        for m=1:mtest
            zc_cn(ic,m) = dz_piq1 * conj(eiw(ic-1,m+1)) + ...
                          dz_piq2 * conj(eiw(ic,m+1)) + ...
                          zc_cn(ic-1,m);
        end
    
        dzdw1 = dzdw2;
    end
    
    % Set arc length
    sc(1) = 0;
    for ic=2:nc
        sc(ic) = sc(ic-1) + abs(zc(ic)-zc(ic-1));
    end
    
    % Normalise arc length
    for ic=1:nc
        sc(ic) = sc(ic)/sc(nc);
    end

end

function [cn, zc, sc, zc_cn] = zcnorm(nc, mtest, chordz, zleold, zc, sc, zc_cn, cn)
    zte_cn = zeros(size(zc_cn));
    zle = zlefind(zc);
    

    % Place leading edge at origin
    zc = zc - zle;
    % zte = 0.5*(zc(1) + zc(nc));
    zte = zc(1);
    
    % Set normalizing sensitivities
    for m=1:mtest
        zte_cn(m) = 0.5*(zc_cn(1,m) + zc_cn(nc,m));
    end

    for ic=1:nc
        zcnew = chordz*zc(ic)/zte;
        zc_zte = -zcnew/zte;
        zc(ic) = zcnew;
        for m=1:mtest
            zc_cn(ic,m) = chordz*zc_cn(ic,m)/zte + zc_zte*zte_cn(m);
        end
    end

    qimoff = -imag(log(chordz/zte));
    cn(1) = cn(1) - qimoff * 1j;

    zc = zc + zleold;
end

function [zle] = zlefind(zc)
    % zte = 0.5*(zc(1)+zc(end));
    zte = zc(1);
    % zle = zc(abs(zc-zte)==max(abs(zc-zte)));
    idx = 1;
    max = 0;
    for i=1:length(zc)
        if abs(zc(i)-zte) > max
            max = abs(zc(i)-zte);
            idx =i;
        end
    end
    zle = zc(idx);
end

