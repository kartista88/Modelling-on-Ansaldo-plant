function err = correct_estimation(y_targets, y_e, min_y, max_y)

    
    di = max_y - min_y; 
    
    % soglia normalizzata (10 mbar)
    
    threshold = 0.01 / di; threshold
    n = size(y_targets,1); n
    
    y_targ_th = y_targets + threshold;
    
    % estimations corrette
    ce = ...
        (y_e >= y_targets-threshold & y_e <= y_targets+threshold ); 
    
    number_of_ce = sum(ce); number_of_ce
    
    err = number_of_ce/n;
    

end
