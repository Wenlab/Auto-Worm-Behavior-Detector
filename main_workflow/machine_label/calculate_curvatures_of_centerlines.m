% Get the curvature of the centerline for a period.
%
% start_frame and end_frame are a number.
%
% 2023-10-13, Yixuan Li
%

function curvature_of_centerline_all = calculate_curvatures_of_centerlines(centerlines_camera,start_frame,end_frame)

% number of frames
n_frames = end_frame - start_frame + 1;

% number of the points of the centerline
n_curvpts = 100;

% init
curvature_of_centerline_all = zeros(n_frames,n_curvpts);

% loop to process each frame
for j = 1:n_frames

    % frame now
    i = start_frame + j - 1;

    % get the centerline (pixel) in the relative frame
    centerline_now = centerlines_camera{i};

    % calculate the curvature
    curvature_of_centerline = calculate_the_curvature_of_a_centerline(centerline_now);

    % save
    curvature_of_centerline_all(j,:) = curvature_of_centerline';

end

end