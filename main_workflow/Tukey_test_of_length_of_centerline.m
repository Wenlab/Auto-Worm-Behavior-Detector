function label = Tukey_test_of_length_of_centerline(label,length_of_centerline)

%% Tukey test

% only label the unlabelled
mask = label == 0;
length_of_centerline = length_of_centerline(mask);

% histogram
figure;
histogram(length_of_centerline);
xlabel('Length of the centerline (mm)');
ylabel('number of frames');
title('f(Length of the centerline)');

% perform Tukey test
IQR_index = 3; % super parameter % bigger, stricter
[~, ~, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(length_of_centerline, IQR_index);

% visulize
median_of_data = prctile(length_of_centerline, 50);
draw_lines(up_limit, down_limit, upper_bound, lower_bound, median_of_data);

%% double check

% set an absolute threshold
percentile_threshold = 0.75;
length_threshold = median_of_data * percentile_threshold; % mm
t_threshold = 2; % s
is_passed_2 = double_check_for_length_of_centerline(...
    length_of_centerline,...
    length_threshold,...
    t_threshold);

if is_passed_2

    % if pass, label up as outlier and down as turn
    global label_number_outlier
    label(mask) = mask_down + mask_up * label_number_outlier;

else

    % if not pass, only label up as outlier
    label(mask) = mask_up * label_number_outlier;

end

end