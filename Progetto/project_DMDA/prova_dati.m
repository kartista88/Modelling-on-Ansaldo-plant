clc
clear
close all
rand('seed',13)
%% data set
load('Modello_1')

x1 = Carico_ACC_perc;
x2 = T_amb;
x3 = PortataDaPressione;

y = Vuoto_atteso;

% x = [x1, x2, x3];

[x1p,x2p,x3p,yp] = preproc2(x1,x2,x3,y);

x = [x1p, x2p, x3p];

y = yp;

[n,d] = size(x);
