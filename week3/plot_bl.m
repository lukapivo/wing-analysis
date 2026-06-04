clear
close all

caseref = "Data/naca0012_6.5.mat";
load(caseref);

hold on
plot(sl, thetal);
plot(su, thetau);
legend("Lower", "Upper");
xlabel('s');
ylabel('\theta');
hold off

figure(2);

hold on
plot(sl, delstarl);
plot(su, delstaru);
legend("Lower", "Upper");
xlabel('s');
ylabel('\delta*');
hold off

figure(3);

hold on
plot(sl, delstarl./thetal);
plot(su, delstaru./thetau);
legend("Lower", "Upper");
xlabel('s');
ylabel('H');
hold off

figure(4);

hold on
plot([su sl], cp);
xlabel('s');
ylabel('cp');
hold off