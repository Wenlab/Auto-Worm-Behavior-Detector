function [curvature_of_centerline_all,time] = get_the_curvature_of_a_period(mcd,start_frame,end_frame)

    n_frames = end_frame - start_frame+1; % number of frames
    n_curvpts = 100; % number of the points of the centerline
    curvature_of_centerline_all = zeros(n_frames,n_curvpts);
    time = zeros(n_frames,1);
    for j = 1:n_frames    
        i = start_frame+j-1;
        centerline = reshape(mcd(i).SegmentedCenterline,2,[]);
        time(j) = mcd(i).TimeElapsed; % time of this frame
        curvature_of_centerline = calculate_the_curvature_of_a_centerline(centerline);    
        curvature_of_centerline_all(j,:) = curvature_of_centerline';
    end
    
end