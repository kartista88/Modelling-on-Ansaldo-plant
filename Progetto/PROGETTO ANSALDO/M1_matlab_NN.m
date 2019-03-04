clc
clear
rand('seed',13)

%% data set
load('Modello_1')

x1 = Carico_ACC_perc;
x2 = T_amb;
x3 = PortataDaPressione;

y = Vuoto_atteso;
x = [x1, x2, x3];

[n,d] = size(x);

%% first plot

% bin=100;
% figure(1)
% 
% subplot(2,2,1)
% hist(x(:,1),bin)
% title('Carico ACC perc')
% 
% subplot(2,2,2)
% hist(x(:,2),bin)
% title('T amb')
% 
% subplot(2,2,3)
% hist(x(:,3),bin)
% title('Portata da pressione')
% 
% subplot(2,2,4)
% hist(y,bin)
% title('Vuoto atteso')


%% normalization

for i=1:d
   
    mi = min(x(:,i)); 
    ma = max(x(:,i)); 
    di = ma-mi;
    if di>1e-6
        x(:,i) = (x(:,i)-mi)/di;
    end
end

%% pre - filtering 1 : data reduction
% 
% [x, y] = pre_filtering_1(x, y);
% 
% [n,d] = size(x);

%% pre filtering 3

% Np = 50;
% [x, y] = pre_filtering_3(x, y, Np);
% 
% [n,d] = size(x); 

%% pre filtering 2

perc = 1;
x1 = pre_filtering_2(x1, perc); 

x = [x1, x2, x3];

%% plot with normalized & reduced data

bin=100;
figure(2)

subplot(2,2,1)
hist(x(:,1),bin)
title('Carico ACC perc')

subplot(2,2,2)
hist(x(:,2),bin)
title('T amb')

subplot(2,2,3)
hist(x(:,3),bin)
title('Portata da pressione')

subplot(2,2,4)
hist(y,bin)
title('Vuoto atteso')

%% splitting

i = randperm(n);

nv = max(round(n*.3),1);
nl = n - nv;

%dati di learning
xl = x(i(1:nl),:);
yl = y(i(1:nl));

%dati di validation
xv = x(i(nl+1:end),:);
yv = y(i(nl+1:end));

%% matlab neural networks

inputs = xl';  %num. of features/inputs
targets = yl'; %num. of y_reference
S = 15;      %dim. of hidden layers of one layers

%Inizializzo la rete
net_0 = feedforwardnet(S);

%Visualizzo la rete creata
% view(net_0) 

%Eseguo il training della rete
[net_1, tr] = train(net_0, inputs, targets);

%Memorizzo la simulazione dell'output della rete
y_test = sim(net_1, inputs);

%Mean squared error
err = mse(targets,y_test); err

%% plot

% grid on; 
% title('targets')
% plot(targets,'r')
% title('y_test')
% plot(y_test)


%% plot

Y = net_1(xv');
targets = yv';
y_test = Y;

mse(targets, y_test)

% figure(1)
% grid on; 
% title('targets')
% plot(targets,'r')

% figure(2)
% grid on;
% title('y_test')
% plot(y_test)

figure(4)
hold on
subplot(2,1,1)
hist(targets,100)
title('y targets')

subplot(2,1,2)
hist(y_test,100)
title('y test')
