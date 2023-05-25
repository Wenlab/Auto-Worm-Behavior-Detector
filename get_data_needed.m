function [length_of_centerline,centerline_all] = get_data_needed(mcd)

n_frames = length(mcd);
length_of_centerline = zeros(n_frames,1);
centerline_all = cell(n_frames,1);
for i = 1:n_frames    
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);    
    length_of_centerline(i) = calculate_the_length_of_a_centerline(centerline);
    centerline_all{i,1} = centerline;    
end

end