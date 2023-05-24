% calculate curvature
close all;
eigen_basis = readmatrix('eigen_basis.csv');
start_frame = 8625;
end_frame = 9747;
[curvature_of_centerline_all, time] = get_the_curvature_of_a_period(mcd,...
    start_frame,end_frame);
plot_curvature_diagram(curvature_of_centerline_all,time);
plot_trajectory_in_phase_space(curvature_of_centerline_all, eigen_basis)
plot_trajectory_in_phase_space_v2(curvature_of_centerline_all, eigen_basis)
% plot_trajectory_in_phase_space_v3(curvature_of_centerline_all, eigen_basis,'my_gif.gif');
state = get_motion_state(curvature_of_centerline_all, eigen_basis);

% save
folder_name = fullfile('C:\Users\11097\Desktop\test_w1');
mkdir(folder_name);

figure(1)
file_name_png = ['from_' num2str(start_frame) '_to_' num2str(end_frame) '_curvature_diagram.png'];
full_file_path_png = fullfile(folder_name, file_name_png);
saveas(gcf, full_file_path_png);

figure(2)
file_name_png = ['from_' num2str(start_frame) '_to_' num2str(end_frame) '_phase_trajectory.png'];
full_file_path_png = fullfile(folder_name, file_name_png);
saveas(gcf, full_file_path_png);

file_name_mat = ['from_' num2str(start_frame) '_to_' num2str(end_frame) '.mat'];
full_file_path_mat = fullfile(folder_name, file_name_mat);
save(full_file_path_mat,'curvature_of_centerline_all');

file_name_csv = ['from_' num2str(start_frame) '_to_' num2str(end_frame) '.csv'];
full_file_path_csv = fullfile(folder_name, file_name_csv);
writematrix(curvature_of_centerline_all, full_file_path_csv, 'Delimiter', ',');