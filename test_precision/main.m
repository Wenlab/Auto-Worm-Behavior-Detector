clear;clc;close all;

%% parameter
n_frame = 8000;

%% load human label
human_label = load_human_label(n_frame);

%% load machine label
machine_label = load_machine_label(n_frame);

%% result for 3 categories
performance_3_cate(human_label,machine_label);

%% result for 2 categories
performance_2_cate(human_label,machine_label);