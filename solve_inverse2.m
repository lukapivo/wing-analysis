function [x_airfoil, y_airfoil] = inverse_airfoil(v_upper, x_upper, v_lower, x_lower, alpha_deg)
    N = 400;
    alpha = alpha_deg * pi/180;
    
    % Even number of points on full circle
    phi_full = linspace(0, 2*pi, 2*N+1).';
    phi_full = phi_full(1:end-1);   % 2N points
    
    % Split into upper and lower halves
    is_upper = phi_full <= pi;
    phi_upper = phi_full(is_upper);
    phi_lower = phi_full(~is_upper);
    
    % Map to x
    x_upper_phi = (1 + cos(phi_upper)) / 2;
    x_lower_phi = (1 + cos(phi_lower)) / 2;
    
    % Interpolate (clip velocities to avoid log(0))
    v_upper_safe = max(v_upper, 1e-6);
    v_lower_safe = max(v_lower, 1e-6);
    v_on_upper = interp1(x_upper, v_upper_safe, x_upper_phi, 'pchip', 1e-6);
    v_on_lower = interp1(x_lower, v_lower_safe, x_lower_phi, 'pchip', 1e-6);
    
    % Assemble
    v_circle = [v_on_upper; v_on_lower];
    % Force periodicity
    v_circle(1) = (v_circle(1) + v_circle(end)) / 2;
    v_circle(end) = v_circle(1);
    
    % P(φ) = ln(2|cos(φ/2-α)|) - ln(v)
    term1 = 2 * abs(cos(phi_full/2 - alpha));
    P = log(term1) - log(v_circle);
    
    % Hilbert transform via FFT (even length works)
    Np = length(P);
    P_fft = fft(P);
    H = zeros(1, Np);
    H(2:(Np/2)) = -1i;
    H(Np/2+2:end) = 1i;
    Q_fft = H .* P_fft;
    Q = real(ifft(Q_fft));
    
    % Derivatives and integration
    sin_half = sin(phi_full/2);
    cos_half_minus_alpha = cos(phi_full/2 - alpha);
    factor = 4 * sin_half .* abs(cos_half_minus_alpha) ./ v_circle;
    dx_dphi = -factor .* cos(phi_full/2 + Q);
    dy_dphi = -factor .* sin(phi_full/2 + Q);
    
    x = cumtrapz(phi_full, dx_dphi);
    y = cumtrapz(phi_full, dy_dphi);
    
    % Scale to unit chord
    chord = x(end) - x(1);
    if chord <= 0, chord = max(x) - min(x); end
    x = (x - min(x)) / chord;
    y = (y - min(y)) / chord;
    
    x_airfoil = x;
    y_airfoil = y;
end
% Load data
load('Data/LLL08b_3.2.mat');

% Convert cp to velocity V/Vinf (incompressible)
v_target = sqrt(1 - cp);

% Determine split index (where xs is minimum, i.e., leading edge)
[~, idx_LE] = min(xs);
% Upper surface: indices 1:idx_LE (from TE to LE)
x_upper = xs(1:idx_LE);
v_upper = v_target(1:idx_LE);
% Lower surface: indices idx_LE:end (from LE to TE)
x_lower = xs(idx_LE:end);
v_lower = v_target(idx_LE:end);

% Design angle of attack (from your file name or known)
alpha_design = 3.2;   % deg

% Run inverse design
[x_airfoil, y_airfoil] = inverse_airfoil(v_upper, x_upper, v_lower, x_lower, alpha_design);

% Plot result
figure;
plot(x_airfoil, y_airfoil, 'b-', 'LineWidth', 1.5);
axis equal;
grid on;
xlabel('x/c'); ylabel('y/c');
title('Reconstructed airfoil');