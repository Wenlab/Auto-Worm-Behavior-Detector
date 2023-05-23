function draw_4_lines(up_limit, down_limit, upper_bound, lower_bound)

xline(up_limit,'red--', 'Label', 'up limit','LineWidth', 2);
xline(down_limit,'red--', 'Label', 'down limit','LineWidth', 2);
xline(upper_bound,'blue--', 'Label', '75% percentile', 'LineWidth', 2);
xline(lower_bound,'blue--', 'Label', '25% percentile', 'LineWidth', 2);
set(gcf, 'WindowState', 'maximized');

end