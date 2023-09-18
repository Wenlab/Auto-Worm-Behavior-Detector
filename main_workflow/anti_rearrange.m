% from label_rearranged, reconstruct label
%
% 2023-09-18 Yixuan Li
%

function label = anti_rearrange(label_rearranged)

n_frames = label_rearranged(size(label_rearranged,1),2);
label = nan(n_frames,1);
for i = 1:size(label_rearranged,1)
    start_frame = label_rearranged(i,1);
    end_frame = label_rearranged(i,2);
    label(start_frame:end_frame) = label_rearranged(i,3);
end

end