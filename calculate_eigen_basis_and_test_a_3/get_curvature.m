% Get the curvature. 
% 
% Drop nan, beyond the edge, head touch body.
%
% No need to save time, because we don't need time information when 
% performing PCA.
% 
% 2023-10-14, Yixuan Li
%

%% stop if error
dbstop if error

%% clear
clc;clear;close all;

%% chose the folder of files
root_path = uigetdir;

%% if at least 1 file is choosed
if root_path ~= 0
    
    % get full paths of files
    list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(root_path,'*mcd_corr*.mat');
    
    % choose files
    [indx,tf] = listdlg('ListString',list_mcd,'ListSize',[800,600],'Name','Chose files to convert');
    
    % if at least 1 file is choosed
    if tf==1
        for ii = indx
            
            % load
            full_path_to_mcd = list_mcd{ii};
            mcd = load_mcd(full_path_to_mcd);

            % init
            n_frames = length(mcd);
            label = zeros(n_frames,1);
            
            % get centerlines
            all_centerlines = get_all_centerlines_in_absolute_frame(mcd);
            lengths_of_centerlines = get_lengths(all_centerlines); 

            % delete NaN
            label = process_nan(label,lengths_of_centerlines);
            
            % delete beyond the edge
            enable_output = false;
            label = beyond_the_edge(mcd, label, false);
            
            % delete head touch body and too long
            label = Tukey_test_of_length_of_centerline(label,lengths_of_centerlines);

            % rearrange label
            label_rearranged = rearrange_label(label);
            
            % get the curvature of the unlabelled
            curvature_of_centerline_all = [];
            label_idx = [];
            for i = 1:size(label_rearranged,1)
                if ~label_rearranged(i,3)
                    start_frame = label_rearranged(i,1);
                    end_frame = label_rearranged(i,2);
                    [curvature_of_centerline_new, ~] = get_the_curvature_of_a_period(mcd,start_frame,end_frame);
                    curvature_of_centerline_all = vertcat(curvature_of_centerline_all,curvature_of_centerline_new);
                    label_idx = vertcat(label_idx,(start_frame:end_frame)');
                end
            end
            
            % save
            save_folder_path = fileparts(full_path_to_mcd);
            save_as_mat(save_folder_path, curvature_of_centerline_all);
            save_as_mat(save_folder_path, label_idx);
            
            % test a_3
            test_a_3(curvature_of_centerline_all);
            
        end
    end
end

disp('<<<END>>>');