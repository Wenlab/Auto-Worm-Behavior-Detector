% for unlabelled motion states which are shorter than 5s, make it be the
% same as pre or post motion state
%
% 2023-09-16 Yixuan Li
%

function label_rearranged = process_the_unlabelled(label_rearranged)

global s2frame

% set super-parameter
t_threshold = 5; % s

% if 2 neighbors are the same, let it be the same as its neighbor
for i = 2:length(label_rearranged)-1
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            label_rearranged(i-1,3) == label_rearranged(i+1,3)
        label_rearranged(i,3) = label_rearranged(i-1,3);
    end
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

% if a neighbor is 1 or 3, let it be the same as it. Priority: 100 > 1 > 3 > 2
for i = 2:length(label_rearranged)-1
    
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            (label_rearranged(i-1,3) == 100 || label_rearranged(i+1,3) == 100)
        label_rearranged(i,3) = 100;
    elseif label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            (label_rearranged(i-1,3) == 1 || label_rearranged(i+1,3) == 1)
        label_rearranged(i,3) = 1;
    elseif label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            (label_rearranged(i-1,3) == 3 || label_rearranged(i+1,3) == 3)
        label_rearranged(i,3) = 3;
    end
    
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

% for the first motion state
for i = 1
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame
        label_rearranged(i,3) = label_rearranged(i + 1,3);
    end
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

end