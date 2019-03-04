%% 

% riferimento a pagina 36 delle Note del Professor Luca Oneto

%% 
clear
clc
close all

%%
seed = 7;
randn('seed',seed)

%% data set

n = 30;
d = 2;
c = .2;
x = randn(n,d)+c;

%% normalize

for i = 1:d
    mi = min(x(:,i));
    ma = max(x(:,i));
    di = ma - mi;
    if (di > 1e-6)
        x(:,i) = (x(:,i) - mi) / di;
    end
end

%% plot

figure;
grid on; hold on; box on;

% assi
plot([0,0],[-.5,+1.5],'-b')
plot([-.5,+1.5],[0,0],'-b')

% data set
plot(x(:,1),x(:,2),'.b','markersize',20)
xlim([-.5,+1.5])
ylim([-.5,+1.5])
xlabel('x1')
ylabel('x2')

%% initializaton

% num di partizioni
Np = 3; 

% funzione per la distanza tra i punti
% -> pdist2()  :=  "distanza euclidea"

% punto da cui partire
seed = x(1,:);
i_seed = 1; % relativo indice

%% procedure Homogeneous multi partition


rank = 1;

% definisco il cellarray che conterrà le mie partizioni

% Avrà dimensione : Np_parti x ?_righe x 2_colonne

parts{1} = seed;
for i = 2:Np
   parts{i} = [];
end

% metodo di aggiornamento delle parti
% parts{1} = [parts{1}; x(2,:)];
% parts{1} = [parts{1}; x(3,:)];
% parts{1}

% punti visitati
visited = seed; 
i_visited = i_seed;

% punti non visitati
unvisited = x;
i_unvisited = 1:n;

unvisited(i_seed,:) = [];
i_unvisited(:,i_seed) = []; 


cur = seed; % current value
i_cur = i_seed;

plot(x(i_cur,1),x(i_cur,2),'og','markersize',9,'linewidth',3)


% metodo di estrazione
% a = [1 2 3]; i=1;
% while(size(a,2)>0)
%    a(i)=[];
% end


%% 13

dim = size(i_unvisited,2);

while (dim > 1)



%% 14
% indice del minimo pdist2 tra x(i_curr) e la x(k)
% con k appeartente a "unvisited"
xp=x(i_cur,:); xp
% calcolo tutte le dist euclidee tra il corrente e i non visitati
distances = pdist2( x(i_cur,:), x(i_unvisited,:) );
min_distance = min(distances) ;
k = find( min_distance == distances' );
i_cur = i_unvisited(k); 
xn=x(i_cur,:); xn
% pdist2(xp,xn)

%% 15 
cur = x(i_cur, :);


visited = [visited, cur];
i_visited = [i_visited, i_cur];

%% 16
i_unvisited(k) = [];
dim = size(i_unvisited,2); dim
%% 17
rank = rank + 1;

%% 18 (serve per ciclare solo sugli indici corrispondenti alle Np parts)
num = 1+(mod((rank-1),Np));


%% 19

parts{num} = [parts{num} ; x(i_cur,:)];

for index = 1:Np
    fprintf('index : %01d \n',index)
    parts{index}
end

colors = 'grymc';
plot(x(i_cur,1),x(i_cur,2),['o' colors(num)],'markersize',9,'linewidth',2)
pause;

end

for t=1:Np
    size(parts{t})
end
%%

% per esempio a questo punto potrei ridurre il mio data set al primo
% insieme delle Np partizioni

[n_red, d_red] = size(parts{1});

x_red =  parts{1};x_red