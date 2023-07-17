root_folder = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\data\Colbert\N2_taxis\Or20230322\w2';

% Load the csv file
T = readtable(fullfile(root_folder,'machine_label','machine_label.csv'));

% Load the video
v = VideoReader(fullfile(root_folder,'20230322_2050_w2_HUDS.avi'));
vw = VideoWriter(fullfile(root_folder,'labelled_video_frame_window_10.avi'));
open(vw);

while hasFrame(v)
    % Read the frame
    frame = readFrame(v);
    
    % Check if this frame is within the start and end frame of any of the motions in the csv
    for i = 1:size(T, 1)
        if T.start_frame(i) <= v.CurrentTime*v.FrameRate && v.CurrentTime*v.FrameRate <= T.end_frame(i)
            % Write the label on the frame
            frame = insertText(frame, [376, 50], T.label(i), 'FontSize', 18, 'BoxColor', 'red', 'BoxOpacity', 0.4);
        end
    end
    
    % Write the frame into the new video file
    writeVideo(vw, frame);
end

% Close the new video file
close(vw);