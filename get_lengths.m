function lengths_of_centerlines = get_lengths(all_centerline)
n_frames = length(all_centerline);
lengths_of_centerlines = zeros(n_frames,1);
for i = 1:n_frames
    centerline = all_centerline{i,1};
    lengths_of_centerlines(i) = calculate_the_length_of_a_centerline(centerline);
end
end