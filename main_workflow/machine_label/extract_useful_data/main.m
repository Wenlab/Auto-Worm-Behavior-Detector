% centerlines_camera: Array of centerlines in camera coordinates - N*1 cell array.
% centerlines_lab: Array of centerlines in laboratory coordinates - N*1 cell array.
% v: Velocity of the mass center in laboratory coordinates - N*1 numerical array.
% timestamps: Timestamps for each frame - N*1 numerical array.
% idx_beyond_edge: Boolean array marking frames with the worm's tail beyond the camera edge - N*1 Boolean array.

%
dbstop if error

% save
global folder_of_saved_files
folder_of_saved_files = "F:\Desktop\figures";

% extract useful data
[centerlines_camera, centerlines_lab, timestamps, idx_beyond_edge] = extract_useful_data(mcd);

% label head-tail-human-flip
head_tail_human_flip_test(centerlines_camera, timestamps);

% machine label
label_rearranged = machine_label_test(centerlines_camera, centerlines_lab, timestamps, idx_beyond_edge);

% output
global frame_window
file_name = ['machine_label_frame_window_' num2str(frame_window) '.csv'];
output_label_test(label_rearranged, folder_of_saved_files, file_name, timestamps);