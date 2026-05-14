function [infa infb] = panelinf(xa, ya, xb, yb, x, y)
% PANELINF Compute influence coefficients of a general location panel.

r = sqrtm((x-xa)^2 + (y-ya)^2);

tl = [xb-xa yb-ya];
del = norm(tl);
t = tl / del;

nl = [-(yb-ya) xb - xa];
n = nl / norm(nl);

X = dot(r,t);
Yin = dot(r,n);

[infa, infb] = refpaninf(del,X,Yin);

end
