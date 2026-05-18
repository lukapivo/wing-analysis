function rhsvec = build_rhs(xs,ys,alpha)

% Initialise vector
rhsvec = zeros(np+1,1);

psifs = ys * cos(alpha) - xs * sin(alpha);

% Final elements are already set to zero
rhsvec(1:np-1,:) = -1 * diff(psifs);

end