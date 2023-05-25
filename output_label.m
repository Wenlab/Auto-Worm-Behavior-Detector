function output_label(label_rearranged, full_path_to_saved_csv)

% Define the header row
header = {'start frame', 'end frame', 'label'};

% Combine the header row and result array
output = [header; num2cell(label_rearranged)];

% add an explanation column for each number of label
output = add_a_new_column(output);

% Save the output to a CSV file
writecell(output, full_path_to_saved_csv, 'Delimiter', ',');

disp('CSV file saved successfully.');

end