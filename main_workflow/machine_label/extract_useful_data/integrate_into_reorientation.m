% Integrate reversal, turn and roaming into reorientation
%
% 2023-10-13, Yixuan Li
%

function integrate_into_reorientation(label_rearranged, timestamps)

%% integrate turn and reversal into reorientation
label_rearranged = integrate_into_reorientation_and_eliminate_short_run(label_rearranged);

%% save
global folder_of_saved_files frame_window
file_name = ['machine_label_v2_frame_window_' num2str(frame_window) '.csv'];
output_label_test(label_rearranged, folder_of_saved_files, file_name, timestamps)

end