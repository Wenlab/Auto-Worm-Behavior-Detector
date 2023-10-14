% Fix the problem of coordinates.
%
% In .yaml file, there are 2 problems:
% First, for the mcd.SegmentedCenterline, the y-axis is reversed.
% Second, for the mcd.StagePosition, the x-axis is reversed.
%
% This script fix these 2 problems.
%
% 2023-10-13, Yixuan Li
%

clear;clc;close all;

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
            [save_folder_path,save_file_name,~] = fileparts(full_path_to_mcd);
            save_file_name = strrep(save_file_name,'_mcd','_mcd_corrected');
            save_file_name = strcat(save_file_name,'.mat');
            save_full_path = fullfile(save_folder_path,save_file_name);
            save(save_full_path,'mcd');
            disp('mcd_corrected.mat saved successfully.');
    
        end
    end
end

disp('<<<End>>>');