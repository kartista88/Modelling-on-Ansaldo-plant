clc
clear
rand('seed',13)
%% data set
load('Modello_2a')

x1  = PortataDaPressione;
x2  = PressioneMonte;
x3  = PressioneValle;
x4  = T_amb;
x5  = T_Condensato_1;
x6  = T_Condensato_2;
x7  = T_Condensato_3;
x8  = T_InCondensato_1;
x9  = T_InCondensato_2;
x10 = T_InCondensato_3;
x11 = T_monte;
x12 = T_Scarico_TV_ACC;
x13 = T_Scarico_TV_TV;

y = Xincondensabili;
x = [x1, x2, x3, x4, x5, x6, x7, x8, x9, ...
     x10, x11, x12, x13];

[n,d] = size(x);


%% normalization

for i=1:d
   
    mi = min(x(:,i)); 
    ma = max(x(:,i)); 
    di = ma-mi;
    if di>1e-6
        x(:,i) = (x(:,i)-mi)/di;
    end
end


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

inputs = xv';  %num. of features/inputs
targets = yv'; %num. of y_reference
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
mse(targets,y_test)

%% plot

% grid on; 
% title('targets')
% plot(targets,'r')
% title('y_test')
% plot(y_test)


%% plot

Y = net_1(inputs);

% figure(1)
% grid on; 
% title('targets')
% plot(targets,'r')
% 
% figure(2)
% grid on;
% title('y_test')
% plot(y_test)

figure(3)
title('hist_targets')
hist(targets,100)

figure(4)
title('hist_y_test')
hist(y_test,100)