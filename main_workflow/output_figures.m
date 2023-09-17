function output_figures(folder_of_saved_files, n_figs)

% Loop through each figure and save it
for i = 1:n_figs
    
    % Generate a unique file name for each figure
    file_name = sprintf('figure_%d.png', i);
    
    % Set the current figure
    figure(i);
    
    % Save the figure
    saveas(figure(i), fullfile(folder_of_saved_files, file_name));
    
end

disp('figures saved successfully.');

close all;

end