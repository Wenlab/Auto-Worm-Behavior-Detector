function output_figures(full_path_to_saved_csv)

% Get the handles of all open figures
figHandles = findall(0, 'Type', 'figure');

% Loop through each figure and save it
for i = numel(figHandles) - 1:-1:1
    
    % Generate a unique file name for each figure
    fileName = sprintf('figure%d.png', numel(figHandles) - i);
    
    % Set the current figure
    figure(figHandles(i));
    
    % Save the figure
    saveas(figHandles(i), fullfile(full_path_to_saved_csv, fileName));
    
end

disp('figures saved successfully.');

close all;

end