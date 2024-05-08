% Get the curvature of the centerline for a period.
%
% start_frame and end_frame are a number.
%
% 2023-10-13, Yixuan Li
%

function [curvature_of_centerline_all,time] = get_the_curvature_of_a_period(mcd,start_frame,end_frame,flag_method)

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
    if nargin == 3
        centerline_now = reshape(mcd(i).SegmentedCenterline,2,[]);
    elseif nargin == 4
        if flag_method == "online"
            centerline_now = reshape(mcd(i).SegmentedCenterline,2,[]);
        elseif flag_method == "offline"
            centerline_now = 0.5*(mcd(i).BoundaryA + mcd(i).BoundaryB);
            centerline_now = reshape(centerline_now,2,[]);
        end
    end

    % calculate the curvature
    curvature_of_centerline = calculate_the_curvature_of_a_centerline(centerline_now);

    % save
    curvature_of_centerline_all(j,:) = curvature_of_centerline';

end

end