function [x_mix, y_mix] = pre_filtering_0(x, y)
    % permuto le righe di x e y
    
    seed = 13;
    rand('seed',seed);
    
    [n,~] = size(x);
    
    i = randperm(n);
    
    x_mix = x(i,:);
    y_mix = y(i);

end