% Example array
array = [1; 1; 1; 0; 0; 2; 2; 2; 2; 0; 0; 1; 1; 1; 2; 2; 0; 0; 0; 1; 1; 1];

% Find the indices where the labels change
label_change_indices = find(diff(array) ~= 0);

% Determine the start and end indices for each label sequence
start_indices = [1; label_change_indices + 1];
end_indices = [label_change_indices; numel(array)];

% Create the result array
result = [start_indices, end_indices, array(start_indices)];

% Display the result
disp(result);