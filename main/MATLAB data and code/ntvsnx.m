clc
clear
close all

D = 0.2;
F = 0.5;
tf = 1;
nx(1)=1;
nt(1)=tf*D/F*(nx(1)-1)^2+1;
nxm=100;

for i = 1:nxm
     nt(i+1) = tf*D/F*(nx(i)-1)^2+1;
     nx(i+1) = nx(i)+1
end

area(nt,nx,'facecolor','green')
ylabel('n_x')
xlabel('n_t')
title('Stability chart at D=0.2, t_f=1')