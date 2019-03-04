function [x_in, y_in, x_out, y_out] = ...
            pre_filtering_3(x_to_red, y_to_red, ...
                            num_of_partitions, num_of_parts_in)
    

    %%
    seed = 7;
    randn('seed',seed)
    
    %% data set
    x = [x_to_red, y_to_red];
    [n, d] = size(x);
    

    %% initializaton

    % num di partizioni
    Np = num_of_partitions; 

    % funzione per la distanza tra i punti
    % -> pdist2()  :=  "distanza euclidea"

    % punto da cui partire
    start = x(1,:);
    i_start = 1; % relativo indice

    %% procedure Homogeneous multi partition

    % variabile ausiliaria per ciclare sulle partizioni
    rank = 1;

    % definisco il cellarray che conterrà le mie partizioni

    % Avrà dimensione : Np_matrici * ?_righe * 2_colonne

    parts{1} = start; 
    for i = 2:Np
        parts{i} = [];
    end


    % punti visitati
    visited = start; 
    i_visited = i_start;

    % punti non visitati
    unvisited = x;
    i_unvisited = 1:n;
    
    % elimino il "punto" di partenza
    unvisited(i_start,:) = [];  
    i_unvisited(i_start) = []; 


    % assegno al valore "punto corrente" il "punto" di partenza
    cur = start; 
    i_cur = i_start;


    %% 13 ciclo fino a che non esaurisco i punti non visitati

    dim = size(i_unvisited,2);
    num_of_it = 1;
    
    while (dim  ~= 0 )
%     while (num_of_it<1000)
    
    % 14    
    % Prendo l'indice relativo al punto, nei non visitati, che ha distanza euclidea minima dal punto corrente 

    
    num_of_it=num_of_it+1;
    if( mod( num_of_it, 1000 ) == 0)
        num_of_it
    end

    % calcolo tutte le dist euclidee tra il corrente e i non visitati
    distances = pdist2( x(i_cur,:), x(i_unvisited,:) ); 
    dim_vec_of_distances = size(distances'); 
    
    % salvo il minimo di esse
    min_distance = min(distances); 
    distanza_minima=size(min_distance); 
    
    % salvo i corrispondente indice
    k = find( min_distance == distances' ,1);
    
    % aggiorno l'indice del punto corrente
    i_cur = i_unvisited(k); 
    
    
    % 15 aggiungo il punto alla lista dei punti visitati
    
    cur = x(i_cur, :);
    
    visited = [visited; cur];
    i_visited = [i_visited, i_cur];

    % 16 elimino l'indice dai punti non visitati
    
    i_unvisited(k) = [];
    
    dim = size(i_unvisited,2); 
    
    % 17
    rank = rank + 1;

    % 18 (serve per ciclare solo sugli indici corrispondenti alle Np parts)
    num = 1+(mod((rank-1),Np)); 


    % 19 aggiungo il punto alla partizione{num}

    parts{num} = [parts{num} ; x(i_cur,:)];


end


%%
% Il seguente for serve per verificare la dimensione delle partizioni
% for index = 1:Np
%     fprintf('index : %01d \n',index)
%     size(parts{index})
% %     parts{index}
% end

% per esempio a questo punto potrei ridurre il mio data set al primo
% insieme delle Np partizioni

x_in = [];
y_in = [];
for index_in = 1:num_of_parts_in
    
    x_in = [x_in; parts{index_in}];
    y_in = [y_in; parts{index_in}(:,4)];

end
x_in(:,4)=[];

x_out = [];
y_out = [];

if (num_of_parts_in < Np)
    
   for index_out = num_of_parts_in+1:num_of_partitions
    
        x_out = [x_out; parts{index_out}];
        y_out = [y_out; parts{index_out}(:,4)];

    end
    x_out(:,4)=[]; 
    
end
% 
% % assegno l'ultima colonna della partizione scelta a y_red
% y_red =  [parts{1}(:,4)];
% % y_red =  [parts{2}(:,4); parts{3}(:,4) ];
% 
% % assegno il resto a x_red
% 
% parts{1}(:,4) = []; % cancello le y_red
% % parts{3}(:,4) = [];
% 
% x_red = [parts{1}];
% % x_red = [parts{2}; parts{3} ];

end