% Find frames when users do stop-start.
%
% Attention: Each video must contain only 1 worm!
%
% 2023-10-13, Yixuan Li
%

% clear
clear;clc;close all;

% add path
my_add_path;

% chose the folder of files
path = uigetdir;

% if at least 1 file is choosed
if path ~= 0

    % get full paths of files
    list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(path,'*mcd_corr*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list_mcd,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf==1
        for i = indx

            %% load mcd
            full_path_to_mcd = list_mcd{i};
            mcd = load_mcd(full_path_to_mcd);

            %% find the frame of stop-start
            frames_stop_start = find_frames_of_stop_start(mcd);

            %% if nan
            if numel(frames_stop_start) == 0
                disp("There is no stop-start situation in this mcd.mat!");
                continue;
            end

            %% add frames of stop-start into the csv file
            folder_path_of_mcd = fileparts(full_path_to_mcd);
            list_csv = get_all_files_of_a_certain_type_in_a_rootpath(folder_path_of_mcd,'machine_label*.csv');

            % if contains no suitable csv
            if numel(list_csv) == 0
                error('No machine_label*.csv files in the folder of mcd!');
            end

            % choose files
            [indx,tf] = listdlg('ListString',list_csv,'ListSize',[800,600],'Name','Chose csv files to change');

            % if at least 1 file is choosed
            if tf==1
                for j = indx
                    full_path_to_csv = list_csv{j};
                    label_table = readtable(full_path_to_csv);
                    count = 1;
                    for row = 1:size(label_table,1)
                        frame_target = frames_stop_start(count);

                        % if the frame of stop-start is within a period
                        if label_table.start_frame(row) < frame_target &&...
                                frame_target < label_table.end_frame(row)

                            % insert a new row
                            new_row = table(frame_target + 1,label_table.end_frame(row),label_table.label(row),0,'VariableNames', label_table.Properties.VariableNames);
                            label_table = insert_a_new_row(label_table, new_row, row);

                            % correct the table
                            label_table.end_frame(row) = frame_target;
                            label_table.time_s(row) = mcd(label_table.end_frame(row)).TimeElapsed - mcd(label_table.start_frame(row)).TimeElapsed;
                            label_table.time_s(row+1) = mcd(label_table.end_frame(row+1)).TimeElapsed - mcd(label_table.start_frame(row+1)).TimeElapsed;

                            % update count
                            count = count + 1;

                        elseif label_table.start_frame(row) == frame_target % if exactly right
                            count = count + 1;
                        end

                        % if all frames of stop-start have been processed
                        if count == length(frames_stop_start) + 1
                            writetable(label_table, full_path_to_csv, 'Delimiter', ',');
                            break;
                        end
                    end
                end
            end

            % disp
            disp("Stop-start frames have been changed!");
            
        end
    end
end

disp('Thanks for using!');
disp('See you next time!');
disp('<<<END>>>');

function frames_stop_start = find_frames_of_stop_start(mcd)

frames_stop_start = [];
for j = 1:length(mcd) - 1
    if mcd(j + 1).TimeElapsed - mcd(j).TimeElapsed > 1 % s
        frames_stop_start(end + 1) = j;
    end
end

end

function label_table = insert_a_new_row(label_table, new_row, i)

% insert a new row after i-th row

before_row = label_table(1:i, :);
after_row = label_table((i+1):end, :);
label_table = [before_row; new_row; after_row];

end