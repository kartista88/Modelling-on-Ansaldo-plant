clc
clear
rand('seed',13)

%% data set
load('DataBaseImpianto1.mat')

% Potenza ventilatori
x1 = dati(:,2);
min_x1 = 2450;
max_x1 = 2700;

% T_amb
x2 = dati(:,7); 
min_x2 = 20;
max_x2 = 35;

% Portata da pressione
x3 = dati(:,10);
min_x3 = 60;
max_x3 = 90;

% Pressione valle 
y = dati(:,5);
min_y = 0;
max_y = 0.1000;

real_min_y = min(y);
real_max_y = max(y);


% Compattando..
x = [x1, x2, x3];

min_values = [min_x1, min_x2, min_x3, min_y];
max_values = [max_x1, max_x2, max_x3, max_y];

[n,d] = size(x);


%% first plot

plot_hist(x, y, 1)

%% normalization

[x, y] = significant_normalization(x, y, min_values, max_values);
% [x, y] = standard_normalization(x ,y);

%% Initialization of splitting variables

% x e y da fornire alla neural network
x_nn = x;
y_nn = y;

% x e y tenute per il testing
x_test = [];
y_test = [];


%% pre - filtering 0 : shaker

% [x_nn, y_nn] = pre_filtering_0(x_nn, y_nn);

%% pre - filtering 1 : data reduction

tau = 100;  % intervallo di campionamento

[x_nn_1, y_nn_1, x_test_1, y_test_1] = pre_filtering_1(x_nn, y_nn, tau);


x_nn = x_nn_1;
y_nn = y_nn_1;

x_test = x_test_1;
y_test = y_test_1; 


%% pre filtering 2 : frequencies falsification

% perc = 1;
% x1 = pre_filtering_2(x1, perc); 
% 
% x = [x1, x2, x3];

%% pre filtering 3 : clustering

Np = 15;    % numero di partizioni
Np_in = 3; % numero di partizioni da portare nei dati x_nn

[x_nn_3, y_nn_3, x_test_3, y_test_3] = ...
                              pre_filtering_3(x_nn, y_nn, Np, Np_in);

x_nn = [x_nn_3];
y_nn = [y_nn_3];

x_test = [x_test; x_test_3];
y_test = [y_test; y_test_3];

%% plot with normalized & reduced data

plot_hist(x_nn, y_nn, 2)

plot_hist(x_test, y_test, 3)


%% matlab neural networks

inputs = x_nn';  %num. of features/inputs
targets = y_nn'; %num. of y_reference

S = 50;        %dim. of hidden layers of one layers

%Inizializzo la rete
net_0 = feedforwardnet(S);
% net_0.layers{1}.transferFcn='logsig';

%Eseguo il training della rete
[net_1, tr] = train(net_0, inputs, targets);

%% test

y_estimated = net_1(x_test');
% y_estimated = sim(net_1, x_test');
test_targets = y_test';

%Mean squared test error
test_error = mse(test_targets,y_estimated); 

fprintf('test error : %06d \n', test_error)

%% net mse con gli indici della fcn "train"

% le seguenti tre righe esplicitano i dati su cui la rete esegue il
% training, la validation ed il testing
% err_train = mse(net_1(inputs(:,tr.trainInd)) , targets(tr.trainInd) );  err_train
% err_val = mse(net_1(inputs(:,tr.valInd)) , targets(tr.valInd) );        err_val
% err_test = mse(net_1(inputs(:,tr.testInd)) , targets(tr.testInd) );     err_test

fprintf('\n training error : %06d \n ', tr.best_perf)
fprintf('validation error : %06d \n ', tr.best_vperf)
fprintf('test error : %06d \n ', tr.best_tperf)

err = correct_estimation(test_targets', y_estimated', min_y, max_y);
fprintf('err : %i \n', err);

%% plot

figure(4)
hold on
subplot(2,1,1)
hist(test_targets,100)
title('y targets')

subplot(2,1,2)
hist(y_estimated,100)
title('y estimated')
