function [infa infb] = panelinf(xa, ya, xb, yb, x, y)
% PANELINF Compute influence coefficients of a general location panel.

r = [x-xa y-ya];
r

tl = [xb-xa yb-ya];
del = norm(tl);
t = tl / del;
t

nl = [-(yb-ya) xb - xa];
n = nl / norm(nl);

X = dot(r,t,1);
Yin = dot(r,n,1);

[infa, infb] = refpaninf(del,X,Yin);

end
