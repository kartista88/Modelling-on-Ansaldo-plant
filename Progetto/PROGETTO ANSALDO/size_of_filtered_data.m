function s = size_of_filtered_data(x, i_out, i_in, perc)

    % perc := percentuale di elementi da modificare
    
    dim_out = size(i_out,2); 
    dim_in = size(i_in,2);   

    
    rounded_dim_out = round(dim_out * perc) 
    rounded_dim_in =  round(dim_in * perc)
    s = min(rounded_dim_out , rounded_dim_in); s
    
end