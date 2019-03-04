
function [x1p,x2p,x3p,yp] = preproc2(x1,x2,x3,y)

    dim = size(x1,1);
    
    i = 1:10:dim;
    
    x1p = x1(i,:);
    x2p = x2(i,:);
    x3p = x3(i,:);
    yp = y(i,:);
    
    histogram(x1p);
 	index_out = x1p>90;
    
    index_in = x1p<90;
    
    index_in_out = randperm(10);
    


end