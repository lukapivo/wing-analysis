function [infa, infb] = panelinf(xa, ya, xb, yb, x, y)
% PANELINF Compute influence coefficients of a general location panel.

% x and y are matrices
dx = x - xa;
dy = y - ya;

% Computes tangent and normal vectors to the panel
tl = [xb-xa yb-ya];
del = norm(tl);
t = tl / del;

nl = [-(yb-ya) xb - xa];
n = nl / norm(nl);

% Projections onto tangent and normal
X  = dx * t(1) + dy * t(2);   % matrix, same size as x
Yin = dx * n(1) + dy * n(2);

[infa, infb] = refpaninf(del,X,Yin);

end
