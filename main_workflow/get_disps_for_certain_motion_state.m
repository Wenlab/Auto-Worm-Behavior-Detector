function disps = get_disps_for_certain_motion_state(mcd, label_rearranged, label_number)

rows_wanted = label_rearranged(label_rearranged(:,3) == label_number,:);
disps = get_disps(mcd,rows_wanted(:,1),rows_wanted(:,2));

end