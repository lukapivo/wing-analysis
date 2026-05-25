function dthickdx = thickdash(xmx0, thick)
global Re_L ue0 duedx

ue = ue0 + xmx0 * duedx;

% thick(1) = theta;
Rethet = Re_L * ue * thick(1);

end