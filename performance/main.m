clear;clc;close all;
dbstop if error;
my_add_path();

%% parameter
n_frame = 23569;

%% load human label
consensus_type = 'plurality'; % 'unanimous', 'majority', 'plurality'
human_label = load_human_label(n_frame, consensus_type);

%% load machine label
machine_label = load_machine_label(n_frame);

%% result for 3 categories
result_3_cate = performance_3_cate(human_label,machine_label);

%% result for 2 categories
result_2_cate = performance_2_cate(human_label,machine_label);