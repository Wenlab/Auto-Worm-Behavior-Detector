function generate_is_swapped_csv(mcd, full_path_to_mcd)

% generate a .csv file for Runhui to label frames when the head and the
% tail are swapped.
%
% Yixuan Li, 2024-04-29
%

% path
[folder_path_to_mcd, file_name_of_mcd] = fileparts(full_path_to_mcd);

% name
if contains(file_name_of_mcd,"flipped")
    file_name_of_csv = strrep(file_name_of_mcd,"_mcd_corrected_flipped","_Are_the_Head_and_the_Tail_Swapped.csv");
else
    file_name_of_csv = strrep(file_name_of_mcd,"_mcd_corrected","_Are_the_Head_and_the_Tail_Swapped.csv");
end
full_path_to_csv = fullfile(folder_path_to_mcd, file_name_of_csv);

% save
n_frame = length(mcd);

% Assuming mcd is a structure with relevant information. You'll need to
% adjust the field names based on your actual mcd structure
start_frame = 1; % starting frame
end_frame = n_frame; % ending frame, replace with your own logic if needed
Is_Swapped = "FALSE"; % create a string array of "FALSE"

% Create table with the data
T = table(start_frame, end_frame, Is_Swapped);

% Write the table to a CSV file
writetable(T, full_path_to_csv);

% Disp
disp("Is_Swapped.csv is generated successfully.");

end