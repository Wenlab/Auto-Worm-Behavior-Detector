function integrate_into_reorientation_and_eliminate_short_run(label_rearranged, mcd)

%% integrate turn and reversal into reorientation
global s2frame
mask = label_rearranged(:,3) == 1 | label_rearranged(:,3) == 3 | label_rearranged(:,3) == 4;
label_rearranged(mask,3) = 200;

% rearrange
label_rearranged = re_rearrange_label(label_rearranged);

%% eliminate runs shorter than threshold

% label as reorientation
t_threshold_run = 5; % s
for i = 2:length(label_rearranged) - 1
    if label_rearranged(i,3) == 2 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold_run*s2frame
        label_rearranged(i,3) = 200;
    end
end

% for the first and the last, label as unlabelled
for i = [1,length(label_rearranged)]
    if label_rearranged(i,3) == 2 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold_run*s2frame
        label_rearranged(i,3) = 0;
    end
end

% rearrange
label_rearranged = re_rearrange_label(label_rearranged);

%% save
global folder_of_saved_files frame_window
file_name = ['machine_label_v2_frame_window_' num2str(frame_window) '.csv'];
output_label(label_rearranged, folder_of_saved_files, file_name, mcd)

end