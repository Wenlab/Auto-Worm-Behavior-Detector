dbstop if error

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
            
            % delete beyond the edge
            label = beyond_the_edge(mcd, label);
            
            % delete head touch body and too long
            label = Tukey_test_of_length_of_centerline(label,lengths_of_centerlines);

            % rearrange label
            label_rearranged = rearrange_label(label);
            
            % get the curvature of the unlabelled
            curvature_of_centerline = [];
            label_idx = [];
            for i = 1:size(label_rearranged,1)
                if ~label_rearranged(i,3)
                    start_frame = label_rearranged(i,1);
                    end_frame = label_rearranged(i,2);
                    [curvature_of_centerline_new, ~] = get_the_curvature_of_a_period(mcd,start_frame,end_frame);
                    curvature_of_centerline = vertcat(curvature_of_centerline,curvature_of_centerline_new);
                    label_idx = vertcat(label_idx,(start_frame:end_frame)');
                end
            end
            
            % save
            save_folder = fileparts(full_path_to_mcd);
            save_as_mat(save_folder, curvature_of_centerline);
            save_as_mat(save_folder, label_idx);
            
            % load eigen_basis
            load('eigen_basis_with_turn.mat');
            
            % calculate a_3
            a_3 = curvature_of_centerline * EigenWorms(:,3);
            
            %    outliers
            fprintf('Number of Outliers: %d\n', sum(abs(a_3) > 1)); % fprintf is better than disp!
            a_3(abs(a_3) > 1) = 0;
            
            % Gauss fit
            Gauss_fit(a_3);
            
            %% test Tukey
            IQR_index_max = 10;
            table = plot_number_of_outliers_vs_IQR_index(a_3, IQR_index_max);
            
            % Tukey
            IQR_index = 1;
            [number_of_up_outliers, number_of_down_outliers, mask_up, mask_down,...
                up_limit, down_limit, upper_bound, lower_bound] =...
                Tukey_test(a_3, IQR_index);
            
            % label
            test = label_idx(mask_up | mask_down);
            label(test) = 111;
            label_rearranged_v2 = rearrange_label(label);
        end
    end
end

disp('Thanks for using!');
disp('See you next time!');
disp('<<<END>>>');