% Protect beyond edge situation when labelling turn
%
% 2023-10-13, Yixuan Li
%

function idx_beyond_edge = tail_beyond_edge(mcd)

%% get mask
n_frames = numel(mcd);
start_frame = 1;
end_frame = n_frames;
[centerline_all,~,~] = get_centerlines_in_relative_frame(mcd,start_frame,end_frame);

%% if the tail is near edges
pixel_threshold = 10; % super-parameter
[x_max,x_min,y_max,y_min] = detect_edge(centerline_all);
[x_tail,y_tail] = get_tail_coord(centerline_all);
mask_x = abs(x_tail - x_max) < pixel_threshold | abs(x_tail - x_min) < pixel_threshold;
mask_y = abs(y_tail - y_max) < pixel_threshold | abs(y_tail - y_min) < pixel_threshold;
idx_beyond_edge = mask_x | mask_y;

end