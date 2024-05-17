% Save label_rearranged to a .csv file.
%
% 2023-10-13, Yixuan Li
%

function output_label(label_rearranged, folder_of_saved_files, file_name, mcd)

% Define the header row
header = {'start_frame', 'end_frame', 'label'};

% Combine the header row and result array
label_rearranged = [header; num2cell(label_rearranged)];

% add an explanation column for each number of label
label_rearranged = add_time_column(label_rearranged, mcd);

% Save the output to a CSV file
full_path = fullfile(folder_of_saved_files,file_name);
writecell(label_rearranged, full_path, 'Delimiter', ',');

% disp
disp('csv file saved successfully.');

end