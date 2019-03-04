%% 
clear
clc
close all

%% seed fixing

%seed = 13;
%rand('seed',seed);

%% data set
load('Modello_1')

x1 = Carico_ACC_perc;
x2 = T_amb;
x3 = PortataDaPressione;

y = Vuoto_atteso;
x = [x1, x2, x3];

[n,d] = size(x);

%% normalization

for i = 1:d
    mi = min(x(:,i));
    ma = max(x(:,i));
    di = ma - mi;
    if di > 10e-6
        x(:,i) = (x(:,i) - mi) / di;
    end
end

%% pre-processing

x = [x.^0, x.^1, x.^2, x.^3, x.^4];

[n,d] = size(x);

nv = max(1,round(n*.01));
nl = n - nv;
nl_lim = 100;

%% unbiased regression

mc_v = 10;
err = 0;


for lambda = logspace(-5,1,5)
    
    for i_mc_v = 1:mc_v

        i = randperm(n);

        xl = x(i(1:nl_lim),:);
        yl = y(i(1:nl_lim),:);

        xv = x(i(nl+1:end),:);
        yv = y(i(nl+1:end),:);

        %% unbiased 
%         A = pinv(xl);
%         c =  A * yl;
    
        %% biased
        A = xl;
        biased_A = pinv(A'*A + lambda * eye(d,d));
        c = biased_A * (A'*yl);   

        %% forward phase
        f = xv*c;
    
        err = err + mse(f,yv);
%         err = err + mean((f - yv).^2);
    end
    
    fprintf('%.3e \n', err)
    
end



%%  plot

subplot(2,1,1)
hist(f,100)
title('estimation')

subplot(2,1,2)
hist(yv,100)
title('target')