% If a neighbor is label_number_outlier or 1 or 3, let it be the same as it.
% Priority: label_number_outlier > 1 > 3 > 2
% In China, we call this as "近朱者赤，近墨者黑".
%
% 2023-09-18 Yixuan Li
%

function label_rearranged = see_neighbors(label_rearranged,i,label_number,frame_threshold)

global label_number_outlier
if label_rearranged(i,3) == label_number &&...
        label_rearranged(i,2) - label_rearranged(i,1) <= frame_threshold &&...
        (label_rearranged(i-1,3) == label_number_outlier || label_rearranged(i+1,3) == label_number_outlier)
    label_rearranged(i,3) = label_number_outlier;
elseif label_rearranged(i,3) == label_number &&...
        label_rearranged(i,2) - label_rearranged(i,1) <= frame_threshold &&...
        (label_rearranged(i-1,3) == 1 || label_rearranged(i+1,3) == 1)
    label_rearranged(i,3) = 1;
elseif label_rearranged(i,3) == label_number &&...
        label_rearranged(i,2) - label_rearranged(i,1) <= frame_threshold &&...
        (label_rearranged(i-1,3) == 3 || label_rearranged(i+1,3) == 3)
    label_rearranged(i,3) = 3;
end

end