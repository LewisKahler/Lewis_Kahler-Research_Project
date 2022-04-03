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
dx = (b-a) / (nx-1);
dt = (tf-t0) / (nt-1);
x = a:dx:b;
t = t0:dt:tf;
F = D * dt/dx^2   % For stability F<0.5

%%Analytical solution

U = zeros (nx, nt);

for n = 1:nt
    for i = 1:nx
        U(i,n) = cos(pi*x(i))*exp(-pi^2*D*t(n));
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
        UN(i,n+1) = F*UN(i-1,n) + (1-2*F)*UN(i,n) + F*UN(i+1,n);
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