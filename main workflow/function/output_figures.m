function output_figures(folder_of_saved_files)

% Get the handles of all open figures
figHandles = findall(0, 'Type', 'figure');

% Loop through each figure and save it
for i = numel(figHandles) - 1:-1:1 % the app will be recognized as a fig, so from end to start
    
    % Generate a unique file name for each figure
    fileName = sprintf('figure%d.png', numel(figHandles) - i);
    
    % Set the current figure
    figure(figHandles(i));
    
    % Save the figure
    saveas(figHandles(i), fullfile(folder_of_saved_files, fileName));
    
end

disp('figures saved successfully.');

close all;

end