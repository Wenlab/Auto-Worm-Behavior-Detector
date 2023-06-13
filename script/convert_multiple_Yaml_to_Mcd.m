% get all yaml2matlab by chosing a filepath (include all subfolders)
clear;clc;close all;

% loading filepath of the code.m
cdpath = mfilename('fullpath');
cdpath = fileparts(cdpath);
cd(cdpath);% enter .m filepath
addpath(genpath('..\')); % add path to use classes

% chose the folder to analyze
path=uigetdir('..\data');

% get .yaml file location
list = GetAllSubfolderFilename(path,'*.yaml');

[indx,tf] = listdlg('ListString',list,'ListSize',[500,200],...
        'Name','Chose files to convert');%选择对话框

% Read .yaml
if tf==1
for i = indx
    full_path_to_yaml = list{i};
    mcd = Mcd_Frame;
    mcd = mcd.yaml2matlab(full_path_to_yaml); % most time-consuming step
    folder_of_saved_mcd = fileparts(full_path_to_yaml);
    savepath = fullfile(folder_of_saved_mcd, 'mcd.mat');
    save(savepath, 'mcd');
    disp('mcd file saved successfully!');    
end
end

disp('<<<END>>>');