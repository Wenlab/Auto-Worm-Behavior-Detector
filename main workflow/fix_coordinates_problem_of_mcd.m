% Fix the problem of coordinates.
% In .yaml file, there are 2 problems:
% For the mcd.SegmentedCenterline, the y-axis is reversed.
% For the mcd.StagePosition, the x-axis is reversed.
% This script fix these 2 problems.

clear;clc;close all;

% add path
my_add_path;

% chose the folder of files
path = uigetdir;

% if at least 1 file is choosed
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*mcd.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],...
        'Name','Chose files to convert');
    
    % if at least 1 file is choosed
    if tf==1
        for i = indx
            
            % load
            full_path_to_mcd = list{i};
            mcd = load_mcd(full_path_to_mcd);
    
            % correct
            for j=1:length(mcd)
                mcd(j).Head(2)=-mcd(j).Head(2);
                mcd(j).Tail(2)=-mcd(j).Tail(2);
                mcd(j).BoundaryA(2:2:200)=-mcd(j).BoundaryA(2:2:200);
                mcd(j).BoundaryB(2:2:200)=-mcd(j).BoundaryB(2:2:200);
                mcd(j).SegmentedCenterline(2:2:200)=-mcd(j).SegmentedCenterline(2:2:200);
                mcd(j).StageFeedbackTarget(2)=-mcd(j).StageFeedbackTarget(2); % ?
                mcd(j).StagePosition(1)=-mcd(j).StagePosition(1);
            end
    
            % save
            [folder_path_save,~,~] = fileparts(full_path_to_mcd);
            file_name_save = 'mcd_corrected.mat';
            full_path_save = fullfile(folder_path_save,file_name_save);
            save(full_path_save,'mcd');
            disp('mcd_corrected.mat saved successfully.');
    
        end
    end
end

disp('<<<End>>>');