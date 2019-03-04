
function [x1p,x2p,x3p,yp] = preproc1(x1,x2,x3,y)

    x1p = size(x1); 
    index = 1;
    cont = 1;
    x1p(cont)=x1(index);

    for i=2:size(x1)
        if(i==index+10)
            x1p(cont)=x1(i);
            index=i;
            cont=cont+1;
        end
    end
   

    x2p = size(x2);
    index = 1;
    cont = 1;
    x2p(cont)=x2(index);

    for i=2:size(x1)
        if(i==index+10)
            x2p(cont)=x2(i);
            index=i;
            cont=cont+1;
        end
    end
    

    x3p = size(x3);
    index = 1;
    cont = 1;
    x3p(cont)=x3(index);

    for i=2:size(x3)
        if(i==index+10)
            x3p(cont)=x3(i);
            index=i;
            cont=cont+1;
        end
    end
    


end