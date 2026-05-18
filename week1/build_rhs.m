function rhsvec = build_rhs(xs,ys,alpha)

% Get number of panels
np = length(xs) - 1;

% Initialise vector
rhsvec = zeros(np+1,1);

psifs = ys(1:np) * cos(alpha) - xs(1:np) * sin(alpha);

% Final elements are already set to zero
rhsvec(1:np-1,:) = -1 * diff(psifs).';

end