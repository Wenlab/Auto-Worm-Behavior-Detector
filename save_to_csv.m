function save_to_csv(label_rearranged_2, full_path_to_saved_csv)

% Define the header row
header = {'start frame', 'end frame', 'label'};

% Combine the header row and result array
output = [header; num2cell(label_rearranged_2)];

% Specify the file name
filename = fullfile(full_path_to_saved_csv,'label_sequences.csv');

% Save the output to a CSV file
writecell(output, filename, 'Delimiter', ',');

disp('CSV file saved successfully.');

end