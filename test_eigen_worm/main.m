clc;clear;close all;

%% read the eigen basis
eigen_basis = readmatrix('../eigen_basis.csv');

%% main
path = uigetdir;
list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,"*mcd_corrected.mat");
[indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
for i = indx
    
    %% load the mcd.mat
    full_path = list{i};
    mcd = load_data_from_mat(full_path);

    %%
    start_frame = 328;
    end_frame = 1243;

    %% calculate the curvature
    [curvature_of_centerline_all, time] = get_the_curvature_of_a_period(mcd,start_frame,end_frame);
    plot_trajectory_in_phase_space_at_one_time(curvature_of_centerline_all, eigen_basis)
    plot_trajectory_in_phase_space_dynamically(curvature_of_centerline_all, eigen_basis)
    plot_trajectory_in_phase_space_and_save_gif(curvature_of_centerline_all, eigen_basis,'my_gif.gif');
    state = get_motion_state(curvature_of_centerline_all, eigen_basis);
    
end