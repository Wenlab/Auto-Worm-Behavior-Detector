% for motion states which are shorter than frame_window, make it be the same
% as the pre motion state.
%
% 2023-09-16 Yixuan Li
%

function label_rearranged = my_smooth(label_rearranged)

global frame_window

% for the first motion state
for i = 1
    if label_rearranged(i,2) - label_rearranged(i,1) <= frame_window
        label_rearranged(i,3) = label_rearranged(i + 1,3);
    end
end

% for other motion state
for i = 2:length(label_rearranged) 
    if label_rearranged(i,2) - label_rearranged(i,1) <= frame_window
        label_rearranged(i,3) = label_rearranged(i - 1,3);
    end    
end

% re-re-arrange label
label_rearranged = re_rearrange_label(label_rearranged);

end