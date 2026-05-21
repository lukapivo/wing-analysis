function psixy = psipv(xc,yc,Gamma,x,y)
% PSIPV Compute streamfunction for a point vortex at (xc,yc).

psixy = - Gamma/(4*pi) * log((x-xc).^2 + (y-yc).^2);

end
