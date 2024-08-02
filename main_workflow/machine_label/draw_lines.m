% Draw 4 lines
%
% 2023-09-15 Yixuan Li
%

function draw_lines(up_limit, down_limit, upper_bound, lower_bound, median_of_data)

% draw 4 lines
xline(up_limit,'red--', 'Label', 'up limit','LineWidth', 2);
xline(down_limit,'red--', 'Label', 'down limit','LineWidth', 2);
xline(upper_bound,'blue--', 'Label', '75% percentile', 'LineWidth', 2);
xline(lower_bound,'blue--', 'Label', '25% percentile', 'LineWidth', 2);

% make the figure size be full-screen
set(gcf, 'WindowState', 'maximized');

% for the double check of length of centerline.
if nargin == 5
    xline(median_of_data,'green--', 'Label', 'median', 'LineWidth', 2);
    xline(median_of_data * 0.75,'green--', 'Label', 'median * 0.75', 'LineWidth', 2);
end

end