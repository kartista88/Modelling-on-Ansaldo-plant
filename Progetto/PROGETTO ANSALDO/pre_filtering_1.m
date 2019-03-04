% data size reduction

function [x_in, y_in, x_out, y_out] = ...
                    pre_filtering_1(x, y, tau)

    [n,~] = size(x); 
    
    %new indexes
    i = 0.*[1:n];
    i_aus = 1:tau:n; 
    i(i_aus) = 1; 
    i=logical(i); % serve per trasformarlo in un vettore di indici logici
    
    %filtering
    x_in = x(i,:); 
    y_in = y(i,:);
    
    x_out = x(~i,:);
    y_out = y(~i,:);
    
end
     