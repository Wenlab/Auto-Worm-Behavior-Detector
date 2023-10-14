% Get centerlines before unit conversion and add stage position
%
% 2023-10-13, Yixuan Li
%

function [centerline_all,boundary_A_all,boundary_B_all] = get_centerlines_in_relative_frame(mcd,start_frame,end_frame)

n_frames = end_frame - start_frame + 1;
centerline_all = cell(n_frames,1);
boundary_A_all = cell(n_frames,1);
boundary_B_all = cell(n_frames,1);
count = 0;
for i = start_frame:end_frame
    count = count + 1;
    centerline_all{count,1} = reshape(mcd(i).SegmentedCenterline,2,100);
    boundary_A_all{count,1} = reshape(mcd(i).BoundaryA,2,100);
    boundary_B_all{count,1} = reshape(mcd(i).BoundaryB,2,100);
end

end