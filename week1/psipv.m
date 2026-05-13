function psixy = psipv(xc,yc,Gamma,x,y)

psixy = - Gamma/(4*pi) * log((x-xc).^2 + (y-yc).^2);

end
