function [length_of_centerline,centerline_all] = get_data_needed(mcd)

n_frames = length(mcd);
length_of_centerline = zeros(n_frames,1);
length_of_Boundary_A = zeros(n_frames,1);
length_of_Boundary_B = zeros(n_frames,1);
centerline_all = cell(n_frames,1);
for i = 1:n_frames
    
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);
    boundary_A = convertCoordinates(mcd(i).BoundaryA, mcd(i).StagePosition);
    boundary_B = convertCoordinates(mcd(i).BoundaryB, mcd(i).StagePosition);
    
    length_of_centerline(i) = calculate_the_length_of_a_centerline(centerline);
    length_of_Boundary_A(i) = calculate_the_length_of_a_centerline(boundary_A);
    length_of_Boundary_B(i) = calculate_the_length_of_a_centerline(boundary_B);
    
    centerline_all{i,1} = centerline;
    
end

% plot histogram
data = {length_of_centerline, length_of_Boundary_A, length_of_Boundary_B};
titles = {'Length of Centerline', 'Length of Boundary A', 'Length of Boundary B'};
for i = 1:1
    figure;
    histogram(data{i});
    xlabel('mm');
    title(['f(' titles{i} ')']);
end

end