clc
clear
close all

v = 0.8;
F = 1;
tf = 1;
nx(1)=1;
nt(1)=tf*v/F*(nx(1)-1)^2+1;
nxm=100;

for i = 1:nxm
     nt(i+1) = tf*v/F*(nx(i)-1)+1;
     nx(i+1) = nx(i)+1
end

area(nt,nx,'facecolor','green')
ylabel('n_x')
xlabel('n_t')
title('Stability chart at v=0.8, t_f=1')