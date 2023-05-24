function label_rearranged = machine_label(mcd)

%% get centerline
global s2frame
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

%% process NaN
label_number_outlier = 100;
mask = isnan(length_of_centerline);
label = zeros(n_frames,1);
label(mask) = label_number_outlier;
length_of_centerline = length_of_centerline(~mask);

%% label turn: round 1, using length of the centerline
% Tukey test

% adjust IQR_index
% IQR_index_max = 20;
% table = plot_number_of_outliers_vs_IQR_index(length_of_centerline, IQR_index_max);

IQR_index = 2; % a super parameter % Smaller, stricter
[~, ~, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(length_of_centerline, IQR_index);

% visulize
median_of_data = prctile(length_of_centerline, 50);
draw_lines(up_limit, down_limit, upper_bound, lower_bound, median_of_data);

% double check
percentile_threshold = 0.75;
length_threshold = median_of_data * percentile_threshold; % mm
t_threshold = 2; % smask_down
is_passed_2 = double_check_for_length_of_centerline(...
    length_of_centerline,...
    length_threshold,...
    t_threshold);

if is_passed_2
    label(~mask) = mask_down + mask_up * label_number_outlier;
else
    label(~mask) = mask_up * label_number_outlier;
end

%% label turn: round 2, using Euclidean distance between head and tail
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
title('f(Euclid distance between head and tail)');

% Tukey test

% adjust IQR_index
% IQR_index_max = 20;
% table_2 = plot_number_of_outliers_vs_IQR_index(Euclid_distance_between_head_and_tail, IQR_index_max);

IQR_index = 2; % a super parameter
[~, ~, ~, mask_down_2,...
    up_limit_2, down_limit_2, upper_bound_2, lower_bound_2] = ...
    Tukey_test(Euclid_distance_between_head_and_tail, IQR_index);

% visulize
draw_lines(up_limit_2, down_limit_2, upper_bound_2, lower_bound_2);

% label v2
label_v2 = label;
label_number = 11;

label_2_v2 = mask_down_2 * label_number;
label_v2(indices_2) = label_2_v2;
label_rearranged_v2 = rearrange_label(label_v2);

% full_path_to_saved_csv = 'C:\Users\11097\Desktop\label_v2.csv';
% output_label(label_rearranged_v2, full_path_to_saved_csv)

% double check
t_threshold_2 = 0.5; % s
is_passed_2 = double_check_for_Euclidean_distance_of_head_and_tail(...
    label_rearranged_v2,...
    label_number,...
    t_threshold_2);
if is_passed_2
    label_2 = mask_down_2 * 1;
    label(indices_2) = label_2; % if passed, add the result of round 2 to label.
end
label_rearranged = rearrange_label(label);

%% label forward and reversal
eigen_basis = readmatrix('eigen_basis.csv');
for i = 1:length(label_rearranged)
    if ~label_rearranged(i,3)
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        [curvature_of_centerline_all, ~] = get_the_curvature_of_a_period(mcd,...
            start_frame,end_frame);
        frame_window = 10;
        state = get_motion_state(curvature_of_centerline_all, eigen_basis, frame_window);
        for j = 1:length(state) - 1
            label(start_frame+(j-1)*frame_window:start_frame+j*frame_window-1) = state(j);
        end
        j = j + 1;
        label(start_frame+(j-1)*frame_window:end_frame) = state(j);
    end
end

label_rearranged_v3 = rearrange_label(label);

%% smooth to eliminate fluctuation

% <= frame_window
for i = 2:length(label_rearranged_v3) 
    if label_rearranged_v3(i,2) - label_rearranged_v3(i,1) <= frame_window
        label_rearranged_v3(i,3) = label_rearranged_v3(i - 1,3);
    end    
end
label_rearranged_v3 = re_rearrange_label(label_rearranged_v3);

% for the unlabeled < t_threshold, if 2 neighbors are the same, let it be the same as its neighbor
t_threshold = 2; % s
for i = 2:length(label_rearranged_v3)-1
    if label_rearranged_v3(i,3) == 0 &&...
            label_rearranged_v3(i,2) - label_rearranged_v3(i,1) <= t_threshold*s2frame &&...
            label_rearranged_v3(i-1,3) == label_rearranged_v3(i+1,3)            
        label_rearranged_v3(i,3) = label_rearranged_v3(i-1,3);
    end
end
label_rearranged_v3 = re_rearrange_label(label_rearranged_v3);

% for the unlabeled < t_threshold, if a neighbor is 1 or 3, let it be the
% same as it. PS: 1's priority is higher than 3's
for i = 2:length(label_rearranged_v3)-1
    
    if label_rearranged_v3(i,3) == 0 &&...
            label_rearranged_v3(i,2) - label_rearranged_v3(i,1) <= t_threshold*s2frame &&...
            (label_rearranged_v3(i-1,3) == 1 || label_rearranged_v3(i+1,3) == 1)
        label_rearranged_v3(i,3) = 1;
    elseif label_rearranged_v3(i,3) == 0 &&...
            label_rearranged_v3(i,2) - label_rearranged_v3(i,1) <= t_threshold*s2frame &&...
            (label_rearranged_v3(i-1,3) == 3 || label_rearranged_v3(i+1,3) == 3)
        label_rearranged_v3(i,3) = 3;
    end

end
label_rearranged_v3 = re_rearrange_label(label_rearranged_v3);
label_rearranged = label_rearranged_v3;

%% process neighbor of turns
t_threshold_forward = 1.5; % s
t_threshold_reversal = 1;
for i = 2:length(label_rearranged)-1    
    if label_rearranged(i,3) == 1
        
        % last neighbor should not be short forward
        if label_rearranged(i-1,3) == 2 &&...
                label_rearranged(i-1,2) - label_rearranged(i-1,1) <= t_threshold_forward*s2frame
            label_rearranged(i-1,3) = 1;
        end
        
        % next neighbor should not be short reversal
        if label_rearranged(i+1,3) == 3 &&...
                label_rearranged(i+1,2) - label_rearranged(i+1,1) <= t_threshold_reversal*s2frame
            label_rearranged(i+1,3) = 1;
        end
        
    end    
end
label_rearranged = re_rearrange_label(label_rearranged);

label_rearranged = integrate_into_reorientation_and_eliminate_short_reversal(label_rearranged);

end