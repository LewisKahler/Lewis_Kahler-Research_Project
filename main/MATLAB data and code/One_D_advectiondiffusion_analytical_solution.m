clc
clear
close all

nx = 80; % 80
nt = 2500; % 2500
a = -0.5;
b = 0.5;
t0 = 0;
tf = 1;
D = 0.2;
v = 0.8;
dx = (b-a) / (nx-1);
dt = (tf-t0) / (nt-1);
x = a:dx:b;
t = t0:dt:tf;
FD = D * dt/dx^2   % For stability FD<0.5
Fv = v * dt/dx   % For stability Fv<1

%%Analytical solution

U = zeros (nx, nt);

for n = 1:nt
    for i = 1:nx
        U(i,n) = 1*0.5*(erfc(x(i)-v*t(n)/(2*(D*t(n))^(1/2)))+exp(v*(x(i))/D)*erfc(x(i)-v*t(n)/(2*(D*t(n))^(1/2))));

    end
end

figure('Name','Analytical solution')
contourf (t,x,U,200,'linecolor','non')
xlabel('t')
ylabel('x')
title ('Analytical solution of C(x,t)')
colormap(jet)
colorbar

%%Numerical solution

UN = zeros (nx, nt);

UN(:,1) = cos(pi*x)

for n = 1:nt -1
    for i = 2:nx -1
        UN(i,n+1) = UN(i,n) + FD*(UN(i-1,n)-2*UN(i,n)+UN(i+1,n)) - 0.5*Fv*(UN(i+1,n)-UN(i-1,n));
    end
end
 
figure(figure('Name','Explicit solution'))
contourf (t,x,UN,200,'linecolor','non')
xlabel('t')
ylabel('x')
title ('Explicit numerical solution of C(x,t)')
colormap(jet)
colorbar

figure(figure('Name','Explicit solution'))
surf(t,x,UN,'FaceAlpha',0.5,'EdgeColor','none')
title ('Explicit numerical solution of C(x,t) - alternate plot')
xlabel('t')
ylabel('x')
zlabel('C(x,t)')
colormap(jet)

%%Error

E =  abs (U-UN);

figure(figure('Name','Error'))
contourf (t,x,E,200,'linecolor','non')
xlabel('t')
ylabel('x')
title ('Solution error')
colormap(jet)
colorbar
