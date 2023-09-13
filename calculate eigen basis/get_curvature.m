% load multi mcd.mat

% clear
clc;clear;close all;

% add path
my_add_path;

% chose the folder of files
path = uigetdir;

% if at least 1 file is choosed
if path ~= 0

    % get full paths of files
    list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(path,'*mcd_corr*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list_mcd,'ListSize',[800,600],'Name','Chose files to convert');

    % if at least 1 file is choosed
    if tf==1
        for ii = indx

            % load
            full_path_to_mcd = list_mcd{ii};
            mcd = load_mcd(full_path_to_mcd);

            % delete nan
            all_centerline = get_all_centerline(mcd);
            lengths_of_centerlines = get_lengths(all_centerline);
            n_frames = length(all_centerline);
            label = zeros(n_frames,1);
            label = process_nan(label,lengths_of_centerlines);
            % label_rearranged = rearrange_label(label);

            % delete beyond the edge
            label = beyond_the_edge(mcd, label);
            % label_rearranged = rearrange_label(label);

            % delete head touch body and too long
            label = Tukey_test_of_length_of_centerline(label,lengths_of_centerlines);
            label_rearranged = rearrange_label(label);

            % get curvature
            curvature_of_centerline = [];
            for i = 1:size(label_rearranged,1)
                if ~label_rearranged(i,3)
                    start_frame = label_rearranged(i,1);
                    end_frame = label_rearranged(i,2);
                    [curvature_of_centerline_new, ~] = get_the_curvature_of_a_period(mcd,start_frame,end_frame);
                    curvature_of_centerline = vertcat(curvature_of_centerline,curvature_of_centerline_new);
                end
            end

            % save
            save_folder = fileparts(full_path_to_mcd);
            save_full_path = fullfile(save_folder,"curvature_of_centerline.mat");
            save(save_full_path,"curvature_of_centerline");
            disp('curvature_of_centerline.mat saved successfully!');

        end
    end
end

disp('Thanks for using!');
disp('See you next time!');
disp('<<<END>>>');