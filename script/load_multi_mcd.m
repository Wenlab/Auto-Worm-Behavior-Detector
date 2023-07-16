% load multi mcd.mat and do machine label

clear;clc;close all;

% add path
my_add_path

% chose the folder of files
path = uigetdir;

% if at least 1 file is choosed
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*mcd_corr*.mat');
    
    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],...
        'Name','Chose files to convert');
    
    % if at least 1 file is choosed
    if tf==1
        for i = indx
            
            % load
            full_path = list{i};
            mcd = load_mcd(full_path);
    
            % save folder
            global folder_of_saved_files
            folder_of_saved_files = fileparts(full_path);
            folder_of_saved_files = fullfile(folder_of_saved_files, 'machine_label');
            if ~isfolder(folder_of_saved_files)
                mkdir(folder_of_saved_files);
            end
    
            % label head-tail-human-flip
            head_tail_human_flip(mcd);
    
            % machine label
            label_rearranged = machine_label(mcd);
    
            % output
            output_label(label_rearranged, folder_of_saved_files, 'machine_label.csv');
    
            % for taxis
            integrate_into_reorientation_and_eliminate_short_reversal(label_rearranged);
    
            % disp
            disp('Machine Label Finished!');
    
        end
    end
end

disp('Thanks for using!');
disp('See you next time!');
disp('<<<END>>>');