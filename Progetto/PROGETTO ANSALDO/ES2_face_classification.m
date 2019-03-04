clear
close all
clc

%% Random Seed
seed = 13;
randn('seed',seed);

%% Load Image
X = load('face_x.txt');
Y = load('face_y.txt');
[n,~] = size(X); 

%% Split Train Test
i = randperm(n);
XT = X(i(1:30),:);
YT = Y(i(1:30));
X(i(1:30),:) = [];
Y(i(1:30)) = [];
[n,d] = size(X);

%% Perceptron
X = [X, ones(n,1)];
w = zeros(d+1,1);
err = sum(Y.*(X*w) <= 0);
i = 1;
while (err > 0)
	fi = X(i,:)*w;
    if (Y(i)*fi <= 0)
        w = w + Y(i)*X(i,:)';
        err = sum(Y.*(X*w) <= 0); %training
    end
	i = i + 1;
	if (i > n) 
        i = 1;
       
	end
end 
b = w(end); w(end) = [];

%% Test;
[n,d] = size(XT);
YF = XT*w+b;

%% 
for i = 1:n
    close all
    imm = XT(i,:);
    imm = reshape(imm,60,60)';
    imagesc(imm)
    colormap gray
    title(sprintf('Vero:%d - Predetto:%d',YT(i),YF(i)))
    pause
end