function label_rearranged = check_unlabelled(label_rearranged,frame_window)

global s2frame

t_threshold = 5; % s % super-parameter

%% <= frame_window
for i = 2:length(label_rearranged) 
    if label_rearranged(i,2) - label_rearranged(i,1) <= frame_window
        label_rearranged(i,3) = label_rearranged(i - 1,3);
    end    
end
label_rearranged = re_rearrange_label(label_rearranged);

%% for the unlabeled < t_threshold, if 2 neighbors are the same,
% let it be the same as its neighbor
for i = 2:length(label_rearranged)-1
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            label_rearranged(i-1,3) == label_rearranged(i+1,3)            
        label_rearranged(i,3) = label_rearranged(i-1,3);
    end
end
label_rearranged = re_rearrange_label(label_rearranged);

%% for the unlabeled < t_threshold, if a neighbor is 1 or 3
% let it be the same as it. Priority: 1 > 3 > 2
for i = 2:length(label_rearranged)-1
    
    if label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            (label_rearranged(i-1,3) == 1 || label_rearranged(i+1,3) == 1)
        label_rearranged(i,3) = 1;
    elseif label_rearranged(i,3) == 0 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold*s2frame &&...
            (label_rearranged(i-1,3) == 3 || label_rearranged(i+1,3) == 3)
        label_rearranged(i,3) = 3;
    end

end
label_rearranged = re_rearrange_label(label_rearranged);

end