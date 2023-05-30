function output_label(label_rearranged, folder_of_saved_files, filename)

% Define the header row
header = {'start frame', 'end frame', 'label'};

% Combine the header row and result array
output = [header; num2cell(label_rearranged)];

% add an explanation column for each number of label
output = add_a_new_column(output);

% Save the output to a CSV file
full_path = fullfile(folder_of_saved_files,filename);
writecell(output, full_path, 'Delimiter', ',');

disp('csv file saved successfully.');

end