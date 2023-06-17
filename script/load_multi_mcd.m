clear;clc;close all;

global folder_of_saved_files

% chose the folder of files
path = uigetdir;

% get full path of files
list = GetAllSubfolderFilename(path,'*mcd*.mat');

% choose files
[indx,tf] = listdlg('ListString',list,'ListSize',[500,200],...
    'Name','Chose files to convert');

% Read .yaml
if tf==1

    for i = indx

        full_path = list{i};
        folder_of_saved_files = fileparts(full_path);
        folder_of_saved_files = fullfile(folder_of_saved_files, 'machine_label');
        if ~isfolder(folder_of_saved_files)
            mkdir(folder_of_saved_files);
        end

        mcd = input_data(full_path);
        all_centerline = get_all_centerline(mcd);
        label_rearranged = machine_label(mcd);

        % output
        output_label(label_rearranged, folder_of_saved_files, 'machine_label.csv');

        % for taxis
        integrate_into_reorientation_and_eliminate_short_reversal(label_rearranged);

        disp('Machine Label Finished!');

    end

end

disp('Thanks for using!');
disp('See you next time!');
disp('<<<END>>>');