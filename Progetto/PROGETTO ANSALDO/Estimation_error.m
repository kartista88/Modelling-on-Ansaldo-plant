clc
clear
close all

randn('seed',13);

n = 20;
y_e = randn(n,1).*3;

figure;
hold on; 
plot(y_e,'.r','markersize',10)

y_r = rand(n,1).*1.5;

plot(y_r,'b')

soglia = 3;
y_r_s = y_r+soglia;

plot(y_r_s,'c')


% procedura

ok = (y_e >= y_r & y_e <= y_r_s);


n_ok = sum(ok); n_ok

perc_ok = n_ok/n; fprintf('corretti : %03f \n',perc_ok)


err_mse = mse(y_e, y_r)
