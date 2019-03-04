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

x = [x, x(:,2).^2]; d = d+1;

i = randperm(n);

nv = max(round(n*.3),1);
nl = n - nv;

%dati di learning
xl = x(i(1:nl),:);
yl = y(i(1:nl));

%dati di validation
xv = x(i(nl+1:end),:);
yv = y(i(nl+1:end));

%% perceptron

% mi libero della b
xl = [xl, ones(nl,1)];
w = rand(1,d+1);

f = xl*w';

err = sum((f-yl))*1/nl;



%%
% 
% i=1;
% num_iter = 0;
% alfa=100;
% 
% E = [];
% while(num_iter<500)
%    
%     num_iter = num_iter+1;
%     
%     %errore sul'i-esimo campione
%     f_i = xl(i,:)*w';
%     
%     if( pdist2(f_i,yl(i)) >eps )
%         
%         slope = (xl(i,:)*w'-yl(i))*xl(i,:); 
%         w = w - alfa*slope;
%         
%         
%         %ricalcolo l'errore
%         f = xl*w';
%         err = sum((yl-f).^2)*.5;
%     end
%     
%     E=[E,err];
%     
%     i = i+1;
%     if i>nl
%         i=1;
%     end
% %     fprintf('num_iter: %d, err: %d \n',num_iter,err);
%     
% end
% b = w(end); w(end) = [];
% 
% plot(1:num_iter,E,'r')