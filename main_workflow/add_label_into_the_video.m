% Add label into the video

clc;clear;close all;

% add path
my_add_path

% chose the folder of files
path = uigetdir;

% if at least 1 file is choosed
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'machine_label*.csv');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf==1
        for i = indx

            % Load the csv file
            full_path_to_csv = list{i};
            label_table = readtable(full_path_to_csv);

            % get the root folder
            root_folder = fileparts(fileparts(full_path_to_csv));

            % read
            files = dir(fullfile(root_folder, '*HUDS.avi'));
            if length(files) ~= 1
                error("More than 1 HUDS.avi file or no HUDS.avi file in this folder!");
            end
            full_path_to_HUDS = fullfile(files(1).folder, files(1).name);
            v = VideoReader(full_path_to_HUDS);

            % write
            [~,file_name_of_HUDS,~] = fileparts(full_path_to_HUDS);
            [~,file_name_of_csv,~] = fileparts(full_path_to_csv);
            file_name_of_labelled_video = [file_name_of_HUDS '_labelled_by_' file_name_of_csv '.avi'];
            full_path_to_labelled_video = fullfile(root_folder,file_name_of_labelled_video);
            vw = VideoWriter(full_path_to_labelled_video);
            open(vw);

            % write
            count_motion_state = 1; % Index of the motion we're currently processing
            while hasFrame(v)

                % Read the frame
                frame = readFrame(v);
                n_frame_now = v.CurrentTime*v.FrameRate;

                % Check if we've reached the start of the next motion state
                if count_motion_state <= size(label_table, 1) - 1 && n_frame_now >= label_table.start_frame(count_motion_state + 1)
                    count_motion_state = count_motion_state + 1;
                end

                % Check if this frame is within the start and end frame of any of the motions in the csv
                if label_table.start_frame(count_motion_state) <= n_frame_now && n_frame_now <= label_table.end_frame(count_motion_state)
                    label_str = string(label_table.label{int32(count_motion_state)});
                    frame = add_label_into_a_frame(frame, label_str);
                end

                % Write the frame into the new video file
                writeVideo(vw, frame);
                
                % disp
                if ~mod(n_frame_now,10000)
                    disp([num2str(n_frame_now) ' frames has been processed!']);
                end

            end

            % Close the new video file
            close(vw);
            disp('Labelled Video Finished!');
        end
    end
    disp('<<<END>>>');
end

function frame = add_label_into_a_frame(frame, label_str)

% Initialize a map to associate labels with colors
color_map = containers.Map({'forward', 'reversal', 'turn', 'unlabelled', 'outlier', 'reorientation'},...
    {'blue', 'red', 'green', 'cyan', 'magenta', 'red'});

% Get the label as a string
color_str = color_map(label_str);

% Write the label on the frame
frame = insertText(frame, [376, 50], label_str, 'FontSize', 18, 'BoxColor', color_str, 'BoxOpacity', 0.4);

end