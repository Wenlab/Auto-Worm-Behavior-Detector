% Get points (mm) for certain motion state in label_rearranged.
%
% 2023-10-13, Yixuan Li
%

function points = get_points_for_certain_motion_state(mcd, label_rearranged, label_number)

rows_wanted = label_rearranged(label_rearranged(:,3) == label_number,:);
points = get_points(mcd,rows_wanted(:,1),rows_wanted(:,2));

end