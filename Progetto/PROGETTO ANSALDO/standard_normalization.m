function [x, y] = standard_normalization(x, y)

    [n, d] = size(x);

    for i = 1:d
        mi = min(x(:,i));
        ma = max(x(:,i));
        di = ma-mi;
        if di>1e-6
            x(:,i) = (x(:,i) - mi)/di;
        end
    end
    
    if size(y,1) ~= 0
            % per y
        mi = min(y);
        ma = max(y);
        di = ma-mi;
        if di>1e-6
            y = (y - mi)/di;
        end
    end
end