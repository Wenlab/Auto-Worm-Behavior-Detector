% generate a .csv file for Runhui to label frames when the head and the
% tail are swapped.
%
% Yixuan Li, 2024-04-29
%

% clear
clear;clc;close all;

% chose the folder of files
path = uigetdir;

% if at least 1 file is choosed
if path ~= 0

    % get full paths of files
    list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(path,'*mcd_corr*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list_mcd,'ListSize',[800,600],'Name','Choose files to convert');

    % if at least 1 file is choosed
    if tf==1
        for i = indx

            % load
            full_path_to_mcd = list_mcd{i};
            mcd = load_mcd(full_path_to_mcd);

            % process
            generate_is_swapped_csv(mcd, full_path_to_mcd);
        end
    end
end