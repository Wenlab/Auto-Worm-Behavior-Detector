function max_continuous_frames = maxContinuousFrames(label_rearranged, label_number)

label_not_0 = label_rearranged(label_rearranged(:,3) == label_number,:);
temp = label_not_0(:,2) - label_not_0(:,1);

end