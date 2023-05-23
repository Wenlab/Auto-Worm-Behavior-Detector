x = 1:0.1:10;
y = sin(x);

figure;
plot(x, y)
hold on

% Add a vertical line at a specific position
xline(5);

% Customize the line appearance
xline(7, 'Label', 'Vertical Line at x = 3','Color', 'red', 'LineStyle', '--', 'LineWidth', 2);

% Add a label to the line
xline(3, 'Label', 'Vertical Line at x = 3', 'LabelHorizontalAlignment', 'left');

hold off
