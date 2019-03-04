function [x, y] = significant_normalization(x, y, min_values, max_values)
    
    [n, d] = size(x);

    % per le x
    for i=1:d
   
    
        % normalizzo tra minimo e massimo significativo 
    
        mi = min_values(i); 
        ma = max_values(i); 

    %     real_mi = min(x(:,i));
    %     real_ma = max(x(:,i));

        di = ma-mi;
        if di>1e-6
            x(:,i) = (x(:,i)-mi)/di;
        end
    
        % completo la normalizzazione tra 0 e 1 sui termini maggiori di 1 ed
        % inferiori a 0
    
        out_of_1 = x(:,i) > 1; 
        out_of_0 = x(:,i) < 0; 
    
        x(out_of_1,i) = 1; 
        x(out_of_0,i) = 0;
    
    end

    % per la y
    max_y = max_values(end);
    min_y = min_values(end);
    
    di = max_y - min_y;
    if di > 1e-6
        y(:,1) = (y(:,1) - min_y)/di;
    end

    out_of_1 = y > 1;
    out_of_0 = y < 0;

    y(out_of_1) = 1;
    y(out_of_0) = 0;



end