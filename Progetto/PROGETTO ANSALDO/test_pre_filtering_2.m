clear
clc

load('Modello_1.mat')
i= randperm(size(T_amb,1));
T_amb = T_amb(i);

input = T_amb;
new_input = pre_filtering_2(input);


pre_filtering_2(new_input);