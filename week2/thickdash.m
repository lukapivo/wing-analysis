function dthickdx = thickdash(xmx0, thick)
global Re_L ue0 due_dx

ue = ue0 + xmx0 * due_dx;

% thick(1) = theta;
Rethet = Re_L * ue * thick(1);

% thick(2) = delta_e;
He = thick(2) / thick(1);

if He >= 1.46
    H = (11 * He + 15) / (48 * He - 59);

elseif He < 1.46
    H = 2.803;
end

cf = 0.091416 * ((H - 1) * Rethet)^(-0.232) * exp(-1.26 * H);

c_diss = 0.010026 * ((H - 1) * Rethet) ^(-1/6);

% Returns f(x,y)
dthickdx = zeros(2,1);
dthickdx(1) = cf / 2 - (H + 2)/ ue * due_dx * thick(1);
dthickdx(2) = c_diss - 3 / ue * due_dx * thick(2);