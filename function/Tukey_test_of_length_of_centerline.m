function label = Tukey_test_of_length_of_centerline(label,length_of_centerline)

global label_number_outlier

mask = label == 0; % only label the unlabelled
length_of_centerline = length_of_centerline(mask);

% histogram
figure;
histogram(length_of_centerline);
xlabel('mm');
title('f(Length of Centerline)');

% adjust IQR_index
% IQR_index_max = 20;
% table = plot_number_of_outliers_vs_IQR_index(length_of_centerline, IQR_index_max);

% perform Tukey test
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
    label(mask) = mask_down + mask_up * label_number_outlier;
else
    label(mask) = mask_up * label_number_outlier;
end

end