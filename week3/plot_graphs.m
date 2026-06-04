clear
close all

caseref = "Data/naca0012.mat";
load(caseref);

% C_L alpha and C_D alpha
figure(1);
hold on
plot(alpha, clswp);
plot(alpha, cdswp);
legend("C_L","C_D");
xlabel('Angle of Attack (degrees)');
ylabel('Coefficients');
title('Lift and Drag Coefficients vs. Angle of Attack');
hold off;

figure(2);
plot(cdswp, clswp)
xlabel('C_D');
ylabel('C_L');

figure(3);
plot(alpha, lovdswp);
xlabel('Angle of Attack (degrees)');
ylabel('L/D');