function [cl, cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)
% FORCES Calculate lift and drag forces on an airfoil.

cl = - 2 * circ;

theta_te = thetal(end) + thetau(end);
H_te = (delstarl(end) + delstaru(end)) / theta_te;

% cp(1) and cp(np+1) constrained to be the same.
ue_te = sqrt(1-cp(end));


cd = 2 * theta_te * ue_te^((H_te+5)/2);
end