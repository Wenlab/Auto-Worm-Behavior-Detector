% For unlabelled motion states which are shorter than the t threshold, make
% it be the same as pre or post motion state
%
% 2023-09-16 Yixuan Li
%

function label_rearranged = process_the_unlabelled(label_rearranged)

% set super-parameter
global s2frame
t_threshold = 5; % s
frame_threshold = t_threshold * s2frame;

%% round 1

% if 2 neighbors are the same, let it be the same as its neighbor
for i = 2:length(label_rearranged)-1
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= frame_threshold &&...
            label_rearranged(i-1,3) == label_rearranged(i+1,3)
        label_rearranged(i,3) = label_rearranged(i-1,3);
    end
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

%% round 2

% loop to process each state
label_number = 0;
for i = 2:length(label_rearranged) - 1
    label_rearranged = see_neighbors(label_rearranged,i,label_number,frame_threshold);
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

%% round 3

% for the first motion state
for i = 1
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= frame_threshold
        label_rearranged(i,3) = label_rearranged(i + 1,3);
    end
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

end