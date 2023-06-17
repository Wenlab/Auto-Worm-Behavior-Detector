function integrate_into_reorientation_and_eliminate_short_reversal(label_rearranged)

% integrate turn and reversal into reorientation
global s2frame
mask = label_rearranged(:,3) == 1 | label_rearranged(:,3) == 3;
label_rearranged(mask,3) = 200;
label_rearranged = re_rearrange_label(label_rearranged);
t_threshold_run = 5; % s
for i = 2:length(label_rearranged) - 1
    if label_rearranged(i,3) == 2 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold_run*s2frame
        label_rearranged(i,3) = 200;
    end
end
label_rearranged = re_rearrange_label(label_rearranged);

global folder_of_saved_files
file_name = 'machine_label_v2.csv';
output_label(label_rearranged, folder_of_saved_files, file_name)

end