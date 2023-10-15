% Get the curvature of the centerline for a period.
%
% start_frame and end_frame are a number.
%
% 2023-10-13, Yixuan Li
%

function [curvature_of_centerline_all,time] = get_the_curvature_of_a_period(mcd,start_frame,end_frame)

% number of frames
n_frames = end_frame - start_frame + 1;

% number of the points of the centerline
n_curvpts = 100;

% init
curvature_of_centerline_all = zeros(n_frames,n_curvpts);
time = zeros(n_frames,1);

% loop to process each frame
for j = 1:n_frames

    % frame now
    i = start_frame+j-1;

    % time of this frame
    time(j) = mcd(i).TimeElapsed; 

    % get the centerline (pixel) in the relative frame
    centerline = reshape(mcd(i).SegmentedCenterline,2,[]);

    % calculate the curvature
    curvature_of_centerline = calculate_the_curvature_of_a_centerline(centerline);

    % save
    curvature_of_centerline_all(j,:) = curvature_of_centerline';

end

end