%%
% Sample N x 5 matrix
A = human_label_all;

% Find the number of unique values in each row
num_unique = sum(diff(sort(A, 2), 1, 2) ~= 0, 2) + 1;

% Find rows with more than one unique value
rows_with_more_than_one_value = num_unique > 1;

%
label_rearranged = rearrange_label(num_unique);

%%
% Plot the distribution of the number of unique values
figure;
histogram(num_unique, 'BinMethod', 'integers');
xlabel('Number of Unique Values per Row');
ylabel('Frequency');
title('Distribution of Number of Unique Values per Row');

%%
label_rearranged(:,4) = label_rearranged(:,2) - label_rearranged(:,1);

%%
rows_with_three_values = num_unique == 3;

%%
input_video_file = "F:\Team_Folders\chemo-thermo-taxis\Colbert\data\Human_Label\20220906_0140_w20_HUDS.avi";
output_video_file = "F:\Team_Folders\chemo-thermo-taxis\Colbert\data\Human_Label\20220906_0140_w20_HUDS_filted_by_three_values";
filter_video_frames(input_video_file, output_video_file, rows_with_three_values)