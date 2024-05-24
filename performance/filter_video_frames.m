function filter_video_frames(input_video_file, output_video_file, rows_with_more_than_one_value)

% FILTER_VIDEO_FRAMES Filters frames of a video based on a logical array
%
% INPUTS:
%   input_video_file - String, path to the input video file
%   output_video_file - String, path to the output video file
%   rows_with_more_than_one_value - Logical array, indicating which frames to include
%
% This function reads the input video file frame by frame, checks each
% frame against the provided logical array, and writes the selected frames
% to the output video file.

% Create a video reader object to read frames from the input video
video_reader = VideoReader(input_video_file);

% Create a video writer object to write frames to the output video
video_writer = VideoWriter(output_video_file, 'MPEG-4');
open(video_writer);

% Number of frames in the video
num_frames = floor(video_reader.Duration * video_reader.FrameRate);

% Ensure the logical array length matches the number of frames
if length(rows_with_more_than_one_value) ~= num_frames
    error('The length of rows_with_more_than_one_value must match the number of frames in the video.');
end

% Initialize frame index
frame_idx = 1;

% Loop through each frame in the video
while hasFrame(video_reader)
    % Read the current frame
    frame = readFrame(video_reader);

    % Check if the current frame should be included based on the logical array
    if rows_with_more_than_one_value(frame_idx)
        % Write the frame to the new video if it meets the condition
        writeVideo(video_writer, frame);
    end

    % Increment the frame index
    frame_idx = frame_idx + 1;
end

% Close the video writer object to finalize the output video file
close(video_writer);

% Display a message indicating the new video has been created
disp('New video has been created with selected frames.');
end