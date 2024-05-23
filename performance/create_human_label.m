function human_label = create_human_label(human_label_all, consensus_type)

% Get the size of the input array
[nRows, ~] = size(human_label_all);

% Initialize the output array with NaNs
human_label = nan(nRows, 1);

% Check if the consensus_type is valid
if ~ismember(consensus_type, {'unanimous', 'majority', 'plurality'})
    error('Invalid consensus_type. Choose either "unanimous", "majority", or "plurality".');
end

% Assign labels based on the chosen consensus type
for i = 1:nRows
    unique_values = unique(human_label_all(i, :));
    
    if strcmp(consensus_type, 'unanimous')
        if length(unique_values) == 1
            human_label(i) = unique_values; % Assign the value if all elements are the same
        end
    elseif strcmp(consensus_type, 'majority')
        value_counts = histc(human_label_all(i, :), unique_values);
        [max_count, idx] = max(value_counts);
        if max_count > length(human_label_all(i, :)) / 2
            human_label(i) = unique_values(idx); % Assign the majority value
        end
    elseif strcmp(consensus_type, 'plurality')
        value_counts = histc(human_label_all(i, :), unique_values);
        [~, idx] = max(value_counts);
        human_label(i) = unique_values(idx); % Assign the plurality value
    end
    % If not, human_label(i) remains NaN
end

% Calculate the percentage of NaN values
nan_percentage = sum(isnan(human_label)) / length(human_label) * 100;

% Display the results
fprintf('Proportion of frames lacking %s consensus among human experts: %.2f%%\n', consensus_type, nan_percentage);

end