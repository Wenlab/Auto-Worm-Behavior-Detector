function human_label = create_human_label_unanimous_vote(human_label_all)

% Get the size of the input array
[nRows, ~] = size(human_label_all);

% Initialize the output array with NaNs
human_label = nan(nRows, 1);

% Check if all values in a row are the same and assign the value to human_label
for i = 1:nRows
    unique_values = unique(human_label_all(i, :));
    if length(unique_values) == 1
        human_label(i) = unique_values; % Assign the value if all elements are the same
    end
    % If not, human_label(i) remains NaN
end

% disp

% Calculate the percentage of NaN values
nan_percentage = sum(isnan(human_label)) / length(human_label) * 100;

% Display the results
fprintf('Proportion of frames lacking unanimous consensus among human experts: %.2f%%\n', nan_percentage);

end