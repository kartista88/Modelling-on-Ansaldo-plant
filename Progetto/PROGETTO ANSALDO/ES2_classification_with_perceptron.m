clear
close all
clc

%%
seed = 13;
randn('seed',seed);

%%
n = 30;
d = 2;
c = .5;
X = [randn(n/2,d) + c; ...
     randn(n/2,d) - c];
Y = [+ones(n/2,1); 
     -ones(n/2,1)];

%%
for i = 1:d
    mi = min(X(:,i));
    ma = max(X(:,i));
    di = ma - mi;
    if (di > 1e-6)
        X(:,i) = (X(:,i) - mi) / di;
    end
end

%%
figure, hold on, box on, grid on
plot(X(Y>0,1),X(Y>0,2),'ob')
plot(X(Y<0,1),X(Y<0,2),'or')

%%
seed = 1;
randn('seed',seed);
w = randn(d,1);
b = randn(1,1);
err = sum((X*w+b) .* Y <= 0);
i = 1;
j = 0;
while (err > 0)
    j = j + 1;
    f = X(i,:)*w+b;
    if (f*Y(i) <= 0)
       w = w + Y(i) * X(i,:)';
       b = b + Y(i);
       err = sum((X*w+b) .* Y <= 0);
    end
    i = i + 1;
    if (i > n)
        i = 1;
    end
    fprintf('j: %04d, err: %03d\n',j,err)
end

%%
% y = w1 * x1 + w2 * x2 + b = 0
% x2 =  -w1/w2 * x1 - b/w2
x1 = linspace(0,1,100);
x2 = (-w(1)/w(2)) * x1 - (b/w(2));
plot(x1,x2,'g')

