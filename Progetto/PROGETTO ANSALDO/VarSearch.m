%Trova la variabile ricercata tra le Var
function [VAR,MIN,MAX]=VarSearch(Var2Search,Var)
for i=1:size(Var,1)
    if strcmp(Var{i,2},Var2Search)==1
        VAR=i;
        MIN=Var{i,3};
        MAX=Var{i,4};
        break
    end 
end 