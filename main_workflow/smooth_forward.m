% for forwards which are shorter than t_threshold, make it be the same
% as the pre or post motion state.
%
% 2023-09-18 Yixuan Li
%

function label_rearranged = smooth_forward(label_rearranged)

% set super-parameter
global s2frame
t_threshold = 2;
frame_threshold = t_threshold * s2frame;

% loop to process each state
label_number = 2;
for i = 2:length(label_rearranged) - 1
    label_rearranged = see_neighbors(label_rearranged,i,label_number,frame_threshold);
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

end