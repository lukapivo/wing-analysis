function lhsmat = build_lhs(xs,ys)
% BUILD_LHS Compute psi matrix for panel solution.

% Get number of panels
np = length(xs) - 1;

% Initialise matrices
psip = zeros(np,np+1);

[infa,infb] = panelinf(xs(1),ys(1),xs(2),ys(2),xs,ys);
psip(:,1) = infa;

for j=2:np
    [infap,infbp] = [infa, infb]; % Previous coefficients
    [infa, infb] = panelinf(xs(j), ys(j), xs(j+1), ys(j+1), xs, ys);
    psip(:,j) = infa + infbp;
end

[infa,infb] = panelinf(xs(np),ys(np),xs(np+1),ys(np+1),xs,ys);
psip(:,np+1) = infb;

% A matrix
lhsmat = zeros(np+1,np+1); 

lhsmat(1:np-1, :) = diff(psip);
lhsmat(np,1) = 1;
lhsmat(np+1,np+1) = 1; 

end