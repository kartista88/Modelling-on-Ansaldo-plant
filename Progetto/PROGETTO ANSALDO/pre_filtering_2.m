% high frequencies filtering

function x_new = pre_filtering_2(x, perc)
    
    % eseguo il livellamento dell'istogramma
    % relativo al valore delle T_amb

    %%
    figure(5)
    hold on
    subplot(1,2,1)
    hist(x,100)
    title('original one')
    
    %%
        
    % permuto la x
    [n,~] = size(x);
    i = randperm(n);
    x = x(i); 
    
    % estraggo da x arrotondata la moda
    rounded_x = round(x); 
    m = mode(rounded_x); m
    
    % definisco un intorno di valori
    eps = 6; % da modificare, poco sensato (potrei metterci una percentuale della moda)
    range = (x > m-eps & x < m+eps); range
    out_of_range = (x < m-eps | x > m+eps);
    
    % quindi applico la modifica
    
    indexes = 1:n;
    i_out = indexes(range); 
    i_in = indexes(out_of_range); 
    
    % recupero il numero di dati che voglio modificare
    dim = size_of_filtered_data(x, i_out, i_in, perc); 
    
    x_out = x(i_out);  
    x_in = x(i_in);    
    
    x_out(1:dim) = x_in(1:dim);
    
    i_out_new = i_out(1:dim);
    x(i_out_new) = x_out(1:dim);
    
    x_new = x;
    %%
    
    subplot(1,2,2)
    hist(x_new,100)
    title('prefiltered one')

end