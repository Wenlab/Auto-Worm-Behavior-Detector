clear;clc;close all;

global folder_of_saved_files

% loading filepath of the code.m
cdpath = mfilename('fullpath');
cdpath = fileparts(cdpath);
cd(cdpath);% enter .m filepath
addpath(genpath('..\')); % add path to use classes

% chose the folder of files
path = uigetdir;

% get full path of files
list = GetAllSubfolderFilename(path,'*mcd_corred.mat');

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
    label_rearranged = machine_label(mcd);    
    output_label(label_rearranged, folder_of_saved_files, 'machine_label.csv');
    output_figures(folder_of_saved_files);
    disp('Machine Label Finished!');
    
end
end

disp('Thanks for using!');
disp('See you next time!');
disp('<<<END>>>');