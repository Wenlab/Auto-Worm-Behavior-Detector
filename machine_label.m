function label_rearranged = machine_label(mcd)

%% get centerline
n_frames = length(mcd);
length_of_centerline = zeros(n_frames,1);
length_of_Boundary_A = zeros(n_frames,1);
length_of_Boundary_B = zeros(n_frames,1);
centerline_all = cell(n_frames,1);
count = 0;

for i = 1:n_frames
    count = count + 1;
    
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);
    boundary_A = convertCoordinates(mcd(i).BoundaryA, mcd(i).StagePosition);
    boundary_B = convertCoordinates(mcd(i).BoundaryB, mcd(i).StagePosition);
    
    length_of_centerline(i) = calculate_the_length_of_a_centerline(centerline);
    length_of_Boundary_A(i) = calculate_the_length_of_a_centerline(boundary_A);
    length_of_Boundary_B(i) = calculate_the_length_of_a_centerline(boundary_B);
    
    centerline_all{i,1} = centerline;
    
end

data = {length_of_centerline, length_of_Boundary_A, length_of_Boundary_B};
titles = {'Length of Centerline', 'Length of Boundary A', 'Length of Boundary B'};

for i = 1:1
    figure;
    histogram(data{i});
    xlabel('mm');
    title(['f(' titles{i} ')']);
end

%% Tukey test
IQR_index = 2; % a super parameter % Smaller, stricter
[number_of_up_outliers, number_of_down_outliers, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(length_of_centerline, IQR_index);
% IQR_index_max = 20;
% table = plot_number_of_outliers_vs_IQR_index(length_of_centerline, IQR_index_max);

% visulize
draw_4_lines(up_limit, down_limit, upper_bound, lower_bound);

%% label
label = mask_down + mask_up * 2;
% label_rearranged = rearrange_label(label);

%% round 2
mask_2 = label == 0;
indices_2 = find(mask_2);
n_frames_2 = length(indices_2);
Euclid_distance_between_head_and_tail = zeros(n_frames_2,1);
count_2 = 0;
for i = indices_2'
    count_2 = count_2 + 1;
    centerline = centerline_all{i,1};
    Euclid_distance_between_head_and_tail(count_2) = sqrt(sum((centerline(:,1) - centerline(:,100)).^2));
end

figure;
histogram(Euclid_distance_between_head_and_tail);
xlabel('mm');
title(['f(Euclid distance between head and tail)']);

%% Tukey test
IQR_index = 2; % a super parameter % Smaller, stricter
[number_of_up_outliers_2, number_of_down_outliers_2, mask_up_2, mask_down_2,...
    up_limit_2, down_limit_2, upper_bound_2, lower_bound_2] = ...
    Tukey_test(Euclid_distance_between_head_and_tail, IQR_index);
% IQR_index_max = 20;
% table_2 = plot_number_of_outliers_vs_IQR_index(Euclid_distance_between_head_and_tail, IQR_index_max);

% visulize
draw_4_lines(up_limit_2, down_limit_2, upper_bound_2, lower_bound_2);

%% label
label_v2 = label;

label_2 = mask_down_2*1;
label(indices_2) = label_2;
label_rearranged = rearrange_label(label);

%% label v2
label_2_v2 = mask_down_2*11;
label_v2(indices_2) = label_2_v2;
label_rearranged_v2 = rearrange_label(label_v2);

full_path_to_saved_csv = 'C:\Users\11097\Desktop\label_v2.csv';
output_label(label_rearranged_v2, full_path_to_saved_csv)

end