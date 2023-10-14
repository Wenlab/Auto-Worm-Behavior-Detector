% Get all centerline (mm) in the absolute reference frame of a single mcd.mat.
%
% 2023-10-13, Yixuan Li
%

function all_centerline = get_all_centerlines_in_absolute_frame(mcd)

n_frames = length(mcd);
all_centerline = cell(n_frames,1);
for i = 1:n_frames    
    centerline = convert_coordinates_and_add_stage_position(mcd(i).SegmentedCenterline, mcd(i).StagePosition);    
    all_centerline{i,1} = centerline;    
end

end