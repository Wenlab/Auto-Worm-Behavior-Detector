% Tukey test of the speed in the real space.
%
% 2023-10-13, Yixuan Li
%

function Tukey_test_of_speed(path_length_sum_all, t_threshold, speed_threshold)

% histogram
figure;
histogram(path_length_sum_all);
xlabel(sprintf('path length of %d second (mm)',t_threshold));
ylabel('counts');
title(sprintf('f(path length of %d second)',t_threshold));

% perform Tukey test
IQR_index = 1.5; % super parameter % bigger, stricter
[~, ~, ~, ~,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(path_length_sum_all, IQR_index);

% add annotation to the histogram
annotation('textbox', [0.8, 0.8, 0.1, 0.1], 'String', sprintf('IQR index = %0.1f',IQR_index));

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

% add line
xline(speed_threshold,'green--', 'Label', sprintf('%0.2f mm',speed_threshold), 'LineWidth', 2);

end