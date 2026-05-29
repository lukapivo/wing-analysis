function lhsmat = build_lhs(xs,ys)
% BUILD_LHS Compute psi matrix for panel solution.

% Get number of panels
np = length(xs) - 1;

% Initialise matrices
psip = zeros(np,np+1);

[infa,infb] = panelinf(xs(1),ys(1),xs(2),ys(2),xs(1:np),ys(1:np));
psip(:,1) = infa.';

for j=2:np
    infbp = infb; % Previous value
    [infa, infb] = panelinf(xs(j), ys(j), xs(j+1), ys(j+1), xs(1:np), ys(1:np));
    psip(:,j) = (infa + infbp).';
end

psip(:,np+1) = infb.';

% A matrix
lhsmat = zeros(np+1,np+1); 

lhsmat(3:np+1, :) = diff(psip);

% Panel length calculation
Delta_1 = sqrt((xs(2) - xs(1))^2 + (ys(2) - ys(1))^2);
Delta_2 = sqrt((xs(3) - xs(2))^2 + (ys(3) - ys(2))^2);
Delta_npm1 = sqrt((xs(np) - xs(np-1))^2 + (ys(np) - ys(np-1))^2);
Delta_np = sqrt((xs(np+1) - xs(np))^2 + (ys(np+1) - ys(np))^2);

lhsmat(1,1) = 1;
lhsmat(1,2) = -1/2 * (1 + Delta_1 / Delta_2);
lhsmat(1,3) = -1/2 * Delta_1 / Delta_2;
lhsmat(1,np - 1) = 1/2 * Delta_np / Delta_npm1;
lhsmat(1,np) = 1/2 * (1 + Delta_np / Delta_npm1);

lhsmat(2,np+1) = 1; 
lhsmat(2,2) = 1/2 * (1 + Delta_1 / Delta_2); 
lhsmat(2,3) = 1/2 * Delta_1 / Delta_2; 
lhsmat(2,np - 1) = -1/2 * (1 + Delta_np / Delta_npm1); 
lhsmat(2,np) = -1/2 * Delta_np / Delta_npm1; 

end