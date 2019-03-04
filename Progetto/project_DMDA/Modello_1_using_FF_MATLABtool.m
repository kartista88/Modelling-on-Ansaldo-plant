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

%% first plot

% bin=30;
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


%% plot with normalized data
% 
% bin=30;
% figure(2)
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


%% splitting

% x = [x, x(:,2).^2]; d = d+1;

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

% help = xv ( (1:nv*.3) , 1 );
% % xv = [help, xv(:, 2:end )];
% u{1}=[help];
% u{2}= xv(:, 2:end) ;
% 
% inputs = u';  %num. of features/inputs
inputs = xv';
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

% figure('Name','Original data','NumberTitle','off')
% %Plot input Modello1
% ax1 = subplot(3,2,1); % top subplot
% plot(ax1,x1)
% title(ax1,'Carico_ACC_perc')
% ylabel(ax1,'%')
% 
% ax2 = subplot(3,2,3); % bottom subplot
% plot(ax2,x2)
% title(ax2,'PortataDaPressione')
% ylabel(ax2,'kg/s')
% 
% ax3 = subplot(3,2,5); % bottom subplot
% plot(ax3,x3)
% title(ax3,'T_amb')
% ylabel(ax3,'°C')
% 
% %Istogrammi input Modello1
% 
% ax4 = subplot(3,2,2); % top subplot
% histogram(ax4,x1)
% title(ax4,'Carico_ACC_perc')
% ylabel(ax4,'%')
% 
% ax5 = subplot(3,2,4); % bottom subplot
% histogram(ax5,x2)
% title(ax5,'PortataDaPressione')
% ylabel(ax5,'kg/s')
% 
% ax6 = subplot(3,2,6); % bottom subplot
% histogram(ax6,x3)
% title(ax6,'T_amb')
% ylabel(ax6,'°C')
% 
% 
% 
% 
% figure('Name','Discretize data','NumberTitle','off')
% ax7 = subplot(3,2,1); % bottom subplot
% plot(ax7,x1d)
% title(ax7,'Carico_ACC_perc discreto')
% ylabel(ax7,'%')
% 
% ax8 = subplot(3,2,2); % bottom subplot
% histogram(ax8,x1d)
% title(ax8,'Carico_ACC_perc discreto')
% ylabel(ax8,'%')
% 
% ax9 = subplot(3,2,3); % bottom subplot
% plot(ax9,x2d)
% title(ax9,'PortataDaPressione discreto')
% ylabel(ax9,'kg/s')
% 
% ax10 = subplot(3,2,4); % bottom subplot
% histogram(ax10,x2d)
% title(ax10,'PortataDaPressione discreto')
% ylabel(ax10,'kg/s')
% 
% ax11 = subplot(3,2,5); % bottom subplot
% plot(ax11,x3d)
% title(ax11,'T_amb discreto')
% ylabel(ax11,'°C')
% 
% ax12 = subplot(3,2,6); % bottom subplot
% histogram(ax12,x3d)
% title(ax12,'T_amb discreto')
% ylabel(ax12,'°C')

%% plot

% grid on; 
% title('targets')
% plot(targets,'r')
% title('y_test')
% plot(y_test)


%% plot

Y = net_1(xl');

figure(1)
grid on; 
title('targets')
plot(targets,'r')

figure(2)
grid on;
title('y_test')
plot(y_test)

figure(3)
title('hist_targets')
hist(targets,100)

figure(4)
title('hist_y_test')
hist(y_test,100)