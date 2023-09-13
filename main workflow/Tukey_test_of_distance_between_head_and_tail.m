function label = Tukey_test_of_distance_between_head_and_tail(label,centerline_all)

%% calculate Euclidean distance between head and tail
mask = label == 0; % only label the unlabelled
indices = find(mask);
n_frames_2 = length(indices);
Euclid_distance_between_head_and_tail = zeros(n_frames_2,1);
count = 0;
for i = indices'
    count = count + 1;
    centerline = centerline_all{i,1};
    Euclid_distance_between_head_and_tail(count) = sqrt(sum((centerline(:,1) - centerline(:,100)).^2));
end

% histogram
figure;
histogram(Euclid_distance_between_head_and_tail);
xlabel('Euclidean distance between the head and the tail (mm)');
title('f(Euclidean distance between the head and the tail)');

%% Tukey test
IQR_index = 3; % a super parameter
[~, ~, ~, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(Euclid_distance_between_head_and_tail, IQR_index);

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

%% label v2, to distinguish label of round 1 and round 2
label_v2 = label;
label_number = 11;

label_2_v2 = mask_down * label_number;
label_v2(indices) = label_2_v2;
label_rearranged_v2 = rearrange_label(label_v2); % here, you can output label_v2 to check if a turn is labelled by round 1 or round 2

%% double check
t_threshold_2 = 0.5; % s
is_passed_2 = double_check_for_Euclidean_distance_of_head_and_tail(...
    label_rearranged_v2,...
    label_number,...
    t_threshold_2);
if is_passed_2
    label_2 = mask_down * 1;
    label(indices) = label_2; % if passed, add the result of round 2 to label.
end

end

function adjust_IQR_index(Euclid_distance_between_head_and_tail)
% adjust IQR_index
IQR_index_max = 20;
plot_number_of_outliers_vs_IQR_index(Euclid_distance_between_head_and_tail, IQR_index_max);
end