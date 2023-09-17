function add_roaming(mcd,label_rearranged)

% integrate forward and reversal
label_rearranged = integrate_forward_and_reversal(label_rearranged);
label_rearranged = re_rearrange_label(label_rearranged);

% get disps
global label_number_forward_reversal
disps_of_forward_reversal = get_disps_for_certain_motion_state(mcd, label_rearranged, label_number_forward_reversal);

% histogram of mean speed in a frame-window
global s2frame
path_length_sum_all = [];
for i = 1:size(disps_of_forward_reversal,1)
    disp = disps_of_forward_reversal{i,1};
    if size(disp,2) > s2frame
        for j = 1:size(disp,2) - s2frame
            disp_now = disp(:,j:j+s2frame);
            path_length_sum = calculate_path_length(disp_now);
            path_length_sum_all(end+1) = path_length_sum;
        end
    end
end
histogram(path_length_sum_all);
xlabel('path length of a second (mm)');
ylabel('counts');
title('f(path length of a second)');

end