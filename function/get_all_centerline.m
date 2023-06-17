function all_centerline = get_all_centerline(mcd)

n_frames = length(mcd);
all_centerline = cell(n_frames,1);
for i = 1:n_frames    
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);    
    all_centerline{i,1} = centerline;    
end

end