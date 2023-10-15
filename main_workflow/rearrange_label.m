% Arrange label from n_frame*1 to n_motion_state*3
%
% 2023-10-13, Yixuan Li
%

function label_rearranged = rearrange_label(label)

% Find the indices where the labels change
label_change_indices = find(diff(label) ~= 0);

% Determine the start and end indices for each label sequence
start_indices = [1; label_change_indices + 1];
end_indices = [label_change_indices; numel(label)];

% Create the result array
label_rearranged = [start_indices, end_indices, label(start_indices)];

end