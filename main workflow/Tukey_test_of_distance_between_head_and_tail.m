function label = Tukey_test_of_distance_between_head_and_tail(label,centerline_all)

%% Tukey test

% only label the unlabelled
mask = label == 0;
indices = find(mask);
n_frames_2 = length(indices);

% calculate Euclidean distance between head and tail
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

% perform Tukey test
IQR_index = 3; % super parameter % bigger, stricter
[~, ~, ~, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(Euclid_distance_between_head_and_tail, IQR_index);

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

%% add label
global label_number_outlier
label(indices) = mask_down * 1 + mask_up * label_number_outlier;

% %% label v2, to distinguish label of round 1 and round 2
% label_v2 = label;
% label_number = 11;
% 
% label_2_v2 = mask_down * label_number;
% label_v2(indices) = label_2_v2;
% label_rearranged_v2 = rearrange_label(label_v2);
% 
% %% double check
% 
% t_threshold_2 = 0.5; % s
% 
% is_passed_2 = double_check_for_Euclidean_distance_of_head_and_tail(...
%     label_rearranged_v2,...
%     label_number,...
%     t_threshold_2);
% 
% if is_passed_2
%     label(indices) = mask_down * 1; % if passed, add the result of round 2 to label.
% end

end