%  Zero pressure gradient b-l; bl_solv and Blasius

clear all
global Re_L

Re_L = 10000000;

n = 100;
x = linspace(1/n,1,n);
cp = zeros(1,n);

[int ils itr its delstar theta] = bl_solv ( x, cp );
blthet = 0.664 * sqrt(x/Re_L);

if int~=0
  disp(['Natural transition at x = ' num2str(x(int))])
end

plot(x,blthet,'-',x,theta,'x')
xlabel('x/L')
ylabel('\theta')
legend('Blasius','blsolv')
set(gcf,'units', 'centimeters','position',[0,0,16,10])
saveas(gcf,'week3/Figures/bl_valid','epsc')

figure(2);
plot(x,delstar./theta,'-')
xlabel('x')
ylabel('H')
%legend('Blasius','blsolv')

