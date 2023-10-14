% Convert multiple .yaml to mcd.mat at one time
%
% 2023-10-13, Yixuan Li
%

clear;clc;close all;

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*.yaml');
    
    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],...
            'Name','Chose files to convert');
    
    % if at least 1 file is choosed
    if tf==1
        for i = indx

            % load and convert
            full_path_to_yaml = list{i};
            mcd = Mcd_Frame;
            mcd = mcd.yaml2matlab(full_path_to_yaml); % most time-consuming step

            % save
            [save_folder_path, save_file_name] = fileparts(full_path_to_yaml);
            save_file_name = strcat(save_file_name,'_mcd.mat');
            save_full_path = fullfile(save_folder_path, save_file_name);
            save(save_full_path, 'mcd');
            disp('mcd.mat saved successfully!');

        end
    end
end

disp('<<<END>>>');