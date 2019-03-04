clc
clear
%% data set
d = 1;
n_ref = 100;
x_ref = linspace(0,1,n_ref)';
y_ref = x_ref.^2;

%%
figure(1)

subplot(2,1,1)
hold on
n_dots = 100;
x_dots = rand(n_dots,1);
y_dots = [x_dots.^2+0.05*randn(n_dots,1)];
plot( x_dots, y_dots,'ob','markersize',3)

plot(x_ref,y_ref,'-b')

% n=n_ref;
% x=x_ref;
% y=y_ref;

n=n_dots;
x=x_dots;
y=y_dots;

%%

x = [x,x.^2]; d = d+1;

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

err = sum((f-yl).^2)*.5


i=1;
num_iter = 0;
alfa=.1;

E = [];

while(err>0 & num_iter<100)
   
    num_iter = num_iter+1;
    
    %errore sul'i-esimo campione
    f_i = xl(i,:)*w';
    
    if( pdist2(f_i,yl(i)) >eps )
        
        slope = (xl(i,:)*w'-yl(i))*xl(i,:); slope
        w = w - alfa*slope;
        
        
        %ricalcolo l'errore
        f = xl*w';
        err = sum((yl-f).^2)*.5;
    end
    
    E=[E,err];
    
    i = i+1;
    if i>nl
        i=1;
    end
    fprintf('num_iter: %d, err: %d \n',num_iter,err);
    
end
b = w(end); w(end) = [];

%% fase in avanti
w
f = xv*w' + b;
f=[linspace(0,1,nv)', linspace(0,1,nv)'.^2]*w';
plot(linspace(0,1,nv)',f,'-r')


subplot(2,1,2)
plot(1:num_iter,E,'r')