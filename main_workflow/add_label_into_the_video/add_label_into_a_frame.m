function frame = add_label_into_a_frame(frame, label_str)

% Initialize a map to associate labels with colors
color_map = containers.Map({'forward', 'reversal', 'turn', 'roaming', 'unlabelled', 'outlier', 'reorientation'},...
    {'blue', 'red', 'green', 'yellow', 'cyan', 'magenta', 'red'});

% Get the label as a string
color_str = color_map(label_str);

% Write the label on the frame
frame = insertText(frame, [376, 50], label_str, 'FontSize', 18, 'BoxColor', color_str, 'BoxOpacity', 0.4);

end