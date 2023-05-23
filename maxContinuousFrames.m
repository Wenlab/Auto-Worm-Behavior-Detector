function max_continuous_frames = maxContinuousFrames(label_rearranged, label_number)

label_new = label_rearranged(label_rearranged(:,3) == label_number,:);
max_continuous_frames = max(label_new(:,2) - label_new(:,1));

end