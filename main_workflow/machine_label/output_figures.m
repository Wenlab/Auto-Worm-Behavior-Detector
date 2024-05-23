% Save all figures and then close them.
%
% 2023-10-13, Yixuan Li
%

function output_figures(folder_of_saved_files, n_figs)

% Loop to save each figure
for i = 1:n_figs
    
    % Generate a unique file name for each figure
    file_name = sprintf('figure_%d.png', i);
    
    % Set the current figure
    figure(i);
    
    % Save the figure
    saveas(figure(i), fullfile(folder_of_saved_files, file_name));
    
end

% disp
disp('figures saved successfully.');

% close
close all;

end